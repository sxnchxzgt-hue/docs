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
| Vendedor | `550e8400-...-446655440001` | tech.seller@example.com |
| Vendedor | `550e8400-...-446655440002` | fashion.seller@example.com |
| Vendedor | `550e8400-...-446655440003` | home.living.seller@example.com |
| Vendedor | `550e8400-...-446655440004` | beauty.seller@example.com |
| Vendedor | `550e8400-...-446655440005` | kids.world.seller@example.com |
| Vendedor | `550e8400-...-446655440006` | sports.gear@example.com |
| Vendedor | `550e8400-...-446655440007` | marketplace.seller@example.com |
| Vendedor vacío | `eeeeeeee-...-eeeeeeeeeeee` | empty.seller@example.com |
| Vendedor bloqueado | `bbbbbbbb-...-bbbbbbbbbbbb` | blocked.seller@example.com |

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

## Imágenes necesarias en Supabase

> **Las fotos de perfil de usuarios NO se seedean por SQL** — el campo `photo` en UserService
> es `BYTEA` (binario) y se sube a través de la API. Solo se necesitan imágenes de **productos**.

### Bucket recomendado: `product_bazaar`

Subir una imagen por producto al bucket de Supabase y reemplazar las URLs en
`sql/02_catalog.sql` antes de ejecutar el seed. Las URLs tienen el formato:
```
https://<project>.supabase.co/storage/v1/object/public/product_bazaar/<nombre>.png
```

### Lista de imágenes de productos a subir

| Nombre de archivo sugerido | Producto | ID |
|---------------------------|----------|----|
| `samsung-galaxy-a54.png` | Samsung Galaxy A54 | 1 |
| `auriculares-sony-wh720.png` | Auriculares Sony WH-CH720 | 2 |
| `camiseta-basica.png` | Camiseta Básica Premium | 3 |
| `zapatillas-running.png` | Zapatillas Running Pro | 4 |
| `lampara-led-piso.png` | Lámpara LED de Piso | 5 |
| `almohada-memory-foam.png` | Almohada Premium Memory Foam | 6 |
| `crema-facial.png` | Crema Facial Hidratante | 7 |
| `perfume-essence.png` | Perfume Essence | 8 |
| `juego-construccion.png` | Juego de Construcción 1000 piezas | 9 |
| `andador-bebe.png` | Andador para Bebé | 10 |
| `mancuernas-ajustables.png` | Mancuernas Ajustables 20kg | 11 |
| `colchoneta-yoga.png` | Colchoneta Yoga Premium | 12 |
| `teclado-mecanico-rgb.png` | Teclado Mecánico RGB | 13 |
| `mouse-inalambrico.png` | Mouse Inalámbrico Pro | 14 |
| `licuadora-digital.png` | Licuadora Digital 2000W | 15 |
| `microondas-inteligente.png` | Microondas Inteligente | 16 |
| `kit-herramientas.png` | Kit de Herramientas 20 piezas | 17 |
| `pedal-deportivo.png` | Pedal de Acelerador Deportivo | 18 |
| `comida-perros.png` | Comida Premium para Perros | 19 |
| `juguete-perro.png` | Juguete Interactivo para Perro | 20 |
| `headphones-pro.png` | Marketplace Headphones Pro | 61 |
| `smart-watch.png` | Marketplace Smart Watch | 62 |
| `archived-item.png` | Marketplace Archived Item | 63 |

**Total: 23 imágenes**

### Cómo actualizar las URLs en el SQL

Una vez tengas los links de Supabase, reemplazá el placeholder en `sql/02_catalog.sql`.
Si todas las URLs siguen el patrón `product_bazaar/<nombre>.png`, podés hacer un reemplazo
masivo con el editor o con:

```bash
# Ejemplo: reemplazar solo el placeholder genérico dejando las URLs reales intactas
sed -i "s|product_bazaar/zapatillas.png|product_bazaar/samsung-galaxy-a54.png|g" sql/02_catalog.sql
# (repetir por cada producto o editar el archivo directamente)
```

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
