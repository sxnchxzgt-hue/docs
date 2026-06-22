# Auditoría de Accesibilidad -- BazaarApp

**Fecha de auditoría:** 2026-06-21
**Plataformas:** iOS (VoiceOver) - Android (TalkBack)
**Framework:** React Native 0.79.5 / Expo
**Metodología:** Revisión estática de código contra WCAG 2.1 AA y guías de CLAUDE.md

---

## Tabla de componentes

| Componente | Archivo | Estado | Descripción del fix |
|---|---|---|---|
| `BottomNav` | [components/BottomNav.tsx](../components/BottomNav.tsx) | OK | `accessibilityRole="tab"` + `accessibilityLabel` + `accessibilityState={{ selected }}` en cada tab |
| `HeartButton` | [components/HeartButton.tsx](../components/HeartButton.tsx) | OK | `accessibilityRole="button"` + label dinámico ("Agregar/Quitar de favoritos") + `accessibilityState={{ checked }}` |
| `NotificationButton` | [components/NotificationButton.tsx](../components/NotificationButton.tsx) | OK | `accessibilityRole="button"` + label con count de no leídos si corresponde |
| `ThemeSelectorButton` | [components/ThemeSelectorButton.tsx](../components/ThemeSelectorButton.tsx) | OK | `accessibilityRole="button"` + label dinámico según tema activo |
| `LanguageSelectorButton` | [components/LanguageSelectorButton.tsx](../components/LanguageSelectorButton.tsx) | OK | `accessibilityRole="button"` + `accessibilityLabel="Cambiar idioma"` |
| `FilterToggleButton` | [components/FilterToggleButton.tsx](../components/FilterToggleButton.tsx) | OK | `accessibilityRole="button"` + label con count de filtros activos + `accessibilityState={{ disabled }}` |
| `ShareModal` | [components/ShareModal.tsx](../components/ShareModal.tsx) | OK | `accessibilityViewIsModal={true}` en `<Modal>` + `accessibilityRole="button"` + label en botón cerrar y acciones |
| `LanguageSelectorModal` | [components/LanguageSelectorModal.tsx](../components/LanguageSelectorModal.tsx) | OK | `accessibilityViewIsModal={true}` + opciones envueltas en `<View accessibilityRole="radiogroup">` + cada opción con `accessibilityRole="radio"` + `accessibilityState={{ checked }}` |
| `ProductActionModal` | [components/ProductActionModal.tsx](../components/ProductActionModal.tsx) | OK | `accessibilityViewIsModal={true}` agregado al `<Modal>` |
| `BannerCard` | [components/BannerCard.tsx](../components/BannerCard.tsx) | OK | `accessibilityRole="button"` + `accessibilityLabel` con título del banner; elementos decorativos ocultos |
| `CategoryCard` | [components/CategoryCard.tsx](../components/CategoryCard.tsx) | OK | `accessibilityRole="button"` + `accessibilityLabel` con nombre de categoría; ícono oculto |
| `SellerCard` | [components/SellerCard.tsx](../components/SellerCard.tsx) | OK | `accessibilityRole="button"` + `accessibilityLabel` con nombre y rating del vendedor |
| `Pagination` | [components/Pagination.tsx](../components/Pagination.tsx) | OK | Botones prev/next con `accessibilityLabel` y `accessibilityState={{ disabled }}`; números de página con label que indica la página actual |
| `StarRating` | [components/StarRating.tsx](../components/StarRating.tsx) | OK | Modo interactivo: cada estrella con `accessibilityRole="button"` + label de valor + `hitSlop={8}`. Modo lectura: contenedor con `accessibilityLabel` del total; estrellas individuales ocultas |
| `SearchEmptyState` | [components/SearchEmptyState.tsx](../components/SearchEmptyState.tsx) | OK | `accessibilityRole="button"` en CTA de limpiar filtros |
| `CategoriesCarousel` | [components/CategoriesCarousel.tsx](../components/CategoriesCarousel.tsx) | OK | Contenedor de dots con `accessibilityElementsHidden` + `importantForAccessibility="no-hide-descendants"` |
| `InfiniteCarousel` | [components/InfiniteCarousel.tsx](../components/InfiniteCarousel.tsx) | OK | Igual que `CategoriesCarousel` |
| `ProductCard` | [components/ProductCard.tsx](../components/ProductCard.tsx) | OK | Ícono de llama oculto con `accessibilityElementsHidden`; display de cantidad del stepper con `accessibilityLiveRegion="polite"` |
| `SearchBar` | [components/SearchBar.tsx](../components/SearchBar.tsx) | OK | `accessibilityLabel` explícito en `TextInput`; ícono de búsqueda oculto |
| `ProductImageGallery` | [components/ProductImageGallery.tsx](../components/ProductImageGallery.tsx) | OK | Contenedor de dots con `accessibilityElementsHidden` |
| `ReviewCard` | [components/ReviewCard.tsx](../components/ReviewCard.tsx) | OK | Estructura semántica correcta por texto visible; `accessibilityRole="article"` no es tipo válido en RN |
| `LoadingSkeletons` | [components/LoadingSkeletons.tsx](../components/LoadingSkeletons.tsx) | OK | Root views con `accessibilityElementsHidden` + `importantForAccessibility="no-hide-descendants"` |
| `OrderDetailsContent` | [components/OrderDetailsContent.tsx](../components/OrderDetailsContent.tsx) | OK | Link de vendedor con `accessibilityRole="link"` + `accessibilityLabel` |
| `OrderFilterSheet` | [components/OrderFilterSheet.tsx](../components/OrderFilterSheet.tsx) | OK | Correcto desde el inicio -- referencia de implementación |
| `FeedbackModal` | [components/FeedbackModal.tsx](../components/FeedbackModal.tsx) | OK | Correcto desde el inicio -- referencia de implementación |
| `ErrorToast` | [components/ErrorToast.tsx](../components/ErrorToast.tsx) | OK | Correcto desde el inicio -- referencia de implementación |
| `SellerProductCard` | [components/SellerProductCard.tsx](../components/SellerProductCard.tsx) | OK | Correcto desde el inicio -- referencia de implementación |
| `Button` | [components/Button.tsx](../components/Button.tsx) | OK | Correcto desde el inicio -- referencia de implementación |
| `publish.tsx` | [app/publish.tsx](../app/publish.tsx) | OK | Correcto desde el inicio |
| `edit-product.tsx` | [app/edit-product.tsx](../app/edit-product.tsx) | OK | Correcto desde el inicio |
| `orders.tsx` | [app/orders.tsx](../app/orders.tsx) | OK | Correcto desde el inicio |
| `sales.tsx` | [app/sales.tsx](../app/sales.tsx) | OK | Correcto desde el inicio |
| `my-products.tsx` | [app/my-products.tsx](../app/my-products.tsx) | OK | Correcto desde el inicio |
| `edit-profile.tsx` | [app/(tabs)/edit-profile.tsx](../app/(tabs)/edit-profile.tsx) | OK | Correcto desde el inicio |

---

## Patrones de referencia

Estos componentes implementan accesibilidad correctamente y deben tomarse como modelo al escribir código nuevo.

### Modal con foco atrapado -- `FeedbackModal`, `ShareModal`, `LanguageSelectorModal`

```tsx
<Modal
  visible={visible}
  onRequestClose={onClose}
  accessibilityViewIsModal={true}
>
  <Pressable
    accessibilityRole="button"
    accessibilityLabel={t('common.close')}
    onPress={onClose}
  >
    <Feather name="x" size={20} />
  </Pressable>
  {/* contenido */}
</Modal>
```

### Grupo de opciones exclusivas -- `OrderFilterSheet`, `LanguageSelectorModal`

```tsx
<View accessibilityRole="radiogroup">
  {options.map((opt) => (
    <Pressable
      key={opt.value}
      accessibilityRole="radio"
      accessibilityLabel={opt.label}
      accessibilityState={{ checked: selected === opt.value }}
      onPress={() => onSelect(opt.value)}
    >
      <Feather
        name={opt.icon}
        accessibilityElementsHidden
        importantForAccessibility="no"
      />
      <Text>{opt.label}</Text>
    </Pressable>
  ))}
</View>
```

### Notificación dinámica de error -- `publish.tsx`, `edit-product.tsx`

```tsx
// El contenedor siempre está montado para que el live region observe cambios
function FieldError({ msg, theme }) {
  return (
    <View accessibilityLiveRegion="polite">
      {msg ? (
        <View style={styles.fieldErrorRow}>
          <Feather
            name="alert-circle"
            size={12}
            color={theme.destructive}
            accessibilityElementsHidden
            importantForAccessibility="no"
          />
          <Text style={{ color: theme.destructive }}>{msg}</Text>
        </View>
      ) : null}
    </View>
  );
}
```

### Alerta urgente -- `ErrorToast`

```tsx
<View
  accessibilityLiveRegion="assertive"
  accessibilityRole="alert"
>
  <Text>{message}</Text>
</View>
```

### Botón async con spinner -- `orders/[id].tsx`, `sales/[id].tsx`

```tsx
<Pressable
  disabled={isLoading}
  accessibilityRole="button"
  accessibilityState={{ disabled: isLoading, busy: isLoading }}
  onPress={handleAction}
>
  {isLoading
    ? <ActivityIndicator size="small" color="#FFFFFF" />
    : <Text style={styles.buttonText}>{t('action.label')}</Text>}
</Pressable>
```

### Ícono decorativo dentro de botón con texto

```tsx
<Pressable accessibilityRole="button" accessibilityLabel={t('action.label')}>
  <Feather
    name="refresh-cw"
    size={16}
    accessibilityElementsHidden
    importantForAccessibility="no"
  />
  <Text>{t('action.label')}</Text>
</Pressable>
```

### Stepper con anuncio de valor -- `ProductCard`

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

## Reglas para revisiones de código

1. Todo `Pressable` o `TouchableOpacity` que contenga solo un ícono **debe** tener `accessibilityRole="button"` y `accessibilityLabel`.
2. Todo `<Modal>` **debe** tener `accessibilityViewIsModal={true}` y `onRequestClose`.
3. Grupos de opciones mutuamente excluyentes usan `accessibilityRole="radio"` + `accessibilityState={{ checked }}` dentro de un `<View accessibilityRole="radiogroup">`.
4. Grupos de opciones múltiples usan `accessibilityRole="checkbox"` + `accessibilityState={{ checked }}`.
5. Íconos dentro de botones con texto **deben** tener `accessibilityElementsHidden` + `importantForAccessibility="no"`.
6. Elementos decorativos (dots, círculos, íconos de fondo) se ocultan con `accessibilityElementsHidden` + `importantForAccessibility="no-hide-descendants"` en su `View` contenedor.
7. Valores que cambian dinámicamente (cantidad, errores de campo) **deben** estar en un `View` o `Text` con `accessibilityLiveRegion="polite"`. El contenedor debe estar **siempre montado** (no condicional) para que el live region observe los cambios.
8. Alertas urgentes (toasts de error) usan `accessibilityLiveRegion="assertive"` + `accessibilityRole="alert"`.
9. `placeholder` no reemplaza a `accessibilityLabel` en `TextInput`.
10. Botones async deben usar `accessibilityState={{ disabled: isLoading, busy: isLoading }}` y reemplazar el texto por `<ActivityIndicator />` durante la carga.

---

## Checklist de QA -- VoiceOver (iOS) y TalkBack (Android)

**Activar VoiceOver:** Ajustes -> Accesibilidad -> VoiceOver
**Activar TalkBack:** Ajustes -> Accesibilidad -> TalkBack

### Navegación principal

- [ ] Navegar entre tabs -- cada tab anuncia nombre y estado seleccionado/no seleccionado
- [ ] Tocar `HeartButton` -- anuncia "Agregar a favoritos" o "Quitar de favoritos" según estado actual
- [ ] Tocar `NotificationButton` -- anuncia "Notificaciones" (con count si hay no leídas)
- [ ] Tocar `ThemeSelectorButton` -- anuncia la acción ("Cambiar a modo oscuro / claro")
- [ ] Tocar `LanguageSelectorButton` -- anuncia "Cambiar idioma"

### Flujo de comprador

- [ ] Scroll en listado de productos -- cada card anuncia nombre del producto
- [ ] Ajustar cantidad con stepper -- el nuevo valor se anuncia al cambiar
- [ ] Agregar al carrito (stock 0) -- botón anunciado como deshabilitado
- [ ] Abrir `ShareModal` -- foco queda atrapado; cerrar devuelve foco al elemento que lo abrió
- [ ] Navegar categorías en carrusel -- anuncia nombre de cada categoría (no los dots)
- [ ] Paginación en búsqueda -- botones prev/next anuncian si están deshabilitados; botón de página actual indica "página actual"

### Flujo de órdenes

- [ ] Abrir detalle de orden -- navega a pantalla completa
- [ ] Botón "Confirmar entrega" en proceso -- muestra spinner, anuncia `busy`
- [ ] Botón "Cancelar" en proceso -- muestra spinner, anuncia `busy`
- [ ] Filtros de estado -- chips anuncian nombre y si están seleccionados
- [ ] Botón de filtrar -- anuncia cantidad de filtros activos si los hay

### Flujo de vendedor

- [ ] Botón de visibilidad en `SellerProductCard` -- anuncia estado actual
- [ ] Eliminar producto -- botón con `busy` durante la operación; toast de éxito anunciado al completar
- [ ] Abrir detalle de venta -- navega a pantalla completa
- [ ] Botones de avanzar estado en proceso -- muestran spinner, anuncian `busy`
- [ ] Publicar producto -- errores de campo anunciados con live region al aparecer

### Modales y notificaciones

- [ ] `FeedbackModal` (éxito/error) -- foco atrapado; mensaje anunciado al aparecer
- [ ] `ErrorToast` -- anunciado inmediatamente como alerta
- [ ] `LanguageSelectorModal` -- opciones anunciadas como radio buttons con estado seleccionado
- [ ] `ProductActionModal` -- foco atrapado; botón destructivo accesible

### Formularios

- [ ] Campo de búsqueda -- anuncia "Buscar productos" (no solo el placeholder)
- [ ] Campos de publicación -- todos con label explícito; errores anunciados con live region
- [ ] `StarRating` interactivo (reseñas) -- cada estrella anuncia su valor numérico
- [ ] `LanguageSelectorModal` -- opciones con `accessibilityRole="radio"` y estado `checked`
