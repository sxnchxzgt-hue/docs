# Despliegue de Staging sobre un VPS con GitHub Actions

## Estado

Aceptada.

## Contexto

El proyecto necesitaba un entorno de staging estable y representativo, apto para demos y para validar funcionalidades en condiciones cercanas a producción antes de promover a `main`. Sobre ese entorno también se quería poder ejecutar pruebas de volumen contra la aplicación real, y no contra contenedores efímeros levantados en una máquina de desarrollo.

Se evaluaron dos caminos: una plataforma en la nube gestionada (con orquestación, balanceo y escalado automático) o un VPS contratado y administrado por el equipo. La opción en la nube aportaba elasticidad, pero a costa de un modelo de gasto variable, mayor complejidad de configuración y menor visibilidad sobre la infraestructura. Para el alcance del proyecto, esos costos superaban a los beneficios.

Pesaron a favor del VPS:

- Un **costo fijo y predecible**, con control total sobre el gasto.
- **Control completo sobre el servidor**, sin las restricciones de una plataforma gestionada.
- La posibilidad de ejecutar **pruebas de carga realistas** sobre la aplicación desplegada.
- Una **dirección IP fija**, que simplificó la configuración del dominio `granbazaar.site`.
- El valor formativo de **configurar y asegurar el servidor** como ejercicio práctico de seguridad informática.

## Decisión

Se decide desplegar staging sobre un **VPS contratado**, sin orquestador ni servicios en la nube, usando un **ejecutor autoalojado** (runner self-hosted) alojado en esa misma máquina y **Docker Compose** invocado por SSH. El flujo se implementa con GitHub Actions y sigue un patrón común a todos los servicios.

El despliegue se dispara únicamente cuando la integración continua (CI) de la rama `staging` finaliza de forma exitosa, mediante el evento `workflow_run`:

```yaml
on:
  workflow_run:
    workflows: ["CI"]
    branches: [staging]
    types: [completed]
  workflow_dispatch:
```

El trabajo se condiciona con `if: github.event.workflow_run.conclusion == 'success'`, de modo que una integración fallida no desencadena despliegue alguno. El `workflow_dispatch` se mantiene disponible para forzar un despliegue manual cuando sea necesario. Dado que el despliegue es un evento independiente de la integración, se fija de forma explícita el commit a desplegar para evitar tomar un HEAD que haya avanzado entretanto:

```yaml
ref: ${{ github.event.workflow_run.head_sha || github.sha }}
```

El flujo se divide en dos trabajos:

1. **`build-push`** — se autentica en GHCR con el `GITHUB_TOKEN` (que ya dispone del permiso `packages: write`) y publica la imagen, construida a partir de un `Dockerfile.staging` propio, con dos etiquetas: `:staging`, que apunta siempre a la última versión, y `:sha-<commit>`, inmutable, que permite identificar la versión desplegada y revertir.
2. **`deploy`** — depende del anterior, de modo que un fallo de construcción no afecta al VPS. Copia el `docker-compose.staging.yml` (y las migraciones, en los servicios que las tienen) por `scp`, accede por `ssh`, ejecuta `docker pull` y reinicia con `docker compose up -d --no-build`. El `--no-build` garantiza que en el VPS no se compila nada: se usa la imagen ya construida en GHCR. Las credenciales de acceso se gestionan mediante secretos (`STAGING_VPS_*`) y el trabajo declara `environment: staging`, lo que habilita incorporar aprobaciones manuales a futuro.

La mayoría de los flujos cierra con una verificación de estado: un bucle de 12 intentos cada 5 segundos (un minuto en total) contra `/readyz` o `/livez`. Si el servicio no responde de forma saludable en ese lapso, el despliegue se marca como fallido.

Aunque el patrón es común, cada repositorio presenta variaciones propias:

| Servicio | Tecnología | Qué hace distinto |
|---|---|---|
| **ApiGateway** (Kong) | Kong | La imagen lleva el propietario en minúsculas porque GHCR no admite mayúsculas. Copia también `config/`. No recurre a `curl`: verifica el estado consultando la salud (`healthy`) del contenedor con `docker inspect` |
| **Backoffice** | React / Vite | Se enlaza con una integración llamada `"CI Pipeline"` y no `"CI"` como el resto. Es el único que pasa argumentos de construcción (`VITE_API_BASE_URL`, `VITE_AUTH0_*`) desde `vars`, ya que en Vite esas variables quedan compiladas dentro del paquete final. No incluye verificación de estado |
| **CatalogService** | Go | `cancel-in-progress: false`, por lo que encola los despliegues en lugar de interrumpirlos. Utiliza caché de construcción (`type=gha`). Copia `migrations/`. Verifica `/product/readyz` |
| **CheckoutOrdersService** | Go | `cancel-in-progress: true`: ante un nuevo despliegue, cancela el anterior. La verificación de estado se realiza en un paso SSH independiente, contra `/orders/readyz` |
| **WishListService** | Go | Análogo a Checkout: cancela el despliegue previo, copia `migrations/` y verifica `/wishlist/readyz` |
| **MetricsService** | Python / MongoDB | Tras la descarga reetiqueta la imagen local como `metricsservice-staging:latest` para que el compose la localice. Usa `docker-compose.staging.yaml`. Verifica `/metrics/livez` |
| **NotificationsService** | Python | Mismo reetiquetado a `:latest`, cancela los despliegues previos y verifica `/notifications/livez` |
| **UserService** | Python | Patrón estándar, reetiquetado a `userservice-staging:latest` y verificación de `/users/livez` |
| **Tracker** | Monitoreo | Constituye el caso excepcional. No construye ninguna imagen propia: se dispara con un `push` directo a `staging` (sin esperar a la integración), copia las configuraciones de `prometheus/`, `loki/`, `promtail/` y `grafana/`, crea la red `granbazaar-monitoring` y levanta el conjunto con imágenes oficiales. Da por válido el despliegue cuando Grafana queda en estado `Up` |

## Consecuencias

Lo que se vuelve más sencillo:

- El **gasto queda acotado y predecible**, sin sorpresas de facturación variable.
- El equipo dispone de **control total sobre el servidor**, lo que habilitó configurar el dominio sobre una dirección IP fija y endurecer la seguridad como ejercicio práctico.
- Es posible correr **pruebas de carga sobre el entorno real**, con resultados más representativos que los de contenedores locales.
- El **flujo es simple y homogéneo**: dar de alta un servicio nuevo se reduce, en lo esencial, a replicar el patrón de cualquiera de los existentes.
- La trazabilidad por `sha-<commit>` y las verificaciones de estado dan **señales claras** de qué versión corre y de si un despliegue quedó sano.

Lo que se vuelve más difícil o queda como riesgo:

- El **ejecutor autoalojado depende de la máquina** que lo aloja: si está apagada o sin conexión, no hay integración ni despliegue. Es un punto único de fallo operativo.
- No hay **escalado automático ni balanceo de carga**: la elasticidad queda limitada a la capacidad del VPS.
</content>
