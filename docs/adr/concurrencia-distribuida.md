# Estrategia de Consistencia en Flujos Distribuidos: Saga con Orquestación

## Estado

Aceptada.

## Contexto

GranBazaar es un sistema de e-commerce compuesto por múltiples microservicios independientes (catalog-service, checkout-order-service, user-service, notifications-service, entre otros). Cada servicio posee su propia base de datos, por lo que no existe una transacción atómica que abarque a todos ellos.

El flujo de checkout es el caso más crítico: involucra reservar stock en catalog-service, crear la orden en checkout-order-service y registrar el cobro. Si cualquiera de esos pasos falla después de que los anteriores ya confirmaron, el sistema puede quedar en un estado inconsistente. El ejemplo más grave es que el pago se confirme pero la creación de la orden fracase, o que el stock quede reservado sin que exista una orden activa que lo justifique.

Este problema es inherente a toda arquitectura de microservicios y no puede resolverse con transacciones ACID clásicas entre servicios separados. Se necesita una estrategia explícita de consistencia distribuida que garantice que, ante un fallo parcial, el sistema revierta o compense los pasos ya completados.

## Decisión

Se adopta el **patrón Saga con orquestación** como estrategia de consistencia para los flujos que atraviesan más de un servicio.

En una Saga orquestada existe un coordinador central —en este caso, checkout-order-service— que conoce la secuencia de pasos y es responsable de ejecutarlos en orden y, ante cualquier fallo, de invocar las **transacciones de compensación** correspondientes en orden inverso.

El flujo de checkout queda definido así:

| Paso | Acción directa | Compensación |
|---|---|---|
| 1 | Reservar stock en catalog-service | Liberar la reserva de stock |
| 2 | Crear la orden en checkout-order-service | Cancelar o marcar la orden como fallida |
| 3 | Registrar el cobro (integración de pago) | Emitir reembolso o anular la autorización |
| 4 | Notificar al usuario vía notifications-service | (sin compensación; la notificación es informativa) |

Si el paso 3 falla, el orquestador ejecuta la compensación del paso 2 y luego la del paso 1. Cada compensación es una operación idempotente: puede invocarse más de una vez sin producir efectos duplicados.

Las operaciones de compensación se registran junto con el estado de la saga en checkout-order-service, de modo que ante una caída del orquestador sea posible retomar o completar el rollback al reiniciar.

## Alternativas descartadas

**Two-Phase Commit (2PC):** Un coordinador global bloquea todos los participantes en una fase de preparación antes de confirmar. Garantiza atomicidad, pero requiere que todos los servicios estén disponibles simultáneamente durante el bloqueo, introduce acoplamiento temporal fuerte y es un cuello de botella de disponibilidad y rendimiento. No es adecuado para servicios independientes desplegados por separado.

**Saga coreografiada (choreography):** Cada servicio reacciona a eventos publicados por el anterior, sin un coordinador central. Desacopla mejor los servicios, pero dispersa la lógica de compensación entre ellos, hace difícil razonar sobre el estado global del flujo y complica la observabilidad y el debugging. Para el alcance del proyecto, la visibilidad que da el orquestador central supera la ventaja del desacoplamiento adicional.

**Consistencia eventual sin compensación (best-effort):** Aceptar que los fallos parciales queden en estado inconsistente y resolverlos de forma manual o fuera de banda. No es aceptable para un flujo financiero donde el cobro ya fue debitado al usuario.

## Consecuencias

Lo que se vuelve más sencillo:

- El **estado global del flujo es visible en un único lugar**: checkout-order-service conoce en qué paso está la saga y qué compensaciones se han ejecutado, lo que facilita el monitoreo y el debugging.
- Las **compensaciones son explícitas y testeables** como operaciones individuales, independientemente del flujo feliz.
- Agregar un nuevo paso al flujo implica definir su acción directa y su compensación en el orquestador, sin modificar los demás servicios.
- La **idempotencia de las compensaciones** permite reintentar sin riesgo ante fallos transitorios de red.

Lo que se vuelve más difícil o queda como riesgo:

- El **orquestador es un punto de acoplamiento lógico**: cualquier cambio en la secuencia del flujo requiere modificar checkout-order-service.
- La **consistencia es eventual**, no inmediata: durante la ejecución de la saga hay ventanas de tiempo en las que el sistema está en un estado intermedio visible. Los servicios deben diseñarse tolerando ese estado.
- Las **compensaciones no siempre son perfectamente inversas**: por ejemplo, una notificación enviada no puede "deshacer" su efecto en el usuario. Es necesario identificar estos pasos y documentar que no tienen compensación.
- La **durabilidad de la saga** requiere persistir su estado ante caídas del orquestador, lo que añade complejidad operativa al checkout-order-service.
