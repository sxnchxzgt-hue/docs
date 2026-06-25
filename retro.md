# Retrospectiva Final — GranBazaar

**Proyecto:** GranBazaar — E-commerce multirole con arquitectura de microservicios
**Materia:** Ingeniería de Software II — FIUBA
**Fecha:** Junio 2026

---

## Qué salió bien

### Arquitectura de microservicios coherente

Se logró definir y mantener una separación clara de responsabilidades entre los siete servicios. Cada uno tiene su propia base de datos, sus propios Dockerfiles y sus propios entornos de ejecución, sin compartir esquemas ni conexiones. Esta independencia permitió que distintos subgrupos trabajaran en paralelo sin bloquearse entre sí.

### Integración con Auth0 y Kong

La delegación de autenticación al gateway resultó ser una decisión correcta: los microservicios nunca validan tokens JWT, simplemente confían en el header `X-User-Id` inyectado por Kong. Esto simplificó el código de cada servicio y centralizó la lógica de seguridad. Una vez que la configuración de Kong quedó estabilizada, incorporar un nuevo servicio al gateway fue una tarea de minutos.

### Cobertura de tests y CI

Todos los servicios Go y Python cuentan con test suites integradas al pipeline de CI. Se configuraron reportes de cobertura en Codecov y thresholds de cobertura mínima. Las ejecuciones de CI fallaron muchas veces al principio, pero ese dolor inicial tuvo como resultado que la rama `main` nunca dejó de estar en estado verde.

### Pruebas de carga y estrés con k6

Se ejecutaron cinco escenarios de performance que cubrieron los flujos críticos:
- El catálogo soportó 20 VUs concurrentes con 0% de errores y p95 < 900 ms.
- El flujo completo de checkout (listado → carrito → checkout → orden) completó 644 iteraciones con 0% de errores y p95 de checkout en ~38 ms sobre BD local.
- El carrito manejó 15 VUs con p95 de 26 ms y 0% de errores.
- El stress test identificó el punto de saturación del checkout en ~40–50 VUs concurrentes, lo que dio información concreta para definir el SLO del servicio.

Este trabajo habría sido imposible sin los seeds de desarrollo idempotentes, que permitieron poblar la base de datos de prueba de forma reproducible y rápida.

### Seeds de desarrollo

Los seeds cubren todos los servicios (usuarios, productos, órdenes, wishlists, métricas), son idempotentes y tienen dependencias en orden. Esto redujo drásticamente el tiempo de onboarding de nuevos integrantes y facilitó el testing manual en local.

### Auditorías de UX y accesibilidad

Se realizó una auditoría completa de accesibilidad (WCAG 2.1 AA) sobre todos los componentes de la app móvil, con tabla de estado, patrones de referencia y checklist de QA para VoiceOver y TalkBack. También se auditó el sistema de diseño: paleta, contraste, tipografía y patrones de UX por pantalla. Tener estas auditorías documentadas garantiza que las decisiones de diseño no se pierdan con el tiempo.

### App móvil con funcionalidad completa

La app React Native cubrió los tres roles (comprador, vendedor, admin), con flujos de checkout en tres pasos, carrito con UI optimista, wishlist, gestión de inventario, publicación de productos y panel de ventas. El soporte de i18n (español/inglés) y el sistema de temas (claro/oscuro) fueron completados sin deuda técnica visible.

---

## Problemas encontrados

### Integración con Auth0

La integración con Auth0 fue la parte más costosa en tiempo de la fase inicial. Las dificultades incluyeron:
- Configurar correctamente el tenant de Auth0 para emitir tokens con el claim `sub` en el formato esperado por Kong.
- Extraer la clave pública RSA del endpoint JWKS y convertirla al formato PEM que acepta Kong.
- Depurar errores de validación JWT que no daban mensajes claros desde Kong.
- Coordinar el comportamiento de los endpoints públicos (que no deben requerir token) con los protegidos, dado que Kong aplica el plugin JWT por ruta.

El resultado fue sólido, pero implicó varios días de trabajo de configuración y prueba.

### Agotamiento de minutos de GitHub Actions

En algún punto del proyecto el equipo agotó los minutos gratuitos de GitHub Actions disponibles en la organización. Esto detuvo todos los pipelines de CI durante un período. La solución fue configurar runners self-hosted en las máquinas de los integrantes del equipo, lo que resolvió el problema pero introdujo una dependencia: la ejecución de CI quedó sujeta a que la máquina del integrante responsable del runner estuviera encendida y conectada.

### Despliegue: intento con AWS, migración a VPS

Se intentó desplegar la infraestructura en AWS (ECS + RDS + ALB), pero el costo y la complejidad de configuración del entorno superaron lo esperado para el alcance del proyecto. La decisión fue migrar a un VPS contratado, donde los servicios corren con Docker Compose. Esto simplificó el despliegue considerablemente, aunque a costa de menor elasticidad y de no contar con balanceo de carga automático ni auto-scaling. Además, mediante paneles de Grafana y CDs configurados en los repositorios de cada microservicio de Github, cualquier integrante del equipo tenia acceso a los logs para poder debuggear o testear funcionalidades en el ambiente productivo y podía realizar un deploy automático si así lo deseaba.

### Comunicación entre microservicios: HTTP sincrónico

La comunicación inter-servicio se implementó mediante requests HTTP sincrónicas (por ejemplo, catalog-service resuelve datos de producto para wishlist-service; checkout-service llama a catalog-service para reservar stock). Esto introduce acoplamiento temporal: si catalog-service no responde, checkout no puede completar la operación. Bajo carga alta, este acoplamiento fue visible en el stress test del escenario 03, donde el checkout saturo el pool de conexiones y comenzó a acumular timeouts.

### Punto de saturación del checkout bajo carga alta

El stress test (escenario 03, 60 VUs) reveló que el checkout-service empieza a degradarse entre los 40 y 50 usuarios concurrentes. El patrón de timeouts en ráfagas cada ~17–20 segundos apunta al pool de conexiones a la base de datos como cuello de botella: cuando el pool se agota, los requests se encolan hasta el timeout. El sistema no crasheó ni devolvió errores 5xx, pero el p95 de latencia llegó al límite del timeout configurado (10 s).

---

## Aprendizajes

**Delegar la autenticación al gateway es la decisión correcta.** El costo inicial de configurar Kong + Auth0 se amortiza rápidamente: cada nuevo servicio es gratuito en términos de lógica de auth. La alternativa (validar JWT en cada servicio) habría introducido duplicación y riesgo de inconsistencias.

**Los seeds idempotentes no son opcionales en un proyecto con múltiples servicios.** Sin seeds reproducibles, el costo de reconfigurar el ambiente local o de testing es altísimo y bloquea iteraciones.

**Las pruebas de carga revelan problemas que los tests unitarios no pueden ver.** El cuello de botella del pool de conexiones del checkout no era detectable por ningún test funcional. Solo apareció al simular carga realista. La recomendación para cualquier proyecto similar es correr al menos un escenario de load test antes de la entrega final.

**HTTP sincrónico entre microservicios es viable pero tiene un costo de acoplamiento.** Para el alcance de este proyecto fue suficiente y más simple de implementar que una solución basada en mensajería. Pero a medida que el sistema escala, esa deuda se vuelve visible.

**El CI self-hosted resuelve el problema de minutos pero crea fragilidad operativa.** Un runner que depende de que una laptop esté encendida no es una solución de largo plazo. Para un proyecto en producción, la alternativa es pagar el plan o buscar créditos educativos en la plataforma.

**Documentar las auditorías de accesibilidad y UX como artefactos del repositorio tiene valor.** Al tenerlas en el repo junto al código, no se pierden con el tiempo y sirven de referencia concreta para code reviews futuros.

---

## Mejoras posibles

### Comunicación asíncrona entre microservicios

Reemplazar las llamadas HTTP sincrónicas entre servicios por un broker de mensajes (RabbitMQ, Kafka o Amazon SQS) para las operaciones que lo permitan. En particular, la notificación de cambio de estado de orden y la alerta de stock bajo ya están modeladas como eventos en notifications-service; el paso natural sería que catalog-service y checkout-service publiquen esos eventos en una queue en lugar de llamar directamente a notifications-service por HTTP.

### Aumentar el pool de conexiones del checkout-service

Dado que el stress test identificó el pool de conexiones como cuello de botella bajo 40–50 VUs, incrementar el tamaño máximo del pool (actualmente en valores por defecto de pgx) y ajustar el `max_idle_conns` podría mover el punto de saturación significativamente hacia arriba sin cambiar la arquitectura.

### Despliegue en cloud con orquestación

Migrar el despliegue del VPS a una plataforma con orquestación (AWS ECS Fargate, Railway o Render) permitiría tener auto-scaling por servicio, rolling deployments sin downtime y health checks automáticos. El VPS es funcional para el alcance actual pero no escala horizontalmente.

### CI con runners en la nube

Usar runners efímeros en la nube (GitHub-hosted de pago, o runners self-hosted en una instancia EC2/VPS dedicada) en lugar de las laptops del equipo. Esto garantiza disponibilidad continua del pipeline independientemente de quién tenga su máquina encendida.

### Caché en endpoints de catálogo

Los endpoints de listado de productos (`GET /products`, `GET /home`) son los más lentos bajo carga (p95 ~890 ms) y son completamente idempotentes. Agregar una capa de caché en Kong (plugin `proxy-cache`) o en el propio servicio reduciría la carga en la base de datos y mejoraría la latencia percibida.

### Tests de integración entre servicios

Los tests actuales son unitarios o de integración dentro de un mismo servicio. No existen tests que validen el flujo completo de extremo a extremo (app → Kong → catalog → checkout → notifications) de manera automatizada. Un suite de tests E2E en el repo `load-and-stress-tests` (o en un repo separado) que corra contra el entorno de staging cubriría ese vacío.

---

## Evaluación del proceso de trabajo

### Organización del equipo

El equipo trabajó con una estructura de subgrupos por área (backend Go, backend Python, mobile, backoffice, infra/gateway), lo que permitió avanzar en paralelo. Las interfaces entre servicios se acordaron con contratos HTTP explícitos (colecciones Bruno en cada repo) antes de implementar, lo que redujo los bloqueos por dependencias.

### Workflow con Git

El flujo `feature → dev → staging → main` funcionó bien en la práctica. La obligatoriedad de PR con review antes de merge a `dev` forzó al menos una segunda persona mirando cada cambio, lo que capturó bugs y problemas de diseño que de otra forma habrían llegado más lejos. El costo fue mayor latencia en la integración de features, especialmente en semanas de alta actividad.

### CI como red de seguridad

Haber invertido tiempo en los pipelines de CI desde el principio del proyecto pagó dividendos a lo largo de toda la cursada. La rama `main` nunca se rompió de forma imperceptible: cada fallo fue explícito y bloqueante. El episodio de agotamiento de minutos fue disruptivo, pero también demostró qué tan dependiente se había vuelto el equipo del CI — lo que es una señal positiva de que el proceso estaba arraigado.

### Deuda técnica

El proyecto tiene deuda técnica acotada y documentada. Los colores hardcodeados pendientes en la app móvil (tokens `stock-warning`, `error-surface`, `overlay`, `indicator-inactive`) están listados en la auditoría de UX. El escalado responsivo de tipografía en dispositivos pequeños tiene un fix identificado pero no aplicado (`Math.max(11, ...)` en el tier `xs` de `useResponsive.ts`). Esta deuda es cosmética y no afecta la funcionalidad.

### Documentación

La documentación del proyecto mejoró notablemente en las etapas finales. Cada servicio tiene un README con endpoints, setup local, variables de entorno y guía de testing. El repo de docs centraliza la arquitectura, los seeds, las auditorías de UX/accesibilidad y los resultados de las pruebas de carga. El gap entre el código y la documentación es bajo al momento de la entrega final.
