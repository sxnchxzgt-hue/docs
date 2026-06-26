# Despliegue a Staging

Todo staging vive en un VPS contratado. No hay orquestador ni cloud: un runner self-hosted en esa misma máquina construye la imagen, la sube a GHCR y después entra por SSH a levantar el contenedor con Docker Compose.

---

## Flujo de despliegue

Cuando se integra un cambio a `staging`, primero se ejecuta el CI habitual. El deploy se dispara únicamente cuando ese CI finaliza de forma exitosa, enlazado mediante el evento `workflow_run`:

```yaml
on:
  workflow_run:
    workflows: ["CI"]
    branches: [staging]
    types: [completed]
  workflow_dispatch:
```

El objetivo es no desplegar ningún cambio que no haya superado los tests. Por ese motivo el job se condiciona con `if: github.event.workflow_run.conclusion == 'success'`: si el CI falla, el deploy no se ejecuta. El `workflow_dispatch` se mantiene disponible para poder forzar un despliegue manual desde la pestaña de Actions cuando sea necesario.

Conviene destacar un punto: dado que el deploy es un evento independiente del CI, debe indicársele de forma explícita qué commit utilizar; de lo contrario tomaría el HEAD de la rama, que puede haber avanzado entretanto. Por eso todos los workflows fijan la referencia:

```yaml
ref: ${{ github.event.workflow_run.head_sha || github.sha }}
```

De este modo la imagen construida corresponde exactamente al commit que aprobó el CI.

El workflow se divide en dos jobs. El primero (`build-push`) se autentica en GHCR con el `GITHUB_TOKEN` —que ya dispone del permiso `packages: write`, sin configuración adicional— y publica la imagen con dos etiquetas: `:staging`, que apunta siempre a la última versión, y `:sha-<commit>`, inmutable, que permite identificar qué versión está desplegada y revertir si hiciera falta. La build emplea un `Dockerfile.staging` propio, separado del de desarrollo. El segundo job (`deploy`) depende del primero, de manera que un fallo en la construcción no llega a afectar al VPS.

El despliegue propiamente dicho se resuelve con dos acciones de `appleboy`: una copia el `docker-compose.staging.yml` —y las migraciones, en los servicios que las tienen— mediante `scp`, y la otra accede por `ssh`, ejecuta `docker pull` y reinicia el servicio con `docker compose up -d --no-build`. El `--no-build` es determinante: en el VPS no se compila nada, sino que se descarga la imagen ya construida desde GHCR. Toda la información sensible —host, usuario, clave, puerto y path— se gestiona mediante secrets (`STAGING_VPS_*`), y el job declara `environment: staging`, lo que además habilita incorporar una aprobación manual en el futuro si se decidiera.

La mayoría de los workflows finaliza con un health check: un bucle de 12 intentos cada 5 segundos (un minuto en total) que consulta el endpoint `/readyz` o `/livez` del servicio. Si no responde de forma saludable dentro de ese minuto, el deploy se marca como fallido.
