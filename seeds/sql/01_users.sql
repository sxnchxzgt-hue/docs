-- ============================================================
-- Seed: UserService
-- Base de datos: granbazaar (puerto 5432 por defecto)
-- Idempotente: ON CONFLICT DO UPDATE / DO NOTHING
-- Depende de: ninguno
-- ============================================================

-- ─── Vendedores ──────────────────────────────────────────────────────────────
-- (referenciados por los productos del CatalogService)

INSERT INTO users (auth0_id, full_name, email, description, rating)
VALUES
    ('550e8400-e29b-41d4-a716-446655440001',
     'TecnoShop BA', 'tecno.shop.ba@example.com',
     'Especialistas en electrónica, celulares y accesorios tech. Envíos a todo el país.', 4.8),
    ('550e8400-e29b-41d4-a716-446655440002',
     'Moda Porteña', 'moda.portena@example.com',
     'Ropa y calzado con estilo urbano. Talles del S al XXL, renovamos stock cada semana.', 4.6),
    ('550e8400-e29b-41d4-a716-446655440003',
     'Casa & Deco', 'casa.deco@example.com',
     'Todo para el hogar: iluminación, textiles y decoración de interiores.', 4.2),
    ('550e8400-e29b-41d4-a716-446655440004',
     'Bella Natura', 'bella.natura@example.com',
     'Cosméticos y productos de cuidado personal con ingredientes naturales.', 4.9),
    ('550e8400-e29b-41d4-a716-446655440005',
     'El Mundo del Niño', 'mundo.nino@example.com',
     'Juguetes educativos y artículos para bebés y niños de todas las edades.', 4.6),
    ('550e8400-e29b-41d4-a716-446655440006',
     'SportZone Pro', 'sportzone.pro@example.com',
     'Equipamiento deportivo y fitness para todos los niveles. Asesoramiento personalizado.', 4.7),
    ('550e8400-e29b-41d4-a716-446655440007',
     'Bazar del Centro', 'bazar.centro@example.com',
     'Vendedor general con productos variados. Ideal para pruebas de endpoints.', 4.4),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee',
     'Tienda Nueva', 'tienda.nueva@example.com',
     'Tienda recién abierta, sin productos cargados todavía.', 4.3),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'Outlet Express', 'outlet.express@example.com',
     'Cuenta suspendida por incumplimiento de políticas de la plataforma.', 3.0)
ON CONFLICT (auth0_id) DO UPDATE
SET full_name   = EXCLUDED.full_name,
    email       = EXCLUDED.email,
    description = EXCLUDED.description,
    rating      = EXCLUDED.rating;

UPDATE users SET status = 'BLOCKED'
WHERE auth0_id = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb';

-- ─── Administradores ─────────────────────────────────────────────────────────

INSERT INTO users (auth0_id, full_name, email, description, rating, is_admin)
VALUES
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
     'Admin Principal', 'admin@granbazaar.dev',
     'Cuenta de administrador del sistema.', 0.0, true)
ON CONFLICT (auth0_id) DO UPDATE
SET full_name = EXCLUDED.full_name,
    email     = EXCLUDED.email,
    is_admin  = EXCLUDED.is_admin;

-- ─── Compradores ─────────────────────────────────────────────────────────────

INSERT INTO users (auth0_id, full_name, email, description, rating)
VALUES
    ('cccccccc-cccc-cccc-cccc-cccccccccc01',
     'Laura Méndez', 'laura.mendez@example.com',
     'Compradora frecuente de tecnología y hogar.', 0.0),
    ('cccccccc-cccc-cccc-cccc-cccccccccc02',
     'Carlos Herrera', 'carlos.herrera@example.com',
     'Aficionado al deporte y la moda.', 0.0),
    ('cccccccc-cccc-cccc-cccc-cccccccccc03',
     'María García', 'maria.garcia@example.com',
     'Compradora de productos para mascotas y niños.', 0.0)
ON CONFLICT (auth0_id) DO UPDATE
SET full_name   = EXCLUDED.full_name,
    email       = EXCLUDED.email,
    description = EXCLUDED.description;

-- ─── Preferencias de usuario ──────────────────────────────────────────────────

UPDATE users SET preferences = '{"language": "es", "theme": "dark"}'
WHERE auth0_id = 'cccccccc-cccc-cccc-cccc-cccccccccc01';

UPDATE users SET preferences = '{"language": "es", "theme": "light"}'
WHERE auth0_id = 'cccccccc-cccc-cccc-cccc-cccccccccc02';

UPDATE users SET preferences = '{"language": "en", "theme": "light"}'
WHERE auth0_id = 'cccccccc-cccc-cccc-cccc-cccccccccc03';

-- ─── Reseñas de vendedores ────────────────────────────────────────────────────

INSERT INTO seller_reviews (seller_id, order_id, buyer_id, score, comment, created_at)
VALUES
    ('550e8400-e29b-41d4-a716-446655440001',
     '11111111-1111-1111-1111-111111111101',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Excelente vendedor, producto llegó antes de lo esperado.',
     '2026-05-15 10:00:00'),
    ('550e8400-e29b-41d4-a716-446655440002',
     '11111111-1111-1111-1111-111111111102',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'Muy buena atención, la ropa vino bien empacada.',
     '2026-05-20 14:30:00'),
    ('550e8400-e29b-41d4-a716-446655440003',
     '11111111-1111-1111-1111-111111111103',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     3, 'Producto correcto pero tardó más de lo esperado.',
     '2026-06-01 09:15:00'),
    ('550e8400-e29b-41d4-a716-446655440006',
     '11111111-1111-1111-1111-111111111106',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Las mancuernas son de muy buena calidad, volvería a comprar.',
     '2026-06-05 16:00:00'),

    -- Carlos reseña beauty.seller (orden 107)
    ('550e8400-e29b-41d4-a716-446655440004',
     '11111111-1111-1111-1111-111111111107',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Productos de belleza de primera calidad, embalaje cuidado y envío rápido.',
     '2026-05-31 09:30:00'),

    -- María reseña kids.world.seller (orden 108)
    ('550e8400-e29b-41d4-a716-446655440005',
     '11111111-1111-1111-1111-111111111108',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'El juguete llegó perfectamente embalado y antes de lo esperado. Muy recomendable.',
     '2026-06-08 10:30:00'),

    -- María reseña home.living.seller (orden 103, segunda reseña)
    ('550e8400-e29b-41d4-a716-446655440003',
     '11111111-1111-1111-1111-111111111108',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     4, 'Buen vendedor, aunque la entrega demoró un par de días más de lo prometido.',
     '2026-06-08 11:00:00')
ON CONFLICT (seller_id, order_id) DO NOTHING;

-- ─── Actualizar rating y reviews_count de vendedores ─────────────────────────

UPDATE users SET reviews_count = 2, rating = 5.0
WHERE auth0_id = '550e8400-e29b-41d4-a716-446655440001';

UPDATE users SET reviews_count = 1, rating = 4.0
WHERE auth0_id = '550e8400-e29b-41d4-a716-446655440002';

UPDATE users SET reviews_count = 2, rating = 3.5
WHERE auth0_id = '550e8400-e29b-41d4-a716-446655440003';

UPDATE users SET reviews_count = 1, rating = 5.0
WHERE auth0_id = '550e8400-e29b-41d4-a716-446655440006';

UPDATE users SET reviews_count = 1, rating = 5.0
WHERE auth0_id = '550e8400-e29b-41d4-a716-446655440004';

UPDATE users SET reviews_count = 1, rating = 5.0
WHERE auth0_id = '550e8400-e29b-41d4-a716-446655440005';
