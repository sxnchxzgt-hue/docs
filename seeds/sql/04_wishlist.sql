-- ============================================================
-- Seed: WishListService
-- Base de datos: granbazaar_wishlist (puerto 5435 por defecto)
-- Idempotente: ON CONFLICT DO NOTHING
-- Depende de: 01_users.sql (compradores) y 02_catalog.sql (productos)
-- ============================================================
-- Idempotent: unique constraint on (user_id, product_id) via ON CONFLICT DO NOTHING.

INSERT INTO wishlists (user_id, product_id, created_at)
VALUES
    -- Laura: tecnología y hogar
    ('cccccccc-cccc-cccc-cccc-cccccccccc01', 1,  '2026-05-01 10:00:00'),  -- Samsung Galaxy A54
    ('cccccccc-cccc-cccc-cccc-cccccccccc01', 2,  '2026-05-02 11:00:00'),  -- Auriculares Sony
    ('cccccccc-cccc-cccc-cccc-cccccccccc01', 13, '2026-05-03 12:00:00'),  -- Teclado Mecánico RGB
    ('cccccccc-cccc-cccc-cccc-cccccccccc01', 6,  '2026-05-04 09:00:00'),  -- Almohada Memory Foam

    -- Carlos: deporte y moda
    ('cccccccc-cccc-cccc-cccc-cccccccccc02', 11, '2026-05-10 08:00:00'),  -- Mancuernas
    ('cccccccc-cccc-cccc-cccc-cccccccccc02', 12, '2026-05-11 09:00:00'),  -- Colchoneta Yoga
    ('cccccccc-cccc-cccc-cccc-cccccccccc02', 4,  '2026-05-12 14:00:00'),  -- Zapatillas Running

    -- María: mascotas y niños
    ('cccccccc-cccc-cccc-cccc-cccccccccc03', 9,  '2026-06-01 10:00:00'),  -- Juego Construcción
    ('cccccccc-cccc-cccc-cccc-cccccccccc03', 10, '2026-06-02 11:00:00'),  -- Andador Bebé
    ('cccccccc-cccc-cccc-cccc-cccccccccc03', 20, '2026-06-03 12:00:00')   -- Juguete Perro
ON CONFLICT (user_id, product_id) DO NOTHING;
