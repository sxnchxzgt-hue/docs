# GranBazaar — Seeds de Desarrollo

Seeds para poblar todos los servicios con datos coherentes y listos para recorrer los flujos
principales de la aplicación. Son **idempotentes**: se pueden ejecutar múltiples veces sin errores.

---

## Estructura

```
seeds/
├── README.md          ← este archivo
├── seed-all.sh        ← script master (ejecuta los 4 seeds en orden)
├── .env.example       ← variables de conexión
└── sql/
    ├── 01_users.sql       → UserService       (puerto 5432)
    ├── 02_catalog.sql     → CatalogService    (puerto 5433)
    ├── 03_checkout.sql    → CheckoutOrders    (puerto 5434)
    └── 04_wishlist.sql    → WishListService   (puerto 5435)
```

---

## Orden de dependencia

```
01_users.sql
    └─► 02_catalog.sql   (products referencian seller_id de users)
            └─► 03_checkout.sql  (orders referencian product_id y buyer_id)
                    └─► 04_wishlist.sql  (product_id deben existir en catalog)
```

Ejecutar siempre en ese orden. El script `seed-all.sh` lo hace automáticamente.

---

## Cómo ejecutar

### Opción A — Script master (recomendado)

```bash
cd /ruta/al/repo/docs/seeds

# Opcional: copiar y editar variables de conexión
cp .env.example .env

bash seed-all.sh
```

### Opción B — Por servicio (con Docker Compose)

Desde el directorio de cada servicio con los contenedores levantados:

```bash
# 1. UserService
docker compose exec -T db \
  psql -U granbazaar -d granbazaar \
  -f /docker-entrypoint-initdb.d/01_users.sql

# 2. CatalogService
docker compose exec -T postgres \
  psql -U postgres -d granbazaar_catalog \
  -f /migrations/02_catalog.sql

# 3. CheckoutOrdersService
docker compose exec -T postgres \
  psql -U postgres -d granbazaar_checkout_order \
  -f /migrations/03_checkout.sql

# 4. WishListService
docker compose exec -T postgres \
  psql -U postgres -d granbazaar_wishlist \
  -f /migrations/04_wishlist.sql
```

### Opción C — Script individual por servicio

Cada servicio tiene su propio `scripts/seed-database.sh` que aplica su SQL local.

---

## Datos generados

### Usuarios (01_users.sql)

| Rol | auth0_id | Email |
|-----|----------|-------|
| Admin | `aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa` | admin@granbazaar.dev |
| Comprador | `cccccccc-...-cccccccccc01` | laura.mendez@example.com |
| Comprador | `cccccccc-...-cccccccccc02` | carlos.herrera@example.com |
| Comprador | `cccccccc-...-cccccccccc03` | maria.garcia@example.com |
| Vendedor | `550e8400-...-446655440001` | TecnoShop BA |
| Vendedor | `550e8400-...-446655440002` | Moda Porteña |
| Vendedor | `550e8400-...-446655440003` | Casa & Deco |
| Vendedor | `550e8400-...-446655440004` | Bella Natura |
| Vendedor | `550e8400-...-446655440005` | El Mundo del Niño |
| Vendedor | `550e8400-...-446655440006` | SportZone Pro |
| Vendedor | `550e8400-...-446655440007` | Bazar del Centro |
| Vendedor vacío | `eeeeeeee-...-eeeeeeeeeeee` | Tienda Nueva |
| Vendedor bloqueado | `bbbbbbbb-...-bbbbbbbbbbbb` | Outlet Express |

### Productos (02_catalog.sql)

| ID | Nombre | Estado | Categoría |
|----|--------|--------|-----------|
| 1 | Samsung Galaxy A54 | activo | Electrónica |
| 2 | Auriculares Sony WH-CH720 | activo | Electrónica |
| 3 | Camiseta Básica Premium | **inactivo** | Ropa |
| 4 | Zapatillas Running Pro | activo | Ropa |
| 5 | Lámpara LED de Piso | activo | Hogar |
| 6 | Almohada Premium Memory Foam | activo | Hogar |
| 7 | Crema Facial Hidratante | activo | Belleza |
| 8 | Perfume Essence | activo | Belleza |
| 9 | Juego de Construcción 1000 piezas | activo | Juguetes |
| 10 | Andador para Bebé | activo | Juguetes |
| 11 | Mancuernas Ajustables 20kg | activo | Deportes |
| 12 | Colchoneta Yoga Premium | activo | Deportes |
| 13 | Teclado Mecánico RGB | activo | Computación |
| 14 | Mouse Inalámbrico Pro | activo | Computación |
| 15 | Licuadora Digital 2000W | activo | Electrodomésticos |
| 16 | Microondas Inteligente | activo | Electrodomésticos |
| 17 | Kit de Herramientas 20 piezas | activo | Automotor |
| 18 | Pedal de Acelerador Deportivo | activo | Automotor |
| 19 | Comida Premium para Perros | activo, **sin stock** | Mascotas |
| 20 | Juguete Interactivo para Perro | **inactivo** | Mascotas |
| 61 | Marketplace Headphones Pro | activo | Electrónica |
| 62 | Marketplace Smart Watch | activo | Electrónica |
| 63 | Marketplace Archived Item | **inactivo** | Electrónica |

### Órdenes (03_checkout.sql)

| ID corto | Comprador | Estado | Total |
|----------|-----------|--------|-------|
| `...111101` | Laura | `delivered` (con cupón TECH10 −10%) | $269.99 |
| `...111102` | Carlos | `shipped` | $89.99 |
| `...111103` | María | `confirmed` | $104.98 |
| `...111104` | Carlos | `cancelled` | $189.99 |
| `...111105` | María | `pending_payment` | $69.99 |
| `...111106` | Laura | `delivered` | $69.99 |

### Cupones (03_checkout.sql)

| Código | Descuento | Estado |
|--------|-----------|--------|
| TECH10 | 10% | activo |
| MODA20 | 20% | activo |
| HOGAR15 | 15% | activo |
| DEPORTE25 | 25% | activo |
| EXPIRED5 | 5% | **vencido** |

---

## Imágenes de productos en Supabase

> **Las fotos de perfil de usuarios NO se seedean por SQL** — el campo `photo` en UserService
> es `BYTEA` (binario) y se sube a través de la API. Solo se necesitan imágenes de **productos**.

Bucket: `product_bazaar/oficial/`

### Estado actual de imágenes

| ID | Producto | Imagen | Estado |
|----|----------|--------|--------|
| 1 | Samsung Galaxy A54 | `oficial/Samsung%20Galaxy%20A54.png` | ✅ en SQL |
| 2 | Auriculares Sony WH-CH720 | `oficial/Auriculares%20Sony%20WH-CH720.jpg` | ✅ en SQL |
| 3 | Camiseta Básica Premium (inactivo) | `oficial/Camiseta%20Basica%20Premium.webp` | ✅ en SQL |
| 4 | Zapatillas Running Pro | `oficial/Zapatillas%20Running%20Pro.webp` | ✅ en SQL |
| 5 | Lámpara LED de Piso | `oficial/Lampara%20LED%20de%20Piso.jpg` | ✅ en SQL |
| 6 | Almohada Premium Memory Foam | `oficial/Almohada%20Premium%20Memory%20Foam.jpg` | ✅ en SQL |
| 7 | Crema Facial Hidratante | `oficial/Crema%20Facial%20Hidratante.webp` | ✅ en SQL |
| 8 | Perfume Essence | `oficial/Perfume%20Essence.jpg` | ✅ en SQL |
| 9 | Juego de Construcción 1000 piezas | `oficial/Juego%20de%20ConstrucciOn%201000%20piezas.webp` | ✅ en SQL |
| 10 | Andador para Bebé | `oficial/Andador%20para%20Bebe.png` | ✅ en SQL |
| 11 | Mancuernas Ajustables 20kg | `oficial/Mancuernas%20Ajustables%2020kg.webp` | ✅ en SQL |
| 12 | Colchoneta Yoga Premium | `oficial/Colchoneta%20Yoga%20Premium.webp` | ✅ en SQL |
| 13 | Teclado Mecánico RGB | `oficial/Teclado%20Mecanico%20RGB.jpg` | ✅ en SQL |
| 14 | Mouse Inalámbrico Pro | `oficial/Mouse%20Inalambrico%20Pro.png` | ✅ en SQL |
| 15 | Licuadora Digital 2000W | `oficial/Licuadora%20Digital%202000W.jpg` | ✅ en SQL |
| 16 | Microondas Inteligente | `oficial/Microondas%20Inteligente.webp` | ✅ en SQL |
| 17 | Kit de Herramientas 20 piezas | `oficial/Kit%20de%20Herramientas%2020%20piezas.webp` | ✅ en SQL |
| 18 | Pedal de Acelerador Deportivo | `oficial/Pedal%20de%20Acelerador%20Deportivo.webp` | ✅ en SQL |
| 19 | Comida Premium para Perros | `oficial/Comida%20Premium%20para%20Perros.webp` | ✅ en SQL |
| 20 | Juguete Interactivo para Perro | `oficial/Juguete%20Interactivo%20para%20Perro.webp` | ✅ en SQL |
| 61 | Marketplace Headphones Pro | `oficial/Marketplace%20Headphones%20Pro.jpg` | ✅ en SQL |
| 62 | Marketplace Smart Watch | `oficial/Marketplace%20Smart%20Watch.jpg` | ✅ en SQL |
| 63 | Marketplace Archived Item (inactivo) | `oficial/Zapatillas%20Running%20Pro.webp` | ✅ en SQL |

#### Nuevos productos (IDs 21–50)

| ID | Producto | Estado |
|----|----------|--------|
| 21 | iPhone 15 Pro 256GB | ✅ en SQL |
| 22 | Tablet Samsung Galaxy Tab A9 | ✅ en SQL |
| 23 | Powerbank 20000mAh Carga Rapida | ✅ en SQL |
| 24 | Remera Polo Clasica | ✅ en SQL |
| 25 | Pantalon Chino Slim Fit | ✅ en SQL |
| 26 | Campera Impermeable Windbreaker | ✅ en SQL |
| 27 | Set de Sabanas Queen Premium | ✅ en SQL |
| 28 | Organizador de Escritorio Bambu | ✅ en SQL |
| 29 | Espejo Decorativo Marco Dorado | ✅ en SQL |
| 30 | Set de Pinceles de Maquillaje | ✅ en SQL |
| 31 | Serum Vitamina C 30ml | ✅ en SQL |
| 32 | Protector Solar FPS 50 100ml | ✅ en SQL |
| 33 | Set LEGO Creator 500 piezas | ✅ en SQL |
| 34 | Muneca Interactiva con Accesorios | ✅ en SQL |
| 35 | Bicicleta Infantil Rodado 16 | ✅ en SQL |
| 36 | Pelota de Futbol Profesional | ✅ en SQL |
| 37 | Bicicleta de Montana 26" | ✅ en SQL |
| 38 | Soga para Saltar Profesional | ✅ en SQL |
| 39 | Monitor Curvo 27" Full HD | ✅ en SQL |
| 40 | Auriculares Gaming con Microfono | ✅ en SQL |
| 41 | Webcam Full HD 1080p | ✅ en SQL |
| 42 | Freidora de Aire 5.5L Digital | ✅ en SQL |
| 43 | Cafetera de Capsulas Express | ✅ en SQL |
| 44 | Aspiradora Robot con Mapeado | ✅ en SQL |
| 45 | Camara de Reversa Inalambrica | ✅ en SQL |
| 46 | Compresor de Aire Portatil 12V | ✅ en SQL |
| 47 | Alfombras Universales para Auto | ✅ en SQL |
| 48 | Cama Ortopedica para Perro L | ✅ en SQL |
| 49 | Rascador para Gatos Torre | ✅ en SQL |
| 50 | Correa Retractil 5 Metros | ✅ en SQL |

**53/53 productos con imagen real ✅**

### Cómo agregar una imagen nueva

1. Subir el archivo a Supabase en el bucket `product_bazaar`, carpeta `oficial/`
2. Editar `sql/02_catalog.sql`: reemplazar la URL del producto en el INSERT de `products` y en el INSERT de `product_images`
3. Ejecutar el seed (es idempotente — el `ON CONFLICT DO UPDATE` actualizará la imagen)

---

## Variables de entorno

Crear un archivo `.env` en esta carpeta (ver `.env.example`):

```env
# UserService
US_HOST=localhost
US_PORT=5432
US_USER=granbazaar
US_PASS=granbazaar
US_DB=granbazaar

# CatalogService
CS_HOST=localhost
CS_PORT=5433
CS_USER=postgres
CS_PASS=postgres
CS_DB=granbazaar_catalog

# CheckoutOrdersService
CO_HOST=localhost
CO_PORT=5434
CO_USER=postgres
CO_PASS=postgres
CO_DB=granbazaar_checkout_order

# WishListService
WL_HOST=localhost
WL_PORT=5435
WL_USER=postgres
WL_PASS=postgres
WL_DB=granbazaar_wishlist
```

---

## Comportamiento ante múltiples ejecuciones

Todos los seeds usan `ON CONFLICT DO NOTHING` o `ON CONFLICT DO UPDATE` según el caso:
- **Usuarios / vendedores**: se actualizan si cambian nombre, email o descripción.
- **Productos / categorías**: no se modifican si ya existen (preserva cambios manuales).
- **Órdenes / carritos / wishlists**: se ignoran duplicados.
- **Reseñas**: se ignoran duplicados (clave única por producto/vendedor + orden).
