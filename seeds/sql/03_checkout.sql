-- ============================================================
-- Seed: CheckoutOrdersService
-- Base de datos: granbazaar_checkout_order (puerto 5434 por defecto)
-- Idempotente: ON CONFLICT DO NOTHING
-- Depende de: 01_users.sql y 02_catalog.sql (buyers y productos deben existir)
-- ============================================================

-- ─── Cupones ────────────────────────────────────────────────────────────────

INSERT INTO coupons (code, seller_id, discount, expires_at, active, max_uses, use_count)
VALUES
    ('TECH10',
     '550e8400-e29b-41d4-a716-446655440001',
     10, '2027-12-31 23:59:59', true, 100, 3),
    ('MODA20',
     '550e8400-e29b-41d4-a716-446655440002',
     20, '2027-06-30 23:59:59', true, 50, 1),
    ('HOGAR15',
     '550e8400-e29b-41d4-a716-446655440003',
     15, '2027-09-30 23:59:59', true, NULL, 0),
    ('EXPIRED5',
     '550e8400-e29b-41d4-a716-446655440001',
     5, '2025-01-01 00:00:00', false, 10, 0),
    ('DEPORTE25',
     '550e8400-e29b-41d4-a716-446655440006',
     25, '2027-12-31 23:59:59', true, 30, 0)
ON CONFLICT (code) DO NOTHING;

-- ─── Órdenes ────────────────────────────────────────────────────────────────
-- Cubre los estados: delivered, shipped, confirmed, cancelled, pending_payment

INSERT INTO orders (id, buyer_id, status, total, delivery_address, idempotency_key, discount_percentage, created_at, updated_at)
VALUES
    -- Laura: orden entregada con cupón
    ('11111111-1111-1111-1111-111111111101',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     'delivered', 269.99,
     'Av. Corrientes 1234, Buenos Aires, Argentina',
     'idem-001', 10,
     '2026-05-10 10:00:00', '2026-05-14 18:00:00'),

    -- Carlos: orden en camino
    ('11111111-1111-1111-1111-111111111102',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     'shipped', 89.99,
     'Calle Florida 456, Córdoba, Argentina',
     'idem-002', 0,
     '2026-05-18 09:30:00', '2026-05-19 12:00:00'),

    -- María: orden confirmada
    ('11111111-1111-1111-1111-111111111103',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     'confirmed', 104.98,
     'San Martín 789, Rosario, Argentina',
     'idem-003', 0,
     '2026-05-28 14:00:00', '2026-05-28 14:30:00'),

    -- Carlos: orden cancelada
    ('11111111-1111-1111-1111-111111111104',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     'cancelled', 189.99,
     'Calle Florida 456, Córdoba, Argentina',
     'idem-004', 0,
     '2026-04-15 11:00:00', '2026-04-16 09:00:00'),

    -- María: pago pendiente
    ('11111111-1111-1111-1111-111111111105',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     'pending_payment', 69.99,
     'San Martín 789, Rosario, Argentina',
     'idem-005', 0,
     '2026-06-14 17:00:00', '2026-06-14 17:00:00'),

    -- Laura: segunda orden entregada (sin cupón)
    ('11111111-1111-1111-1111-111111111106',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     'delivered', 69.99,
     'Av. Corrientes 1234, Buenos Aires, Argentina',
     'idem-006', 0,
     '2026-06-01 08:00:00', '2026-06-04 20:00:00'),

    -- Carlos: orden belleza entregada
    ('11111111-1111-1111-1111-111111111107',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     'delivered', 84.98,
     'Calle Florida 456, Córdoba, Argentina',
     'idem-007', 0,
     '2026-05-25 10:00:00', '2026-05-30 18:00:00'),

    -- María: orden juguetes entregada
    ('11111111-1111-1111-1111-111111111108',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     'delivered', 39.99,
     'San Martín 789, Rosario, Argentina',
     'idem-008', 0,
     '2026-06-03 14:00:00', '2026-06-07 17:00:00')
ON CONFLICT (id) DO NOTHING;

-- Asociar cupón a la orden de Laura
UPDATE orders SET coupon_code = 'TECH10'
WHERE id = '11111111-1111-1111-1111-111111111101';

-- ─── Ítems de órdenes ───────────────────────────────────────────────────────

INSERT INTO order_items (order_id, product_id, product_name, quantity, unit_price, total_price, seller_id)
VALUES
    -- Orden 101: Samsung Galaxy A54 (tech store)
    ('11111111-1111-1111-1111-111111111101',
     1, 'Samsung Galaxy A54', 1, 299.99, 269.99,
     '550e8400-e29b-41d4-a716-446655440001'),

    -- Orden 102: Zapatillas Running Pro (fashion boutique)
    ('11111111-1111-1111-1111-111111111102',
     4, 'Zapatillas Running Pro', 1, 89.99, 89.99,
     '550e8400-e29b-41d4-a716-446655440002'),

    -- Orden 103: Lámpara LED + Almohada Memory Foam (home & living)
    ('11111111-1111-1111-1111-111111111103',
     5, 'Lámpara LED de Piso', 1, 45.99, 45.99,
     '550e8400-e29b-41d4-a716-446655440003'),
    ('11111111-1111-1111-1111-111111111103',
     6, 'Almohada Premium Memory Foam', 1, 59.99, 59.99,
     '550e8400-e29b-41d4-a716-446655440003'),

    -- Orden 104: Microondas Inteligente (cancelada)
    ('11111111-1111-1111-1111-111111111104',
     16, 'Microondas Inteligente', 1, 189.99, 189.99,
     '550e8400-e29b-41d4-a716-446655440003'),

    -- Orden 105: Mancuernas Ajustables (pago pendiente)
    ('11111111-1111-1111-1111-111111111105',
     11, 'Mancuernas Ajustables 20kg', 1, 69.99, 69.99,
     '550e8400-e29b-41d4-a716-446655440006'),

    -- Orden 106: Mancuernas Ajustables (entregada - Laura)
    ('11111111-1111-1111-1111-111111111106',
     11, 'Mancuernas Ajustables 20kg', 1, 69.99, 69.99,
     '550e8400-e29b-41d4-a716-446655440006'),

    -- Orden 107: Crema Facial + Perfume Essence (entregada - Carlos)
    ('11111111-1111-1111-1111-111111111107',
     7, 'Crema Facial Hidratante', 1, 34.99, 34.99,
     '550e8400-e29b-41d4-a716-446655440004'),
    ('11111111-1111-1111-1111-111111111107',
     8, 'Perfume Essence', 1, 49.99, 49.99,
     '550e8400-e29b-41d4-a716-446655440004'),

    -- Orden 108: Juego de Construcción (entregada - María)
    ('11111111-1111-1111-1111-111111111108',
     9, 'Juego de Construcción 1000 piezas', 1, 39.99, 39.99,
     '550e8400-e29b-41d4-a716-446655440005')
ON CONFLICT DO NOTHING;

-- ─── Historial de estados ────────────────────────────────────────────────────

INSERT INTO order_status_history (order_id, status, tracking_code, changed_at)
VALUES
    -- Orden 101: pending → confirmed → shipped → delivered
    ('11111111-1111-1111-1111-111111111101', 'pending_payment',  NULL,         '2026-05-10 10:00:00'),
    ('11111111-1111-1111-1111-111111111101', 'confirmed',        NULL,         '2026-05-10 11:00:00'),
    ('11111111-1111-1111-1111-111111111101', 'shipped',          'AR123456789', '2026-05-11 09:00:00'),
    ('11111111-1111-1111-1111-111111111101', 'delivered',        NULL,         '2026-05-14 18:00:00'),

    -- Orden 102: pending → confirmed → shipped
    ('11111111-1111-1111-1111-111111111102', 'pending_payment',  NULL,         '2026-05-18 09:30:00'),
    ('11111111-1111-1111-1111-111111111102', 'confirmed',        NULL,         '2026-05-18 10:30:00'),
    ('11111111-1111-1111-1111-111111111102', 'shipped',          'AR987654321', '2026-05-19 12:00:00'),

    -- Orden 103: pending → confirmed
    ('11111111-1111-1111-1111-111111111103', 'pending_payment',  NULL,         '2026-05-28 14:00:00'),
    ('11111111-1111-1111-1111-111111111103', 'confirmed',        NULL,         '2026-05-28 14:30:00'),

    -- Orden 104: pending → cancelled
    ('11111111-1111-1111-1111-111111111104', 'pending_payment',  NULL,         '2026-04-15 11:00:00'),
    ('11111111-1111-1111-1111-111111111104', 'cancelled',        NULL,         '2026-04-16 09:00:00'),

    -- Orden 105: pending_payment (sin cambios)
    ('11111111-1111-1111-1111-111111111105', 'pending_payment',  NULL,         '2026-06-14 17:00:00'),

    -- Orden 106: pending → confirmed → shipped → delivered
    ('11111111-1111-1111-1111-111111111106', 'pending_payment',  NULL,         '2026-06-01 08:00:00'),
    ('11111111-1111-1111-1111-111111111106', 'confirmed',        NULL,         '2026-06-01 09:00:00'),
    ('11111111-1111-1111-1111-111111111106', 'shipped',          'AR111222333', '2026-06-02 10:00:00'),
    ('11111111-1111-1111-1111-111111111106', 'delivered',        NULL,         '2026-06-04 20:00:00'),

    -- Orden 107: pending → confirmed → shipped → delivered
    ('11111111-1111-1111-1111-111111111107', 'pending_payment',  NULL,         '2026-05-25 10:00:00'),
    ('11111111-1111-1111-1111-111111111107', 'confirmed',        NULL,         '2026-05-25 11:00:00'),
    ('11111111-1111-1111-1111-111111111107', 'shipped',          'AR444555666', '2026-05-26 09:00:00'),
    ('11111111-1111-1111-1111-111111111107', 'delivered',        NULL,         '2026-05-30 18:00:00'),

    -- Orden 108: pending → confirmed → shipped → delivered
    ('11111111-1111-1111-1111-111111111108', 'pending_payment',  NULL,         '2026-06-03 14:00:00'),
    ('11111111-1111-1111-1111-111111111108', 'confirmed',        NULL,         '2026-06-03 14:30:00'),
    ('11111111-1111-1111-1111-111111111108', 'shipped',          'AR777888999', '2026-06-04 10:00:00'),
    ('11111111-1111-1111-1111-111111111108', 'delivered',        NULL,         '2026-06-07 17:00:00')
ON CONFLICT DO NOTHING;
