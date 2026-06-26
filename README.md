# GranBazaar — Documentación Central

Documentación centralizada del ecosistema GranBazaar: un e-commerce multirole (comprador / vendedor / admin) implementado como microservicios.

---

## Tabla de contenidos

- [Arquitectura general](#arquitectura-general)
- [Repositorios principales](#repositorios-principales)
- [Repositorios de soporte](#repositorios-de-soporte)
- [Autenticación](#autenticación)
- [Flujo crítico de checkout](#flujo-crítico-de-checkout)
- [Seeds de desarrollo](#seeds-de-desarrollo)
- [Git Workflow](#git-workflow)
- [Despliegue e infraestructura](#despliegue-e-infraestructura)
- [Pruebas de carga y estrés](#pruebas-de-carga-y-estrés)

---

## Arquitectura general

```
Cliente (app móvil / backoffice web)
        │
        ▼
  Kong 3.6 — API Gateway (puerto 8000)
  (valida JWT Auth0, inyecta X-User-Id, Prometheus)
        │
  ┌─────┴──────────────────────────────────┐
  │ Microservicios backend                 │
  ├────────────────────────────────────────┤
  │ user-service          :8001  Python    │
  │ catalog-service       :8002  Go        │
  │ checkout-order-service:8003  Go        │
  │ wishlist-service      :8004  Go        │
  │ metrics-service       :8005  Python    │
  │ notifications-service :8006  Python    │
  └────────────────────────────────────────┘
```

Cada servicio corre en su propio contenedor Docker y expone su BD en un puerto dedicado.

---

## Repositorios principales

### Backend

| Servicio | Repositorio | Puerto app | Puerto BD | Stack | Descripción |
|---|---|---|---|---|---|
| API Gateway | `gateway-api` | 8000 (proxy), 9001 (admin) | — | Kong 3.6 DB-less | Punto de entrada único: valida JWT Auth0, inyecta `X-User-Id`, expone métricas Prometheus |
| User Service | `user-service` | 8001 | 5432 (PostgreSQL) | Python 3.12 / FastAPI / asyncpg | Perfiles de usuario, bloqueo de cuentas. **No valida JWT** — confía en `X-User-Id` del gateway |
| Catalog Service | `catalog-service` | 8002 | 5433 (PostgreSQL) | Go 1.24 / Gin | Productos, imágenes, stock, reservas, carrito, reseñas, categorías |
| Checkout & Orders | `checkout-order-service` | 8003 | 5434 (PostgreSQL) | Go 1.24 / Gin | Checkout, órdenes, cupones de descuento, ciclo de vida de compras (incluyendo integración con Stripe) |
| Wishlist Service | `wishlist-service` | 8004 | 5435 (PostgreSQL) | Go 1.24 / Gin | Favoritos; enriquece ítems con datos de CatalogService en tiempo real |
| Metrics Service | `metrics-service` | 8005 | 27017 (MongoDB) | Python 3.12 / FastAPI | Event Sourcing: recibe eventos de dominio y expone agregaciones analíticas para dashboards |
| Notifications Service | `notifications-service` | 8006 | 5436 (PostgreSQL) | Python 3.12 / FastAPI | Push notifications (Expo Push API): gestión de tokens de dispositivo, alertas de estado de orden y stock bajo |

### Frontends

| Aplicación | Repositorio | Stack | Descripción |
|---|---|---|---|
| App móvil | `app` | React Native 0.79.5 / Expo Router / TypeScript | App principal para compradores y vendedores (iOS + Android) |
| Backoffice | `back-office` | React 19 / Vite 6 / TypeScript | Panel de administración: productos, pedidos, clientes, reportes |

---

## Repositorios de soporte

| Tipo | Repositorio | Descripción |
|---|---|---|
| Templates | `golang-api-template` | Template base para nuevos microservicios Go |
| Templates | `python-template-api` | Template base para nuevos microservicios Python/FastAPI |
| UX | `ux-template` | Componentes de UI y sistema de diseño (Material Design 3 con branding GranBazaar) |
| Testing | `load-and-stress-tests` | Escenarios k6 de carga y estrés (5 escenarios: catálogo, checkout, carrito, journey E2E) |
| IA / Automatización | `agents-skills` | Skills y automatización con Claude Code |
| Documentación | `docs-repo` | Este repositorio: documentación central, seeds y auditorías UX/accesibilidad |

---

## Autenticación

**Proveedor:** Auth0 (RS256, dominio `dev-u5665eq7eepxykye.us.auth0.com`).

**Flujo:**
1. El cliente obtiene un JWT de Auth0.
2. Lo envía en el header `Authorization: Bearer <token>`.
3. Kong valida la firma del token (clave pública RSA) y extrae el claim `sub`.
4. Kong inyecta `X-User-Id: <sub>` en el request antes de hacer proxy al microservicio.
5. Los microservicios confían en `X-User-Id` sin re-validar el JWT.

**Endpoints públicos (sin autenticación):**
- `GET /products` y `GET /home` — listado de productos
- `GET /products/:id/reviews` — reseñas de un producto
- Health probes (`/livez`, `/readyz`)
- App Links de Android/iOS (`/.well-known/assetlinks.json`, `apple-app-site-association`)

**Testing local sin Auth0:** pasar `X-User-Id: <auth0_sub>` directamente al puerto del servicio (ej. `:8001`) sin pasar por Kong.

---

## Flujo crítico de checkout

```
1. GET  /products/:id          → catalog-service   (público, sin auth)
2. POST /carts/items           → catalog-service   (requiere X-User-Id)
3. POST /checkout              → checkout-service  (requiere X-User-Id)
                                 ├─ valida carrito
                                 ├─ reserva stock en catalog-service
                                 └─ crea orden (estado: pending_payment)
4. GET  /orders/:id            → checkout-service  (requiere X-User-Id)
```

**Estados de orden:** `pending_payment` → `confirmed` → `in_preparation` → `shipped` → `delivered` / `cancelled`

Existe también `POST /checkout/v2` (integración con Stripe para pagos reales).

---

## Seeds de desarrollo

Ver [`seeds/README.md`](seeds/README.md) para instrucciones completas.

Script maestro (idempotente):
```bash
cd seeds
cp .env.example .env   # ajustar si los puertos o credenciales difieren
bash seed-all.sh
```

**Datos generados:** 13 usuarios (admin, compradores, vendedores), 53 productos con imágenes en Supabase, órdenes en todos los estados, 5 cupones de descuento, wishlists, reseñas, métricas.

---

## Git Workflow

### Ramas principales

| Rama | Propósito |
|---|---|
| `main` | Producción — estable, verificado, apto para demos |
| `staging` | Staging — prueba de funcionalidades en un ambiente productivo, apto para demos |
| `dev` | Integración — funcionalidades completas, debe pasar CI antes de merge |

### Ramas de feature

- Se crean desde `dev`
- Se integran a `dev` vía Pull Request
- Requisitos antes de merge: funciona localmente + tests pasan en GitHub Actions + PR revisado + sin breaking changes
- Se integran a `staging` vía Pull Request, para probar las features en un ambiente productivo

---

## Despliegue e infraestructura

Todos los servicios tienen soporte para tres entornos via Docker Compose:

| Entorno | Archivo | Uso |
|---|---|---|
| Local / desarrollo | `docker-compose.yml` | Desarrollo y testing local |
| CI | `docker-compose.ci.yml` | GitHub Actions |
| Staging | `docker-compose.staging.yml` | Entorno de pre-producción |

**Imágenes de productos:** almacenadas en Supabase, bucket `product_bazaar/oficial/`.

---

## Pruebas de carga y estrés

Ver [`load-and-stress-tests/`](../load-and-stress-tests/) para instrucciones completas.

Herramienta: [k6](https://k6.io/). Referencia rápida:

```bash
cd load-and-stress-tests
make install   # instala k6
make seed      # carga datos de prueba

make 01        # load test — catálogo (GET /products)
make 02        # load test — checkout (POST /checkout)
make 03        # stress test — checkout
make 04        # load test — carrito (POST /carts/items)
make 05        # load test — journey E2E completo (8 pasos)
```

Los escenarios apuntan directamente a los puertos de cada servicio (sin pasar por Kong) para evitar la validación JWT en las pruebas.

---

## Documentación de UX y accesibilidad

| Documento | Descripción |
|---|---|
| [`ui/ux-design-audit.md`](ui/ux-design-audit.md) | Auditoría de sistema de diseño: paleta, contraste WCAG AA, tipografía, tokens, patrones UX por pantalla |
| [`ui/accessibility-audit.md`](ui/accessibility-audit.md) | Auditoría de accesibilidad: tabla de componentes revisados, patrones de referencia, reglas para code review, checklist QA VoiceOver/TalkBack |
