# Auditoría de UX y Sistema de Diseño — BazaarApp

**Fecha:** 2026-06-21  
**Plataformas:** iOS · Android  
**Framework:** React Native 0.79.5 / Expo  
**Alcance:** Contraste de color, tipografía, sistema de diseño, flujos de UX y navegación

---

## Resumen ejecutivo

| Área | Evaluación |
|---|---|
| Contraste de color | ⚠️ Mayormente aceptable, con problemas específicos en modo oscuro y texto secundario |
| Tamaños de tipografía | ⚠️ Un token bajo el mínimo recomendado (`bodyXSmall` a 10sp) |
| Consistencia del sistema de diseño | ✅ Buenas bases; violaciones puntuales en valores hardcodeados |
| Paradigma de diseño | Material Design 3 con branding propio ("El Ágora Moderna") |
| Madurez de UX | 7.5 / 10 — Sólido, con brechas identificables |

---

## Parte 1 — Contraste de color y tipografía

### 1.1 Paleta de colores

El sistema de color sigue una regla 60-30-10:

| Rol | Token | Hex (light) | Hex (dark) |
|---|---|---|---|
| Fondo principal (60%) | `background` | #FAF8F5 | #201F1E |
| Superficie (tarjetas, modales) | `surface` | #FFFFFF | #2A2726 |
| Texto principal | `foreground` | #2A2726 | #FAF8F5 |
| Texto secundario | `muted-foreground` | #6B6663 | #C8C3BF |
| Primario — terracota (30%) | `primary` | #C86A53 | #C86A53 |
| Secundario — azul egeo (10%) | `secondary` | #1A5F7A | #1A5F7A |
| Éxito | `success` | #70825B | #70825B |
| Error | `destructive` | #E74C3C | #E74C3C |
| Advertencia | `warning` | #F59E0B | #F59E0B |

### 1.2 Contraste — resultados WCAG AA

**WCAG AA requiere:** 4.5:1 para texto normal · 3:1 para texto grande (≥18sp o ≥14sp bold) y componentes UI.

#### Modo claro

| Combinación | Ratio estimado | Resultado |
|---|---|---|
| `foreground` (#2A2726) sobre `surface` (#FFF) | 19.5:1 | ✅ AAA |
| `foreground` (#2A2726) sobre `background` (#FAF8F5) | ~17:1 | ✅ AAA |
| `secondary` (#1A5F7A) sobre `surface` (#FFF) | 7.8:1 | ✅ AA |
| `success` (#70825B) sobre `surface` (#FFF) | 5.2:1 | ✅ AA |
| `destructive` (#E74C3C) sobre `surface` (#FFF) | 4.9:1 | ✅ AA |
| `muted-foreground` (#6B6663) sobre `surface` (#FFF) | ~5.0:1 | ✅ AA (marginal) |
| `muted-foreground` (#6B6663) sobre `primary-wash` (#F0DFD9) | ~4.8:1 | ⚠️ Marginal |
| `primary` (#C86A53) sobre `surface` (#FFF) | 3.8:1 | ⚠️ Solo AA para texto grande |
| `warning` (#F59E0B) sobre `surface` (#FFF) | 3.8:1 | ⚠️ Solo AA para texto grande |

#### Modo oscuro

| Combinación | Ratio estimado | Resultado |
|---|---|---|
| `foreground` (#FAF8F5) sobre `surface` (#2A2726) | 18.8:1 | ✅ AAA |
| `muted-foreground` (#C8C3BF) sobre `surface` (#2A2726) | 9.2:1 | ✅ AAA |
| `secondary` (#1A5F7A) sobre `surface` (#2A2726) | ~2.8:1 | ❌ FALLA AA |
| `#5BB8D4` (hardcode) sobre `surface` (#2A2726) | ~4.1:1 | ⚠️ Marginal |

#### Problemas de contraste identificados

**P0 — `secondary` (#1A5F7A) en modo oscuro falla WCAG AA (2.8:1).**  
El color no fue ajustado para dark mode. Múltiples archivos lo compensan con un valor hardcodeado (`#5BB8D4`) pero de forma inconsistente:
- [app/orders.tsx](../app/orders.tsx) — color de código de seguimiento
- [app/sales.tsx](../app/sales.tsx) — color de detalle y seguimiento
- [components/SellerProductCard.tsx](../components/SellerProductCard.tsx) — `editColor`
- [components/OrderDetailsContent.tsx](../components/OrderDetailsContent.tsx)

**Solución recomendada:** agregar un token `secondary-on-dark` en `Colors.dark`:
```ts
// constants/theme.ts — Colors.dark
'secondary-on-dark': '#5BB8D4',  // azul egeo claro para dark mode (4.1:1 sobre #2A2726)
```
Y reemplazar todos los hardcodes por el token.

**P1 — `muted-foreground` sobre `primary-wash` apenas pasa (4.8:1).**  
Combinación usada en algunas secciones de formulario. Debería evitarse para texto de cuerpo pequeño.

**P1 — `primary` (#C86A53) y `warning` (#F59E0B) no pasan AA para texto normal sobre blanco.**  
Solo aptos para texto grande (≥18sp o bold ≥14sp), iconos o decoración. No deben usarse para texto de cuerpo o etiquetas pequeñas.

### 1.3 Tipografía — tokens y tamaños

| Token | fontSize | lineHeight | fontWeight | Uso previsto |
|---|---|---|---|---|
| `headlineLarge` | 28 | 36 | 700 | Títulos principales |
| `headlineMedium` | 24 | 32 | 600 | Secciones |
| `headlineSmall` | 20 | 28 | 600 | Subtítulos |
| `labelLarge` | 16 | 24 | 600 | Botones, tabs |
| `labelMedium` | 14 | 20 | 500 | Etiquetas de campo |
| `labelSmall` | 12 | 16 | 500 | Chips, badges |
| `bodyLarge` | 16 | 24 | 400 | Cuerpo principal |
| `bodyMedium` | 14 | 20 | 400 | Cuerpo |
| `bodySmall` | 12 | 18 | 400 | Texto secundario |
| `bodyXSmall` | **10** | 14 | 400 | ⚠️ Texto muy pequeño |

**Problema — `bodyXSmall` (10sp) está por debajo del mínimo recomendado de 12sp para texto de interfaz móvil.**

Lugares donde se usa:
- Stock pill en `ProductCard`
- Meta text en `SellerProductCard`
- Badge text en `OrderFilterSheet`
- Labels de estado en `OrderDetailsContent`

**Solución:** Elevar el mínimo a 11sp o reemplazar usos por `bodySmall` (12sp) donde el espacio lo permita. Si 10sp es necesario para ciertos badges, agregar explícitamente un token `badgeText` con `fontSize: 11` y documentar que solo aplica a elementos no-cuerpo con alto contraste garantizado.

### 1.4 Escalado responsivo (`useResponsive.ts`)

El hook escala tipografía desde la referencia 390pt con factor `min(screenWidth/390, 1.5)`. **No impone mínimo de fuente** — en dispositivos pequeños `xs` puede bajar a 10sp real. Recomendación: agregar `Math.max(11, ...)` al menos en el tier `xs`.

### 1.5 Colores hardcodeados fuera del sistema de tokens

El siguiente inventario de valores hardcodeados debe migrarse a tokens:

| Valor hardcodeado | Archivo(s) | Token sugerido |
|---|---|---|
| `'#5BB8D4'` (azul claro dark mode) | orders, sales, SellerProductCard, OrderDetailsContent | `Colors.dark['secondary-on-dark']` |
| `'#E6813A'` (naranja stock pill) | ProductCard, wishlist | `Colors.light['stock-warning']` |
| `'#FDECEA'` (fondo error campo) | FormField, DatePickerField | `Colors.light['error-surface']` |
| `'rgba(0,0,0,0.35–0.45)'` (overlays) | ProductCard, OrderFilterSheet, modales | `Colors['overlay']` (shared) |
| `'#D0D0D0'` (dot inactivo carrusel) | CategoriesCarousel, InfiniteCarousel | `Colors.light['indicator-inactive']` |
| `'#C86A53'` (dot activo carrusel) | CategoriesCarousel, InfiniteCarousel | Usar `theme.primary` |
| `'#4BAAC8'` (edit button dark mode) | SellerProductCard | Usar `secondary-on-dark` |
| `shadowColor: '#C86A53'` | publish, orders | `theme.primary` (o nuevo `Colors['shadow-brand']`) |

---

## Parte 2 — Sistema de diseño

### 2.1 Paradigma adoptado

**BazaarApp sigue Material Design 3 con branding propio.**

Evidencias:
- Escala de espaciado basada en unidades de 4px (MD3 4dp grid)
- Escala de tipografía en tres niveles: headline / body / label (MD3)
- Elevación y sombras por nivel de componente (cards, botones, modales)
- Chips para filtros, bottom sheets, navigation bar inferior (todos componentes MD3)
- Bordes redondeados progresivos (sm=8, md=12, lg=16) alineados a MD3 shape scale

**Desviaciones intencionales (identidad de marca):**
- Paleta terracota + azul egeo en lugar de colores MD3 por defecto
- Fuente PlayfairDisplay en displays (no común en MD3 estándar)
- Dark mode personalizado "Noche Ateniense" con grises cálidos (#201F1E, #2A2726) en vez de los grises fríos de MD3

### 2.2 Tokens — estado de adherencia

#### Spacing ✅ Buena adherencia

La mayoría de componentes usa correctamente `Spacing.xs/sm/md/lg/xl/2xl/3xl`. Violaciones menores:
- `BannerCard.tsx` — `paddingHorizontal: 9` (debería ser `Spacing.sm=8`) y `paddingHorizontal: 18` (debería ser `Spacing.xl=24`)
- `BottomNav.tsx` — `paddingHorizontal: 8, paddingVertical: 4` hardcodeados (usar `Spacing.sm`, `Spacing.xs`)

#### Radii ⚠️ Violaciones puntuales

| Valor hardcodeado | Archivo | Corrección |
|---|---|---|
| `borderRadius: 14` | ProductCard.tsx | `Radii.md` (12) o extender token |
| `borderRadius: 15` | OrderFilterSheet.tsx | `Radii.md` (12) o `Radii.lg` (16) |
| `borderRadius: 12` (sin token) | SearchBar.tsx, Button.tsx | Usar `Radii.md` |
| `borderRadius: 16` (sin token) | BannerCard.tsx | Usar `Radii.lg` |

Si los valores 14 y 15 son intencionales, agregarlos como `Radii.mdPlus = 14` o similar.

#### Typography ❌ Violaciones en varios componentes

| Archivo | Problema |
|---|---|
| `Button.tsx` | Usa `fontSize: 12/14/16` hardcodeados según variante — debería usar `...Typography.labelSmall/Medium/Large` |
| `BannerCard.tsx` | Usa `fontSize: 10/11/26` hardcodeados — debería usar tokens |
| `OrderDetailsContent.tsx` | Múltiples `fontSize` hardcodeados (12, 13, 14, 15) |

#### Iconografía ✅ Consistente

- Ionicons como librería primaria (95% de usos)
- Feather como secundario para patrones específicos
- No hay mezcla con MaterialCommunityIcons u otras librerías

#### Sombras ⚠️ Sin tokens centralizados

Los valores de sombra son consistentes en su lógica pero están escritos repetidamente en cada componente. No existe un token `Shadows.*` en el tema:
- Cards: `elevation: 3, shadowRadius: 6, shadowOpacity: 0.08`
- Botón primario: `elevation: 4-6, shadowRadius: 8`
- BottomNav: `shadowRadius: 10`

**Recomendación:** crear `export const Shadows` en `constants/theme.ts`:
```ts
export const Shadows = {
  card: { elevation: 3, shadowOffset: { width: 0, height: 2 }, shadowOpacity: 0.08, shadowRadius: 6 },
  button: { elevation: 5, shadowOffset: { width: 0, height: 3 }, shadowOpacity: 0.12, shadowRadius: 8 },
  nav: { elevation: 8, shadowOffset: { width: 0, height: -2 }, shadowOpacity: 0.08, shadowRadius: 10 },
} as const;
```

#### Patrones responsive ⚠️ Múltiples enfoques paralelos

Coexisten tres estrategias sin unificación clara:

| Enfoque | Dónde se usa |
|---|---|
| `useResponsive()` hook | SearchBar, my-products, algunos componentes |
| `Math.round(windowWidth * N / 430)` inline | publish, edit-product, edit-profile |
| `useWindowDimensions()` directo | FeedbackModal, SellerProductCard |

Las tres funcionan correctamente pero su coexistencia aumenta la curva de incorporación para nuevos devs. **Recomendación:** definir una guía de cuándo usar cada patrón en CLAUDE.md (ya existe documentación parcial, completarla).

#### Import de Typography ⚠️ Nombre inconsistente

`FeedbackModal.tsx` importa `typography` (minúscula, legado) mientras el resto usa `Typography` (mayúscula, actual). Unificar al refactorizar.

### 2.3 Tabla resumen de tokens

| Token group | Adherencia | Violaciones |
|---|---|---|
| `Spacing` | ✅ Buena | Valores 9 y 18 hardcodeados en BannerCard/BottomNav |
| `Radii` | ⚠️ Parcial | Valores 14, 15 no pertenecen al set; algunos usan número en vez de token |
| `Typography` | ❌ Débil | Button, BannerCard, OrderDetailsContent usan px directos |
| `Colors` | ✅ Buena | Problemas en dark mode secondary y colores de overlay |
| `Shadows` | ⚠️ Sin token | Valores repetidos en cada componente |
| Iconografía | ✅ Consistente | Sin mezcla de librerías |

---

## Parte 3 — Decisiones de UX

### 3.1 Arquitectura de navegación

```
Tab Navigator (5 tabs)
├── Home (/) — descubrimiento
├── Search (/search) — búsqueda y filtros
├── Cart (/cart) — carrito de compras
├── Wishlist (/wishlist) — favoritos
└── Profile (/profile) — cuenta y configuración
    └── Stack Navigator (desde profile)
        ├── /orders — mis compras (comprador)
        ├── /sales — mis ventas (vendedor)
        ├── /my-products — mi inventario (vendedor)
        ├── /publish — crear producto
        ├── /edit-product — editar producto
        └── /checkout/* — flujo de pago (3 pasos)
```

La arquitectura es clara y predecible. El uso de tabs para navegación principal y stack para flujos de tarea sigue la convención de iOS HIG y Android Material.

### 3.2 Análisis por pantalla

#### Home
**Objetivo del usuario:** Descubrir productos.  
**Patrones positivos:** Loader con branding propio, pull-to-refresh, empty state con ícono, carrusel de categorías, orden de banners aleatorio pero estable por sesión, UI optimista para agregar al carrito.  
**Problema:** Sin indicador de "fin de lista" en el scroll infinito.

---

#### Búsqueda
**Objetivo:** Encontrar productos por nombre, categoría u orden.  
**Patrones positivos:** Estado vacío con CTA de "limpiar filtros", badge de filtros activos, chips de categoría con animación, paginación numerada con prev/next deshabilitados en los extremos.  
**Problema:** Solo paginación numerada — sin scroll infinito, el usuario debe clickear "siguiente" para ver más resultados en listas largas.

---

#### Carrito
**Objetivo:** Revisar y proceder al pago.  
**Patrones positivos:** UI optimista en cambio de cantidad, confirmación antes de eliminar ítem, estado vacío con ícono y mensaje claro.  
**Problema:** Sin estado de carga visual durante el cambio de cantidad (depende del optimismo para ocultar la latencia).

---

#### Wishlist
**Objetivo:** Guardar y gestionar favoritos.  
**Patrones positivos:** Layout masonry (estilo Pinterest), skeleton loaders, indicador de stock bajo (ícono llama + cantidad), overlay de no disponible.  
**Problema:** No se puede eliminar de favoritos desde esta pantalla (solo desde el detalle de producto).

---

#### Órdenes (comprador)
**Objetivo:** Rastrear compras, confirmar entrega, cancelar.  
**Patrones positivos:** Chips de estado con color semántico, filtros por estado, código de seguimiento visible, confirmación antes de cancelar, botones deshabilitados durante async.  
**Problema:** En web el detalle se abre como modal; en nativo como pantalla completa — inconsistencia cross-platform.

---

#### Ventas (vendedor)
**Objetivo:** Gestionar pedidos entrantes, avanzar estado.  
**Patrones positivos:** Flujo de estado claro (confirmado → en preparación → enviado), campo de tracking aparece solo al avanzar a "enviado", texto del botón indica la acción en progreso ("Marcando como enviado…").  
**Problema:** El código de tracking no es editable después de enviado. Sin operaciones en lote.

---

#### Mis Productos
**Objetivo:** Gestionar inventario.  
**Patrones positivos:** Bottom sheet de filtros no bloqueante, badge de filtros activos, overlay con blur para confirmación de acciones destructivas, spring animations en botones, búsqueda del lado del cliente para respuesta instantánea.  
**Problema:** El éxito al eliminar un producto no muestra feedback (el card simplemente desaparece). El sort activo no es visible en la UI principal (requiere abrir el sheet).

---

#### Publicar / Editar producto
**Objetivo:** Crear o modificar una publicación.  
**Patrones positivos:** Validación campo a campo con live region, keyboard accessory bar para navegar entre campos, soporte para reordenar y eliminar imágenes, contador de imágenes, modal de éxito con acciones de recuperación.  
**Problema:** Sin advertencia de "cambios sin guardar" al salir. Sin guardado automático o borrador. Sin contador de caracteres en descripción durante la escritura.

---

#### Checkout (3 pasos)
**Objetivo:** Completar una compra.  
**Patrones positivos:** Indicador visual de pasos (dots de progreso), validación del campo de dirección antes de continuar, resumen de orden antes del pago, soporte de código de descuento.  
**Problema:** Sin botón de "volver" entre pasos. Validación de dirección mínima (acepta cualquier texto no vacío). Sin confirmación de pago enviada al usuario (email/notificación).

---

#### Perfil
**Objetivo:** Hub de configuración y acceso a flujos secundarios.  
**Patrones positivos:** Badges en ítems de menú para acciones pendientes, íconos de error en secciones con problemas, spring animations, pull-to-refresh.  
**Problema:** Los ítems de menú con error no ofrecen path de recuperación (no hay botón retry visible).

---

### 3.3 Patrones de UX bien implementados (referencia)

#### Confirmaciones antes de acciones destructivas
Todos los flujos de eliminar o cancelar (producto, ítem de carrito, orden) muestran un modal de confirmación con botón cancel (secundario) y botón acción (primario/destructivo). Patrón consistente y correcto.

#### UI optimista
Home y carrito aplican UI optimista: la respuesta visual llega antes de la confirmación del servidor. Los errores hacen rollback con modal. Esto mejora notablemente la percepción de velocidad.

#### Estados vacíos y de error completos
Cada pantalla con listado tiene tres estados distintos implementados: loading, vacío y error. Los estados de error incluyen botón de retry en la mayoría de los casos.

#### Pantalla protegida (`ProtectedScreen`)
Componente reutilizable que intercepta el acceso a pantallas que requieren autenticación y presenta opciones de login/registro o navegar al home. Evita duplicación de lógica de auth en cada pantalla.

#### Barra de accesorio de teclado
En Publicar y Editar Producto, la barra de prev/next/enviar sobre el teclado reduce la fricción en formularios largos. Comportamiento correcto diferenciado entre iOS y Android.

#### Color semántico en estados de orden
Los chips de estado de orden usan color consistentemente: azul para confirmado, verde para enviado/entregado, rojo para cancelado/rechazado. El usuario reconoce el estado sin leer el texto.

---

### 3.4 Anti-patrones y brechas de UX

#### P0 — Riesgo de pérdida de datos

**Pantallas afectadas:** Publicar, Editar Producto, Editar Perfil  
**Problema:** Al tocar "atrás" en un formulario con cambios, los datos se pierden sin advertencia.  
**Impacto:** Un formulario de publicación tiene ~10 campos; perderlo es muy frustrante.  
**Fix:**
```ts
// Detectar si hay cambios sin guardar
const hasChanges = useMemo(() => {
  return name !== initialName || description !== initialDescription || /* ... */;
}, [name, description, initialName, initialDescription]);

// En el header back button:
const handleBack = () => {
  if (hasChanges) {
    Alert.alert(t('common.unsavedChanges'), t('common.unsavedChangesMsg'), [
      { text: t('common.stay'), style: 'cancel' },
      { text: t('common.discard'), style: 'destructive', onPress: () => router.back() },
    ]);
  } else {
    router.back();
  }
};
```

---

#### P1 — Sin estado de carga inline en botones async

**Pantallas afectadas:** Órdenes (confirmar entrega), Ventas (avanzar estado)  
**Problema:** El botón se deshabilita pero no comunica que algo está sucediendo.  
**Impacto:** El usuario no sabe si su toque fue registrado.  
**Fix:**
```tsx
<Pressable
  disabled={isLoading}
  accessibilityState={{ disabled: isLoading, busy: isLoading }}
>
  {isLoading
    ? <ActivityIndicator size="small" color="#FFF" />
    : <Text>{t('orders.confirmDelivery')}</Text>
  }
</Pressable>
```

---

#### P1 — Sin skeleton loaders en pantallas de lista

**Pantallas afectadas:** Órdenes, Ventas, Mis Productos  
**Problema:** Spinner centralizado no comunica la forma del contenido.  
**Impacto:** Experiencia percibida más lenta; sin anticipación de estructura.  
**Fix:** Crear `OrderSkeleton` y `ProductSkeleton` similares al existente `LoadingSkeletons` en Wishlist.

---

#### P1 — Navegación inconsistente en detalle de orden

**Pantallas afectadas:** Órdenes, Ventas  
**Problema:** En web el detalle se abre como modal; en nativo como pantalla full-screen push.  
**Impacto:** Comportamiento diferente según plataforma sin señales visuales al usuario.  
**Fix:** Unificar a pantalla full-screen en ambas plataformas, o asegurar que el modal en web tenga un close button prominente y gestión de back consistente.

---

#### P2 — Feedback silencioso al eliminar producto

**Pantalla afectada:** Mis Productos  
**Problema:** El producto desaparece del listado sin toast ni animación de confirmación.  
**Fix:** Mostrar `ErrorToast` (o similar) con mensaje de éxito luego del delete. Alternativamente, animar el card saliendo del listado.

---

#### P2 — Sort activo no visible en UI principal

**Pantalla afectada:** Mis Productos  
**Problema:** El orden activo solo se ve dentro del bottom sheet; en la lista principal no hay indicación.  
**Fix:** Mostrar el nombre del sort activo junto al botón de filtros, como ya se hace con el conteo de filtros activos.

---

#### P2 — Validación mínima en dirección de entrega

**Pantalla afectada:** Checkout → Delivery  
**Problema:** Acepta cualquier string no vacío como dirección válida.  
**Impacto:** Órdenes con direcciones incompletas o inválidas.  
**Fix:** Validar longitud mínima y, de ser posible, formato básico según el país del usuario.

---

#### P2 — Sin contador de caracteres en descripción

**Pantalla afectada:** Publicar, Editar Producto  
**Problema:** El campo de descripción tiene límite de 1000 caracteres pero no se muestra el contador durante la escritura.  
**Fix:** Mostrar contador dinámico `{chars}/1000` debajo del campo (ya existe en muchos editores).

---

#### P3 — Código de seguimiento no editable post-envío

**Pantalla afectada:** Ventas  
**Problema:** Una vez que la orden pasa a "enviado", el código de tracking no puede corregirse.  
**Fix:** Mostrar el campo como editable en el detalle si el estado es "enviado" (antes de entregado).

---

### 3.5 Tabla resumen de pantallas

| Pantalla | Objetivo | Feedback de carga | Estado vacío | Estado error | Confirmación destructiva | Problemas clave |
|---|---|---|---|---|---|---|
| Home | Descubrimiento | ✅ Branded loader | ✅ | ✅ | N/A | Sin "fin de lista" |
| Search | Búsqueda | ✅ Spinner | ✅ + CTA | ✅ | N/A | Solo paginación (sin infinite scroll) |
| Cart | Compra | ⚠️ Optimista | ✅ | ✅ Modal | ✅ Para eliminar ítem | — |
| Wishlist | Favoritos | ✅ Skeleton | ✅ Animado | ✅ | N/A | Sin remove desde listado |
| Órdenes | Rastrear | ⚠️ Solo spinner | ✅ | ✅ + Retry | ✅ Para cancelar | Detail inconsistente web/native |
| Ventas | Gestionar pedidos | ⚠️ Solo spinner | ✅ | ✅ + Retry | ✅ Para cancelar | Tracking no editable post-enviado |
| Mis Productos | Inventario | ⚠️ Solo spinner | ✅ + CTA | ✅ + Retry | ✅ Blur overlay | Delete silencioso; sort no visible |
| Publicar | Crear producto | N/A | N/A | ✅ Toast | N/A | Sin advertencia de cambios sin guardar |
| Editar Producto | Modificar | ✅ Spinner | N/A | ✅ Toast | N/A | Sin advertencia de cambios sin guardar |
| Checkout | Pagar | ✅ Por paso | N/A | ✅ Modal | N/A | Sin back entre pasos; validación débil |
| Perfil | Hub de cuenta | ✅ Spinner + skeleton | N/A | ⚠️ Sin retry | N/A | Errores sin path de recuperación |
| Editar Perfil | Configuración | ✅ Spinner | N/A | ✅ Toast | N/A | Sin advertencia de cambios sin guardar |

---

## Parte 4 — Plan de acción priorizado

### P0 — Crítico

| # | Acción | Archivo(s) | Estimación |
|---|---|---|---|
| 1 | Agregar token `secondary-on-dark` en `Colors.dark` y reemplazar los 4 hardcodes de `#5BB8D4` | constants/theme.ts, orders, sales, SellerProductCard, OrderDetailsContent | 2h |
| 2 | Advertencia de "cambios sin guardar" en Publicar, Editar Producto y Editar Perfil | publish.tsx, edit-product.tsx, edit-profile.tsx | 3-4h |

### P1 — Alto

| # | Acción | Archivo(s) | Estimación |
|---|---|---|---|
| 3 | Elevar `bodyXSmall` a mínimo 11sp o reemplazar usos por `bodySmall` | theme.ts + ProductCard, SellerProductCard, OrderFilterSheet, OrderDetailsContent | 2h |
| 4 | Agregar spinner inline en botones async de Órdenes y Ventas | orders.tsx, sales.tsx | 2h |
| 5 | Crear skeleton loaders para Órdenes, Ventas y Mis Productos | Nuevo OrderSkeleton, ProductSkeleton | 3h |
| 6 | Migrar `Typography` hardcodeada en Button, BannerCard, OrderDetailsContent | components/Button.tsx, BannerCard.tsx, OrderDetailsContent.tsx | 2h |

### P2 — Medio

| # | Acción | Archivo(s) | Estimación |
|---|---|---|---|
| 7 | Crear token `Shadows` en theme.ts y reemplazar definiciones repetidas | constants/theme.ts + todos los componentes con sombras | 3h |
| 8 | Migrar colores hardcodeados (`#E6813A`, `#FDECEA`, overlays, dots de carrusel) a tokens | theme.ts + componentes afectados | 3h |
| 9 | Mostrar feedback de éxito al eliminar producto | my-products.tsx | 1h |
| 10 | Mostrar sort activo en UI principal de Mis Productos | my-products.tsx | 1h |
| 11 | Agregar contador de caracteres en campo descripción | publish.tsx, edit-product.tsx | 1h |
| 12 | Unificar detalle de orden (modal vs full-screen) entre web y nativo | orders.tsx, sales.tsx | 2h |

### P3 — Bajo

| # | Acción | Estimación |
|---|---|---|
| 13 | Permitir editar tracking code en estado "enviado" | 2h |
| 14 | Validación más robusta en campo dirección (checkout) | 1h |
| 15 | Scroll infinito en búsqueda (reemplazar/complementar paginación numerada) | 4-6h |
| 16 | Completar extensión de Radii (agregar valores 14, 20 como tokens) | 1h |

---

## Reglas a incorporar en revisiones de código

1. No usar `primary` (#C86A53) ni `warning` (#F59E0B) como color de texto en tamaños menores a 18sp sobre fondo blanco.
2. No usar `secondary` (#1A5F7A) sobre superficies oscuras — usar `secondary-on-dark` o el equivalente del sistema de tokens cuando esté disponible.
3. `bodyXSmall` solo para badges y elementos decorativos donde el contraste sea AAA (≥7:1). Para texto legible de interfaz, usar `bodySmall` (12sp) como mínimo.
4. Toda nueva pantalla con listado debe tener los tres estados: loading (skeleton o spinner), vacío y error.
5. Todo formulario con más de 3 campos debe implementar detección de cambios sin guardar.
6. Toda acción destructiva (eliminar, cancelar) debe mostrar confirmación y toast/animación de éxito.
7. Valores de color, spacing, tipografía y border-radius siempre vía tokens — no hardcodeados.
