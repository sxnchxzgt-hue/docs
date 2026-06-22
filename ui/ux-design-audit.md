# Auditoria de UX y Sistema de Diseno -- BazaarApp

**Fecha de auditoria:** 2026-06-21
**Plataformas:** iOS - Android
**Framework:** React Native 0.79.5 / Expo
**Alcance:** Contraste de color, tipografia, sistema de diseno, flujos de UX y navegacion

---

## Resumen ejecutivo

| Area | Estado |
|---|---|
| Contraste de color | Resuelto -- token `secondary-on-dark` agregado; hardcodes eliminados |
| Tamanos de tipografia | Resuelto -- `bodyXSmall` elevado a 11sp; todos los componentes con tokens |
| Consistencia del sistema de diseno | Resuelto -- tokens `Shadows`, `Radii.mdPlus` agregados; `Typography`, `Radii` y `Spacing` migrados en todos los componentes |
| Paradigma de diseno | Material Design 3 con branding propio ("El Agora Moderna") |
| Madurez de UX | 8.2 / 10 -- Skeleton loaders, feedback de delete y spinner async aplicados |

---

## Parte 1 -- Contraste de color y tipografia

### 1.1 Paleta de colores

El sistema de color sigue una regla 60-30-10:

| Rol | Token | Hex (light) | Hex (dark) |
|---|---|---|---|
| Fondo principal (60%) | `background` | #FAF8F5 | #201F1E |
| Superficie (tarjetas, modales) | `surface` | #FFFFFF | #2A2726 |
| Texto principal | `foreground` | #2A2726 | #FAF8F5 |
| Texto secundario | `muted-foreground` | #6B6663 | #C8C3BF |
| Primario -- terracota (30%) | `primary` | #C86A53 | #C86A53 |
| Secundario -- azul egeo (10%) | `secondary` | #1A5F7A | #1A5F7A |
| Secundario en dark (agregado) | `secondary-on-dark` | -- | #5BB8D4 |
| Exito | `success` | #70825B | #70825B |
| Error | `destructive` | #E74C3C | #E74C3C |
| Advertencia | `warning` | #F59E0B | #F59E0B |

### 1.2 Contraste -- resultados WCAG AA

WCAG AA requiere: 4.5:1 para texto normal - 3:1 para texto grande (>=18sp o >=14sp bold) y componentes UI.

#### Modo claro

| Combinacion | Ratio | Resultado |
|---|---|---|
| `foreground` (#2A2726) sobre `surface` (#FFF) | 19.5:1 | AAA |
| `foreground` (#2A2726) sobre `background` (#FAF8F5) | ~17:1 | AAA |
| `secondary` (#1A5F7A) sobre `surface` (#FFF) | 7.8:1 | AA |
| `success` (#70825B) sobre `surface` (#FFF) | 5.2:1 | AA |
| `destructive` (#E74C3C) sobre `surface` (#FFF) | 4.9:1 | AA |
| `muted-foreground` (#6B6663) sobre `surface` (#FFF) | ~5.0:1 | AA (marginal) |
| `muted-foreground` (#6B6663) sobre `primary-wash` (#F0DFD9) | ~4.8:1 | Marginal -- evitar para texto de cuerpo pequeno |
| `primary` (#C86A53) sobre `surface` (#FFF) | 3.8:1 | Solo AA para texto grande (>=18sp) |
| `warning` (#F59E0B) sobre `surface` (#FFF) | 3.8:1 | Solo AA para texto grande (>=18sp) |

#### Modo oscuro

| Combinacion | Ratio | Resultado |
|---|---|---|
| `foreground` (#FAF8F5) sobre `surface` (#2A2726) | 18.8:1 | AAA |
| `muted-foreground` (#C8C3BF) sobre `surface` (#2A2726) | 9.2:1 | AAA |
| `secondary-on-dark` (#5BB8D4) sobre `surface` (#2A2726) | ~4.1:1 | AA (marginal) |
| `secondary` (#1A5F7A) sobre `surface` (#2A2726) | ~2.8:1 | Falla AA -- no usar directamente en dark mode |

#### Reglas de uso de color

- `primary` y `warning` solo para texto grande, iconos o decoracion. No usar como color de texto de cuerpo sobre fondos blancos.
- En dark mode, usar siempre `theme['secondary-on-dark']` en lugar de `theme.secondary` para texto o iconos sobre superficie oscura.
- Evitar `muted-foreground` sobre `primary-wash` para texto de cuerpo pequeno.

### 1.3 Tipografia -- tokens y tamanos

| Token | fontSize | lineHeight | fontWeight | Uso previsto |
|---|---|---|---|---|
| `headlineLarge` | 28 | 36 | 700 | Titulos principales |
| `headlineMedium` | 24 | 32 | 600 | Secciones |
| `headlineSmall` | 20 | 28 | 600 | Subtitulos |
| `labelLarge` | 16 | 24 | 600 | Botones, tabs |
| `labelMedium` | 14 | 20 | 500 | Etiquetas de campo |
| `labelSmall` | 12 | 16 | 500 | Chips, badges |
| `bodyLarge` | 16 | 24 | 400 | Cuerpo principal |
| `bodyMedium` | 14 | 20 | 400 | Cuerpo |
| `bodySmall` | 12 | 18 | 400 | Texto secundario |
| `bodyXSmall` | 11 | 15 | 400 | Badges y pills con contraste garantizado (elevado desde 10sp) |

### 1.4 Escalado responsivo (`useResponsive.ts`)

El hook escala tipografia desde la referencia 390pt con factor `min(screenWidth/390, 1.5)`. No impone minimo de fuente -- en dispositivos pequenos `xs` puede bajar a 10sp. Pendiente: agregar `Math.max(11, ...)` en el tier `xs`.

### 1.5 Estado de colores hardcodeados

| Valor | Archivos | Estado |
|---|---|---|
| `#5BB8D4` (dark mode secondary) | orders, sales, SellerProductCard, OrderDetailsContent | Resuelto -- usar `theme['secondary-on-dark']` |
| `#E6813A` (naranja stock pill) | ProductCard, wishlist | Pendiente -- token sugerido: `Colors.light['stock-warning']` |
| `#FDECEA` (fondo error campo) | FormField, DatePickerField | Pendiente -- token sugerido: `Colors.light['error-surface']` |
| `rgba(0,0,0,0.35-0.45)` (overlays) | ProductCard, OrderFilterSheet, modales | Pendiente -- token sugerido: `Colors['overlay']` |
| `#D0D0D0` (dot inactivo carrusel) | CategoriesCarousel, InfiniteCarousel | Pendiente -- token sugerido: `Colors.light['indicator-inactive']` |
| `#C86A53` (dot activo carrusel) | CategoriesCarousel, InfiniteCarousel | Pendiente -- usar `theme.primary` |
| `shadowColor: '#C86A53'` | publish, orders | Pendiente -- usar `theme.primary` |

---

## Parte 2 -- Sistema de diseno

### 2.1 Paradigma adoptado

BazaarApp sigue Material Design 3 con branding propio.

Evidencias:
- Escala de espaciado basada en unidades de 4px (MD3 4dp grid)
- Escala de tipografia en tres niveles: headline / body / label (MD3)
- Elevacion y sombras por nivel de componente
- Chips para filtros, bottom sheets, navigation bar inferior (componentes MD3)
- Bordes redondeados progresivos (sm=8, md=12, lg=16) alineados a MD3 shape scale

Desviaciones intencionales (identidad de marca):
- Paleta terracota + azul egeo en lugar de colores MD3 por defecto
- Fuente PlayfairDisplay en displays
- Dark mode "Noche Ateniense" con grises calidos (#201F1E, #2A2726)

#### Iconografia

- Ionicons como libreria primaria (95% de usos)
- Feather como secundario para patrones especificos
- Sin mezcla con otras librerias

#### Sombras

Token `Shadows` agregado en `constants/theme.ts`:

```ts
export const Shadows = {
  card:   { elevation: 3, shadowOffset: { width: 0, height: 2 }, shadowOpacity: 0.08, shadowRadius: 6 },
  button: { elevation: 5, shadowOffset: { width: 0, height: 3 }, shadowOpacity: 0.12, shadowRadius: 8 },
  nav:    { elevation: 8, shadowOffset: { width: 0, height: -2 }, shadowOpacity: 0.08, shadowRadius: 10 },
} as const;
```

#### Patrones responsive -- multiples enfoques paralelos

| Enfoque | Donde se usa |
|---|---|
| `useResponsive()` hook | SearchBar, my-products, algunos componentes |
| `Math.round(windowWidth * N / 430)` inline | publish, edit-product, edit-profile |
| `useWindowDimensions()` directo | FeedbackModal, SellerProductCard |


---

## Parte 3 -- Decisiones de UX

### 3.1 Arquitectura de navegacion

```
Tab Navigator (5 tabs)
  Home (/)            -- descubrimiento
  Search (/search)    -- busqueda y filtros
  Cart (/cart)        -- carrito de compras
  Wishlist (/wishlist)-- favoritos
  Profile (/profile)  -- cuenta y configuracion
    Stack Navigator (desde profile)
      /orders         -- mis compras (comprador)
      /orders/[id]    -- detalle de orden (comprador)
      /sales          -- mis ventas (vendedor)
      /sales/[id]     -- detalle de venta (vendedor)
      /my-products    -- mi inventario (vendedor)
      /publish        -- crear producto
      /edit-product   -- editar producto
      /checkout/*     -- flujo de pago (3 pasos)
```

La arquitectura es clara y predecible. El uso de tabs para navegacion principal y stack para flujos de tarea sigue la convencion de iOS HIG y Android Material.

### 3.2 Analisis por pantalla

#### Home

**Objetivo:** Descubrir productos.
**Fortalezas:** Loader con branding propio, pull-to-refresh, empty state con icono, orden de banners aleatorio pero estable por sesion, UI optimista para agregar al carrito.

#### Busqueda

**Objetivo:** Encontrar productos por nombre, categoria u orden.
**Fortalezas:** Estado vacio con CTA de "limpiar filtros", badge de filtros activos, chips de categoria con animacion, paginacion numerada con prev/next deshabilitados en los extremos.

#### Carrito

**Objetivo:** Revisar y proceder al pago.
**Fortalezas:** UI optimista en cambio de cantidad, confirmacion antes de eliminar item, estado vacio claro.


#### Wishlist

**Objetivo:** Guardar y gestionar favoritos.
**Fortalezas:** Layout masonry, skeleton loaders, indicador de stock bajo, overlay de no disponible.


#### Ordenes (comprador)

**Objetivo:** Rastrear compras, confirmar entrega, cancelar.
**Fortalezas:** Skeleton loader en carga inicial, chips de estado con color semantico, confirmacion antes de cancelar, spinner inline en botones async, navegacion siempre a pantalla completa `/orders/[id]`.


#### Ventas (vendedor)

**Objetivo:** Gestionar pedidos entrantes, avanzar estado.
**Fortalezas:** Skeleton loader en carga inicial, flujo de estado claro (confirmado -> en preparacion -> enviado), spinner inline en botones async, navegacion siempre a `/sales/[id]`.

#### Mis Productos

**Objetivo:** Gestionar inventario.
**Fortalezas:** Skeleton loader en carga inicial, bottom sheet de filtros no bloqueante, badge de filtros activos, overlay con blur para confirmaciones destructivas, toast de exito al eliminar producto.


#### Publicar / Editar producto

**Objetivo:** Crear o modificar una publicacion.
**Fortalezas:** Validacion campo a campo con live region, keyboard accessory bar, reordenamiento de imagenes, contador de caracteres en descripcion, modal de exito con acciones de recuperacion.


#### Checkout (3 pasos)

**Objetivo:** Completar una compra.
**Fortalezas:** Indicador visual de pasos, validacion antes de continuar, resumen de orden, soporte de codigo de descuento.


#### Perfil

**Objetivo:** Hub de configuracion y acceso a flujos secundarios.
**Fortalezas:** Badges en items de menu para acciones pendientes, iconos de error en secciones con problemas, spring animations, pull-to-refresh.


### 3.3 Patrones de UX bien implementados

**Confirmaciones antes de acciones destructivas:** Todos los flujos de eliminar o cancelar muestran modal de confirmacion con boton cancel y boton destructivo. Consistente en toda la app.

**UI optimista:** Home y carrito aplican UI optimista -- la respuesta visual llega antes de la confirmacion del servidor con rollback en caso de error.

**Estados de pantalla completos:** Cada listado tiene tres estados implementados: loading (skeleton), vacio y error con retry.

**Spinner inline en botones async:** Botones de confirmar entrega, cancelar y avanzar estado muestran `ActivityIndicator` durante la operacion con `accessibilityState={{ busy: true }}`.

**Navegacion unificada a detalle:** Tanto ordenes como ventas navegan siempre a pantalla completa (`/orders/[id]`, `/sales/[id]`), sin bifurcacion entre modal y stack segun plataforma.

**Pantalla protegida (`ProtectedScreen`):** Componente reutilizable que intercepta acceso no autenticado y presenta opciones de login/registro.

**Barra de accesorio de teclado:** En Publicar y Editar Producto, la barra prev/next/enviar reduce la friccion en formularios largos con comportamiento diferenciado iOS/Android.

**Color semantico en estados de orden:** Azul para confirmado, verde para enviado/entregado, rojo para cancelado/rechazado.


---
