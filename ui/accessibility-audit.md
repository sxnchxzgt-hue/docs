# Auditoría de Accesibilidad — BazaarApp

**Fecha:** 2026-06-21  
**Plataformas:** iOS (VoiceOver) · Android (TalkBack)  
**Framework:** React Native 0.79.5 / Expo  
**Metodología:** Revisión estática de código + verificación contra WCAG 2.1 AA y las guías de CLAUDE.md

---

## Resumen ejecutivo

| Métrica | Valor |
|---|---|
| Componentes auditados | 30+ |
| Hallazgos críticos (P0) | 9 |
| Hallazgos altos (P1) | 10 |
| Hallazgos medios (P2) | 5 |
| Componentes con implementación correcta | 7 |

**Evaluación general:** La app tiene buenas bases — el sistema de diseño y varios componentes clave (modales, toasts, cards de vendedor) están correctamente implementados y sirven como referencia. Sin embargo, elementos de uso frecuente como el menú de navegación, el botón de favoritos y varios botones de ícono carecen completamente de etiquetas accesibles, lo que hace que sectores enteros de la UI sean inaccesibles para usuarios de lector de pantalla.

---

## P0 — Críticos (bloqueantes para lectores de pantalla)

Estos problemas impiden que un usuario de VoiceOver/TalkBack pueda operar la funcionalidad afectada.

---

### 1. BottomNav — tabs sin rol ni etiqueta

**Archivo:** [components/BottomNav.tsx](../components/BottomNav.tsx)

Cada pestaña de navegación es un `Pressable` con ícono y texto visual, pero sin ninguna propiedad de accesibilidad. VoiceOver/TalkBack no puede anunciar cuál tab está activa ni cuál es su función.

**Cómo debería ser:**
```tsx
<Pressable
  accessibilityRole="tab"
  accessibilityLabel={t(tab.labelKey)}
  accessibilityState={{ selected: isActive }}
>
  <TabIcon ... />
  <Text>{t(tab.labelKey)}</Text>
</Pressable>
```

---

### 2. HeartButton — sin rol, etiqueta ni estado

**Archivo:** [components/HeartButton.tsx](../components/HeartButton.tsx)

El botón de favoritos es un ícono puro. Un lector de pantalla no puede saber si el producto está en favoritos ni qué hace el botón.

**Cómo debería ser:**
```tsx
<Pressable
  accessibilityRole="button"
  accessibilityLabel={isFavorited ? t('wishlist.remove') : t('wishlist.add')}
  accessibilityState={{ checked: isFavorited }}
  onPress={handleToggle}
>
  <HeartIcon ... />
</Pressable>
```

---

### 3. NotificationButton — sin rol ni etiqueta

**Archivo:** [components/NotificationButton.tsx](../components/NotificationButton.tsx)

Ícono de campana sin ninguna propiedad de accesibilidad. El lector de pantalla omite o anuncia el elemento sin contexto.

**Cómo debería ser:**
```tsx
<Pressable
  accessibilityRole="button"
  accessibilityLabel={t('notifications.button')}
>
  <BellIcon ... />
</Pressable>
```

Si tiene badge de count no leído, incluirlo en el label:
```tsx
accessibilityLabel={
  unreadCount > 0
    ? `${t('notifications.button')} (${unreadCount} ${t('notifications.unread')})`
    : t('notifications.button')
}
```

---

### 4. ThemeSelectorButton — sin rol ni etiqueta

**Archivo:** [components/ThemeSelectorButton.tsx](../components/ThemeSelectorButton.tsx)

**Cómo debería ser:**
```tsx
<Pressable
  accessibilityRole="button"
  accessibilityLabel={isDark ? t('theme.switchToLight') : t('theme.switchToDark')}
>
  <ThemeIcon ... />
</Pressable>
```

---

### 5. LanguageSelectorButton — sin rol ni etiqueta

**Archivo:** [components/LanguageSelectorButton.tsx](../components/LanguageSelectorButton.tsx)

**Cómo debería ser:**
```tsx
<Pressable
  accessibilityRole="button"
  accessibilityLabel={t('language.selector')}
>
  <LanguageIcon ... />
</Pressable>
```

---

### 6. FilterToggleButton — sin rol, etiqueta ni estado

**Archivo:** [components/FilterToggleButton.tsx](../components/FilterToggleButton.tsx)

Botón de filtros que además tiene estado (habilitado/deshabilitado, cantidad activa). Nada se anuncia al lector de pantalla.

**Cómo debería ser** (replicar patrón de `orders.tsx`/`sales.tsx`):
```tsx
<Pressable
  accessibilityRole="button"
  accessibilityLabel={
    activeCount > 0
      ? `${t('filters.button')} (${activeCount} ${t('filters.active')})`
      : t('filters.button')
  }
  accessibilityState={{ disabled }}
>
  <FilterIcon ... />
</Pressable>
```

---

### 7. ShareModal — falta `accessibilityViewIsModal` y labels en botones

**Archivo:** [components/ShareModal.tsx](../components/ShareModal.tsx)

Sin `accessibilityViewIsModal={true}`, VoiceOver/TalkBack no aísla el foco dentro del modal y el usuario puede "escapar" hacia contenido de fondo.

**Cómo debería ser:**
```tsx
<Modal
  visible={visible}
  onRequestClose={onClose}
  accessibilityViewIsModal={true}
>
  {/* botón cerrar */}
  <Pressable
    accessibilityRole="button"
    accessibilityLabel={t('common.close')}
    onPress={onClose}
  >
    <XIcon ... />
  </Pressable>

  {/* acciones */}
  <Pressable accessibilityRole="button" accessibilityLabel={t('share.whatsapp')}>
    ...
  </Pressable>
</Modal>
```

---

### 8. LanguageSelectorModal — falta `accessibilityViewIsModal` y semántica de opciones

**Archivo:** [components/LanguageSelectorModal.tsx](../components/LanguageSelectorModal.tsx)

Además de faltarle `accessibilityViewIsModal`, las opciones de idioma no tienen rol de radio ni estado seleccionado.

**Cómo debería ser:**
```tsx
<Modal
  visible={visible}
  onRequestClose={onClose}
  accessibilityViewIsModal={true}
>
  <View accessibilityRole="radiogroup">
    {LANGUAGES.map((lang) => (
      <Pressable
        key={lang.code}
        accessibilityRole="radio"
        accessibilityLabel={lang.name}
        accessibilityState={{ checked: currentLanguage === lang.code }}
        onPress={() => onSelect(lang.code)}
      >
        <Text>{lang.name}</Text>
        {currentLanguage === lang.code && <CheckIcon ... />}
      </Pressable>
    ))}
  </View>
</Modal>
```

---

### 9. ProductActionModal — falta `accessibilityViewIsModal`

**Archivo:** [components/ProductActionModal.tsx](../components/ProductActionModal.tsx)

El `<Modal>` no tiene `accessibilityViewIsModal={true}`. Los botones de acción sí tienen rol y label (correcto), pero el foco no queda atrapado en el modal.

**Fix mínimo:**
```tsx
<Modal
  visible={visible}
  transparent
  onRequestClose={onDismiss}
  accessibilityViewIsModal={true}   // ← agregar esto
>
```

---

## P1 — Altos (degradan la experiencia)

---

### 10. BannerCard — `TouchableOpacity` sin rol ni etiqueta

**Archivo:** [components/BannerCard.tsx](../components/BannerCard.tsx)

**Fix:**
```tsx
<TouchableOpacity
  accessibilityRole="button"
  accessibilityLabel={displayTitle}
  onPress={onPress}
>
```
Los círculos decorativos deben ocultarse:
```tsx
<View accessibilityElementsHidden importantForAccessibility="no-hide-descendants">
  {/* círculos decorativos */}
</View>
```

---

### 11. CategoryCard — `Pressable` sin rol ni etiqueta

**Archivo:** [components/CategoryCard.tsx](../components/CategoryCard.tsx)

**Fix:**
```tsx
<Pressable
  accessibilityRole="button"
  accessibilityLabel={category.name}
  onPress={() => onPress(category)}
>
  <View accessibilityElementsHidden importantForAccessibility="no-hide-descendants">
    <CategoryIcon ... />
  </View>
  <Text>{category.name}</Text>
</Pressable>
```

---

### 12. SellerCard — `Pressable` sin rol ni etiqueta

**Archivo:** [components/SellerCard.tsx](../components/SellerCard.tsx)

**Fix:**
```tsx
<Pressable
  accessibilityRole="button"
  accessibilityLabel={`${seller.name}, ${seller.rating} ${t('seller.stars')}`}
  onPress={() => onPress(seller)}
>
```

---

### 13. Pagination — botones sin etiquetas

**Archivo:** [components/Pagination.tsx](../components/Pagination.tsx)

**Fix:**
```tsx
// Botón anterior
<Pressable
  accessibilityRole="button"
  accessibilityLabel={t('pagination.previous')}
  accessibilityState={{ disabled: currentPage === 1 }}
>

// Botón siguiente
<Pressable
  accessibilityRole="button"
  accessibilityLabel={t('pagination.next')}
  accessibilityState={{ disabled: currentPage === totalPages }}
>

// Número de página
<Pressable
  accessibilityRole="button"
  accessibilityLabel={
    page === currentPage
      ? `${t('pagination.page')} ${page}, ${t('pagination.current')}`
      : `${t('pagination.page')} ${page}`
  }
  accessibilityState={{ selected: page === currentPage }}
>
```

---

### 14. StarRating (modo interactivo) — estrellas sin rol ni label con valor

**Archivo:** [components/StarRating.tsx](../components/StarRating.tsx)

En modo solo-lectura las estrellas son decorativas (aceptable). En modo interactivo (`onChange` definido) cada estrella debe ser un botón.

**Fix:**
```tsx
{interactive ? (
  <Pressable
    key={star}
    accessibilityRole="button"
    accessibilityLabel={`${star} ${star === 1 ? t('rating.star') : t('rating.stars')}`}
    hitSlop={8}
    onPress={() => onChange!(star)}
  >
    <StarIcon filled={star <= value} />
  </Pressable>
) : (
  <View key={star} accessibilityElementsHidden importantForAccessibility="no">
    <StarIcon filled={star <= value} />
  </View>
)}
```

Para el modo read-only, el contenedor debe anunciar el valor:
```tsx
<View
  accessibilityLabel={`${value} ${t('rating.of')} 5 ${t('rating.stars')}`}
  accessibilityRole="text"
>
  {/* estrellas decorativas */}
</View>
```

---

### 15. SearchEmptyState — CTA sin rol

**Archivo:** [components/SearchEmptyState.tsx](../components/SearchEmptyState.tsx)

**Fix:**
```tsx
<Pressable
  accessibilityRole="button"
  onPress={onClear}
>
  <Text>{t('search.clearFilters')}</Text>
</Pressable>
```

---

### 16. CategoriesCarousel / InfiniteCarousel — sin labels; dots no ocultos

**Archivos:** [components/CategoriesCarousel.tsx](../components/CategoriesCarousel.tsx), [components/InfiniteCarousel.tsx](../components/InfiniteCarousel.tsx)

**Fix:**
```tsx
// Contenedor de dots decorativos
<View accessibilityElementsHidden importantForAccessibility="no-hide-descendants">
  {items.map((_, i) => <Dot key={i} active={i === current} />)}
</View>
```

---

### 17. Íconos decorativos no ocultos — ProductCard flame, status icons

**Archivos:** [components/ProductCard.tsx](../components/ProductCard.tsx), [app/orders.tsx](../app/orders.tsx), [app/sales.tsx](../app/sales.tsx)

El ícono de llama (stock bajo) y algunos íconos de estado en chips no están marcados como decorativos.

**Fix (patrón replicable):**
```tsx
<Feather
  name="flame"
  size={12}
  color={theme.destructive}
  accessibilityElementsHidden
  importantForAccessibility="no"
/>
```

---

### 18. Stepper de cantidad — sin `accessibilityLiveRegion` en el valor

**Archivo:** [components/ProductCard.tsx](../components/ProductCard.tsx)

Cuando el usuario pulsa + o − el valor cambia visualmente pero no se anuncia al lector de pantalla.

**Fix:**
```tsx
<Text
  accessibilityLiveRegion="polite"
  accessibilityLabel={`${t('cart.quantity')}: ${quantity}`}
  style={styles.stepperValue}
>
  {quantity}
</Text>
```

---

## P2 — Medios (mejoras recomendadas)

---

### 19. SearchBar — TextInput sin label explícito

**Archivo:** [components/SearchBar.tsx](../components/SearchBar.tsx)

El `placeholder` no es un sustituto confiable de `accessibilityLabel` (VoiceOver puede no anunciarlo).

**Fix:**
```tsx
<TextInput
  accessibilityLabel={t('search.inputLabel')}
  placeholder={t('search.placeholder')}
  ...
/>
```
El ícono de búsqueda debe ocultarse:
```tsx
<Feather name="search" accessibilityElementsHidden importantForAccessibility="no" />
```

---

### 20. ProductImageGallery — dots sin ocultar

**Archivo:** [components/ProductImageGallery.tsx](../components/ProductImageGallery.tsx)

**Fix:**
```tsx
<View accessibilityElementsHidden importantForAccessibility="no-hide-descendants">
  {images.map((_, i) => <Dot key={i} />)}
</View>
```

---

### 21. ReviewCard — sin rol semántico de artículo

**Archivo:** [components/ReviewCard.tsx](../components/ReviewCard.tsx)

**Fix:**
```tsx
<View accessibilityRole="article">
  {/* contenido de la reseña */}
</View>
```

---

### 22. LoadingSkeletons — visible en árbol de accesibilidad

**Archivo:** [components/LoadingSkeletons.tsx](../components/LoadingSkeletons.tsx)

Los skeletons son decorativos. VoiceOver/TalkBack los anuncia como elementos vacíos.

**Fix:**
```tsx
<View accessibilityElementsHidden importantForAccessibility="no-hide-descendants">
  {/* shimmer lines */}
</View>
```

---

### 23. OrderDetailsContent — link de vendedor sin rol

**Archivo:** [components/OrderDetailsContent.tsx](../components/OrderDetailsContent.tsx)

**Fix:**
```tsx
<Pressable
  accessibilityRole="link"
  accessibilityLabel={`${t('order.seller')}: ${sellerName}`}
  onPress={onSellerPress}
>
```

---

## Implementaciones correctas (usar como referencia)

Estos componentes implementan accesibilidad correctamente y deben tomarse como modelo al escribir código nuevo.

### OrderFilterSheet.tsx — referencia de modal interactivo complejo

Implementa: `accessibilityViewIsModal`, chips con `accessibilityRole="checkbox"` + `accessibilityState={{ checked }}`, radios con `accessibilityRole="radio"` + `accessibilityState={{ selected }}`, botones con labels dinámicos, íconos decorativos ocultos.

### ErrorToast.tsx — referencia de notificación de error

```tsx
<View accessibilityLiveRegion="assertive" accessibilityRole="alert">
  {/* mensaje de error */}
</View>
```

### FeedbackModal.tsx — referencia de modal con acciones

Implementa: `accessibilityViewIsModal`, `onRequestClose`, botón cerrar con `accessibilityRole="button"` + `accessibilityLabel`, botones de acción con roles.

### SellerProductCard.tsx — referencia de card compleja

Implementa: card principal con `accessibilityRole="button"` + label con nombre del producto, botón de toggle con label dinámico según estado, botón de eliminar con `accessibilityState={{ disabled, busy }}`.

### publish.tsx / edit-product.tsx — referencia de errores de campo

```tsx
function FieldError({ msg, theme }) {
  return (
    <View accessibilityLiveRegion="polite">
      {msg ? (
        <View style={styles.fieldErrorRow}>
          <Feather
            name="alert-circle"
            size={12}
            importantForAccessibility="no"
            accessibilityElementsHidden
          />
          <Text style={{ color: theme.destructive }}>{msg}</Text>
        </View>
      ) : null}
    </View>
  );
}
```

### orders.tsx / sales.tsx — referencia de chips de filtro

```tsx
<Pressable
  accessibilityRole="radio"
  accessibilityState={{ selected: isActive }}
  accessibilityLabel={t(`orders.status.${status}`)}
>
  <Ionicons
    name={palette.icon}
    size={12}
    accessibilityElementsHidden
    importantForAccessibility="no"
  />
  <Text>{t(`orders.status.${status}`)}</Text>
</Pressable>
```

---

## Tabla de componentes auditados

| Componente | Archivo | Estado | Prioridad |
|---|---|---|---|
| `BottomNav` | components/BottomNav.tsx | ❌ | P0 |
| `HeartButton` | components/HeartButton.tsx | ❌ | P0 |
| `NotificationButton` | components/NotificationButton.tsx | ❌ | P0 |
| `ThemeSelectorButton` | components/ThemeSelectorButton.tsx | ❌ | P0 |
| `LanguageSelectorButton` | components/LanguageSelectorButton.tsx | ❌ | P0 |
| `FilterToggleButton` | components/FilterToggleButton.tsx | ❌ | P0 |
| `ShareModal` | components/ShareModal.tsx | ❌ | P0 |
| `LanguageSelectorModal` | components/LanguageSelectorModal.tsx | ❌ | P0 |
| `ProductActionModal` | components/ProductActionModal.tsx | ⚠️ | P0 |
| `BannerCard` | components/BannerCard.tsx | ❌ | P1 |
| `CategoryCard` | components/CategoryCard.tsx | ❌ | P1 |
| `SellerCard` | components/SellerCard.tsx | ❌ | P1 |
| `Pagination` | components/Pagination.tsx | ⚠️ | P1 |
| `StarRating` (interactivo) | components/StarRating.tsx | ⚠️ | P1 |
| `SearchEmptyState` | components/SearchEmptyState.tsx | ⚠️ | P1 |
| `CategoriesCarousel` | components/CategoriesCarousel.tsx | ❌ | P1 |
| `InfiniteCarousel` | components/InfiniteCarousel.tsx | ❌ | P1 |
| `ProductCard` (flame + stepper) | components/ProductCard.tsx | ⚠️ | P1 |
| `SearchBar` | components/SearchBar.tsx | ⚠️ | P2 |
| `ProductImageGallery` | components/ProductImageGallery.tsx | ⚠️ | P2 |
| `ReviewCard` | components/ReviewCard.tsx | ⚠️ | P2 |
| `LoadingSkeletons` | components/LoadingSkeletons.tsx | ⚠️ | P2 |
| `OrderDetailsContent` | components/OrderDetailsContent.tsx | ⚠️ | P2 |
| `OrderFilterSheet` | components/OrderFilterSheet.tsx | ✅ | — |
| `FeedbackModal` | components/FeedbackModal.tsx | ✅ | — |
| `ErrorToast` | components/ErrorToast.tsx | ✅ | — |
| `SellerProductCard` | components/SellerProductCard.tsx | ✅ | — |
| `Button` | components/Button.tsx | ✅ | — |
| `publish.tsx` | app/publish.tsx | ✅ | — |
| `edit-product.tsx` | app/edit-product.tsx | ✅ | — |
| `orders.tsx` | app/orders.tsx | ✅ | — |
| `sales.tsx` | app/sales.tsx | ✅ | — |
| `my-products.tsx` | app/my-products.tsx | ✅ | — |
| `edit-profile.tsx` | app/(tabs)/edit-profile.tsx | ✅ | — |

**Leyenda:** ✅ Correcto · ⚠️ Parcial · ❌ Sin accesibilidad

---

## Checklist de QA — VoiceOver (iOS) y TalkBack (Android)

### Configuración

**iOS:** Ajustes → Accesibilidad → VoiceOver → Activar  
**Android:** Ajustes → Accesibilidad → TalkBack → Activar

### Flujo de comprador

- [ ] Navegar entre tabs con VoiceOver/TalkBack — cada tab anuncia nombre y estado seleccionado
- [ ] Scroll en listado de productos — cada card anuncia nombre del producto
- [ ] Pulsar HeartButton — anuncia "Agregar a favoritos" o "Quitar de favoritos" según estado
- [ ] Abrir detalle de producto — título anunciado como cabecera
- [ ] Ajustar cantidad con stepper — el nuevo valor se anuncia al cambiar
- [ ] Agregar al carrito — botón deshabilitado (stock 0) se anuncia como deshabilitado
- [ ] Abrir ShareModal — el foco queda atrapado dentro del modal
- [ ] Cerrar ShareModal — el foco regresa al elemento que lo abrió

### Flujo de búsqueda y filtros

- [ ] Campo de búsqueda — anuncia "Buscar" o label equivalente (no solo placeholder)
- [ ] Abrir FilterSheet — anuncia "expandido/contraído" en el botón
- [ ] Chips de filtro de estado — anuncian nombre y si están seleccionados
- [ ] Opciones de orden — anuncian nombre y si están seleccionadas
- [ ] Botón "Limpiar filtros" — accesible y con label claro
- [ ] Categorías en carrusel — anuncian nombre de categoría

### Flujo de vendedor

- [ ] Navegar a "Mis productos" desde BottomNav — tab correcto anunciado
- [ ] Botón de visibilidad toggle en SellerProductCard — anuncia estado actual
- [ ] Eliminar producto — botón con estado busy durante operación
- [ ] Publicar producto — errores de campo se anuncian con live region

### Modales y notificaciones

- [ ] FeedbackModal (éxito/error) — anuncia mensaje al aparecer
- [ ] ErrorToast — anunciado como alerta inmediatamente
- [ ] LanguageSelectorModal — opciones de idioma como radio buttons
- [ ] ProductActionModal (eliminar/bloquear) — foco atrapado, botón destructivo accesible

### Configuración de perfil

- [ ] ThemeSelectorButton — anuncia tema actual y acción
- [ ] LanguageSelectorButton — anuncia idioma actual y acción
- [ ] Formulario de perfil — todos los campos tienen labels (no solo placeholders)
- [ ] StarRating interactivo — cada estrella anuncia su valor

---

## Reglas a incorporar en revisiones de código

1. Todo `Pressable` o `TouchableOpacity` que contenga solo un ícono **debe** tener `accessibilityRole="button"` y `accessibilityLabel`.
2. Todo `<Modal>` **debe** tener `accessibilityViewIsModal={true}` y `onRequestClose`.
3. Grupos de opciones mutuamente excluyentes usan `accessibilityRole="radio"` + `accessibilityState={{ checked }}` en cada opción.
4. Grupos de opciones múltiples usan `accessibilityRole="checkbox"` + `accessibilityState={{ checked }}`.
5. Íconos dentro de botones con texto **deben** tener `accessibilityElementsHidden` + `importantForAccessibility="no"`.
6. Valores que cambian dinámicamente (cantidad, errores) **deben** estar en un `View` con `accessibilityLiveRegion="polite"`.
7. Errores urgentes (toasts) usan `accessibilityLiveRegion="assertive"` + `accessibilityRole="alert"`.
8. `placeholder` no reemplaza a `accessibilityLabel` en TextInputs.
