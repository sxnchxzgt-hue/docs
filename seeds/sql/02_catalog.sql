-- ============================================================
-- Seed: CatalogService (CartService)
-- Base de datos: granbazaar_catalog (puerto 5433 por defecto)
-- Idempotente: ON CONFLICT DO NOTHING / DO UPDATE
-- Depende de: 01_users.sql (los seller_id deben existir en UserService)
-- IMPORTANTE: reemplazar las URLs placeholder con las URLs reales de Supabase
--             una vez subidas las imágenes (ver README.md → sección Imágenes)
-- ============================================================

-- Keep category sequence ahead of seeded IDs.
-- SELECT setval('categories_id_seq', 20, true);

-- Insert categories with explicit IDs starting at 1
INSERT INTO categories (id, name, description, created_at) VALUES
(1, '📱 Electrónica y Tecnología', 'Celulares, laptops, auriculares, accesorios', '2026-01-01 08:00:00'),
(2, '👕 Ropa y Moda', 'Hombre, mujer, niños, zapatos, accesorios', '2026-01-02 08:00:00'),
(3, '🏠 Hogar y Decoración', 'Muebles, decoración, cocina, iluminación', '2026-01-03 08:00:00'),
(4, '🧴 Belleza y Cuidado Personal', 'Maquillaje, skincare, perfumes', '2026-01-04 08:00:00'),
(5, '🧸 Juguetes y Niños', 'Juguetes, bebés, educativos', '2026-01-05 08:00:00'),
(6, '🏋️ Deportes y Fitness', 'Gimnasio, camping, ciclismo', '2026-01-06 08:00:00'),
(7, '🖥️ Computación y Accesorios', 'Teclados, mouse, monitores', '2026-01-07 08:00:00'),
(8, '🍳 Electrodomésticos', 'Heladeras, microondas, licuadoras', '2026-01-08 08:00:00'),
(9, '🚗 Automotor y Herramientas', 'Accesorios de autos, herramientas', '2026-01-09 08:00:00'),
(10, '🐶 Mascotas', 'Comida, juguetes, accesorios', '2026-01-10 08:00:00')
ON CONFLICT (id) DO NOTHING;

-- Insert products
-- Insert products with explicit created_at and reviews_count to simulate history
INSERT INTO products (id, name, description, price, stock, main_image, rating, category_id, status, seller_id, created_at, reviews_count) VALUES
(1, 'Samsung Galaxy A54', 'Smartphone con pantalla AMOLED de 6.4 pulgadas, 128GB almacenamiento, cámara de 50MP', 299.99, 45, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Samsung%20Galaxy%20A54.png', 4.5, 1, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440001', '2026-04-30 10:00:00', 120),
(2, 'Auriculares Sony WH-CH720', 'Auriculares inalámbricos con cancelación de ruido, batería 35 horas, conector 3.5mm', 79.99, 120, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Auriculares%20Sony%20WH-CH720.jpg', 4.3, 1, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440001', '2026-04-29 11:00:00', 80),
(3, 'Camiseta Básica Premium', 'Producto deshabilitado por el vendedor', 24.99, 0, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Camiseta%20Basica%20Premium.webp', 4.6, 2, 'DISABLED_BY_OWNER', '550e8400-e29b-41d4-a716-446655440002', '2026-04-10 09:00:00', 5),
(4, 'Zapatillas Running Pro', 'Zapatillas deportivas con tecnología de amortiguación, para hombre y mujer', 89.99, 80, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Zapatillas%20Running%20Pro.webp', 4.4, 2, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440002', '2026-04-28 12:00:00', 95),
(5, 'Lámpara LED de Piso', 'Lámpara moderna con control remoto, 3 temperaturas de color, bajo consumo energético', 45.99, 65, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Lampara%20LED%20de%20Piso.jpg', 4.2, 3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440003', '2026-04-20 14:00:00', 30),
(6, 'Almohada Premium Memory Foam', 'Almohada ergonómica con viscoelástica de alta densidad, funda removible', 59.99, 150, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Almohada%20Premium%20Memory%20Foam.jpg', 4.7, 3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440003', '2026-04-25 08:00:00', 200),
(7, 'Crema Facial Hidratante', 'Crema hidratante con vitamina E y ácido hialurónico, para todo tipo de piel', 34.99, 180, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Crema%20Facial%20Hidratante.webp', 4.5, 4, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440004', '2026-04-18 09:30:00', 50),
(8, 'Perfume Essence', 'Eau de Parfum de 100ml, aroma floral y fresco, larga duración', 49.99, 95, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Perfume%20Essence.jpg', 4.1, 4, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440004', '2026-04-15 10:15:00', 12),
(9, 'Juego de Construcción 1000 piezas', 'Set de bloques de construcción educativos para niños +3 años, estimula creatividad', 39.99, 110, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Juego%20de%20ConstrucciOn%201000%20piezas.webp', 4.8, 5, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440005', '2026-04-05 16:00:00', 300),
(10, 'Andador para Bebé', 'Andador interactivo con actividades, música y luces, seguro para bebés +6 meses', 64.99, 55, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Andador%20para%20Bebe.png', 4.3, 5, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440005', '2026-04-22 13:00:00', 40),
(11, 'Mancuernas Ajustables 20kg', 'Par de mancuernas ajustables de 20kg total, con sistema de ajuste rápido', 69.99, 70, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Mancuernas%20Ajustables%2020kg.webp', 4.6, 6, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440006', '2026-03-30 09:00:00', 60),
(12, 'Colchoneta Yoga Premium', 'Colchoneta de yoga antideslizante, 6mm grosor, material eco-friendly', 44.99, 140, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Colchoneta%20Yoga%20Premium.webp', 4.4, 6, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440006', '2026-04-26 07:45:00', 25),
(13, 'Teclado Mecánico RGB', 'Teclado gaming mecánico con iluminación RGB, switches personalizables', 89.99, 85, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Teclado%20Mecanico%20RGB.jpg', 4.7, 7, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440001', '2026-04-12 18:00:00', 150),
(14, 'Mouse Inalámbrico Pro', 'Mouse de precisión con 3 niveles DPI ajustables, batería 12 meses', 34.99, 160, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Mouse%20Inalambrico%20Pro.png', 4.2, 7, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440001', '2026-04-08 08:30:00', 20),
(15, 'Licuadora Digital 2000W', 'Licuadora potente con 8 velocidades, jarra de vidrio y vaso para llevar', 99.99, 48, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Licuadora%20Digital%202000W.jpg', 4.5, 8, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440003', '2026-04-02 11:00:00', 45),
(16, 'Microondas Inteligente', 'Microondas 30L con control wifi, sensores de humedad, 10 niveles potencia', 189.99, 32, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Microondas%20Inteligente.webp', 4.0, 8, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440003', '2026-04-27 15:00:00', 10),
(17, 'Kit de Herramientas 20 piezas', 'Set completo de herramientas para mantenimiento básico del auto en estuche', 54.99, 75, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Kit%20de%20Herramientas%2020%20piezas.webp', 4.4, 9, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440006', '2026-04-06 12:00:00', 22),
(18, 'Pedal de Acelerador Deportivo', 'Pedal deportivo ajustable universal, material aluminio, fácil instalación', 42.99, 50, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Pedal%20de%20Acelerador%20Deportivo.webp', 3.9, 9, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440006', '2026-04-03 09:15:00', 8),
(19, 'Comida Premium para Perros', 'Alimento balanceado 10kg, con proteínas naturales, para razas medianas', 29.99, 0, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Comida%20Premium%20para%20Perros.webp', 4.6, 10, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440003', '2026-04-01 10:00:00', 65),
(20, 'Juguete Interactivo para Perro', 'Juguete goma resistente con dispensador de premios, tamaño mediano', 24.99, 105, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Juguete%20Interactivo%20para%20Perro.webp', 4.3, 10, 'DISABLED_BY_OWNER', '550e8400-e29b-41d4-a716-446655440003', '2026-04-21 17:00:00', 7),
(61, 'Marketplace Headphones Pro', 'Auriculares premium para usar en pruebas del endpoint por usuario', 149.99, 25, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Marketplace%20Headphones%20Pro.jpg', 4.8, 1, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440007', '2026-04-30 13:00:00', 4),
(62, 'Marketplace Smart Watch', 'Reloj inteligente activo para validar listados por seller', 199.99, 18, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Marketplace%20Smart%20Watch.jpg', 4.6, 1, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440007', '2026-04-30 14:00:00', 2),
(63, 'Marketplace Archived Item', 'Producto deshabilitado por el vendedor para validar filtrado de estado', 59.99, 12, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Zapatillas%20Running%20Pro.webp', 4.1, 1, 'DISABLED_BY_OWNER', '550e8400-e29b-41d4-a716-446655440007', '2026-04-30 15:00:00', 1),
(64, 'Marketplace Blocked Item', 'Producto bloqueado por admin para testear transiciones jerárquicas de estado', 39.99, 20, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Zapatillas%20Running%20Pro.webp', 3.8, 1, 'BLOCKED_BY_ADMIN', '550e8400-e29b-41d4-a716-446655440007', '2026-04-30 16:00:00', 0)
ON CONFLICT (id) DO UPDATE SET seller_id = EXCLUDED.seller_id, status = EXCLUDED.status, created_at = EXCLUDED.created_at, reviews_count = EXCLUDED.reviews_count;

-- ─── Productos adicionales (IDs 21–50) ──────────────────────────────────────

INSERT INTO products (id, name, description, price, stock, main_image, rating, category_id, status, seller_id, created_at, reviews_count) VALUES
-- 📱 Electrónica y Tecnología
(21, 'iPhone 15 Pro 256GB',           'Smartphone Apple con chip A17 Pro, camara de 48MP, USB-C y titanio',                                      999.99,  15, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/iPhone%2015%20Pro%20256GB.jpg',             4.9, 1, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440001', '2026-03-15 10:00:00', 89),
(22, 'Tablet Samsung Galaxy Tab A9',  'Tablet 10.5" con pantalla LCD, 64GB, WiFi, ideal para entretenimiento y trabajo',                          349.99,  28, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Tablet%20Samsung%20Galaxy%20Tab%20A9.webp',             4.4, 1, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440001', '2026-03-20 11:00:00', 45),
(23, 'Powerbank 20000mAh Carga Rapida','Bateria portatil con carga rapida 22.5W, 2 puertos USB + USB-C, pantalla LED',                             39.99, 200, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Powerbank%2020000mAh%20Carga%20Rapida.webp',       4.3, 1, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440001', '2026-04-01 09:00:00', 67),
-- 👕 Ropa y Moda
(24, 'Remera Polo Clasica',           'Remera estilo polo 100% algodon pique, disponible en 6 colores, tallas S-XXL',                              19.99, 150, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Remera%20Polo%20Clasica.webp',       4.2, 2, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440002', '2026-02-10 08:00:00', 30),
(25, 'Pantalon Chino Slim Fit',       'Pantalon casual slim fit, tela stretch comoda, colores neutros, tallas 28-38',                              49.99,  85, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Pantalon%20Chino%20Slim%20Fit.jpg',       4.5, 2, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440002', '2026-02-15 09:00:00', 55),
(26, 'Campera Impermeable Windbreaker','Campera cortaviento impermeable, capucha desmontable, tallas S-XL, varios colores',                         89.99,  40, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Campera%20Impermeable%20Windbreaker.webp',       4.7, 2, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440002', '2026-03-05 10:00:00', 20),
-- 🏠 Hogar y Decoración
(27, 'Set de Sabanas Queen Premium',  'Juego de sabanas 4 piezas, microfibra suave 1800 hilos, lavable a maquina',                                  79.99,  60, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Set%20de%20Sabanas%20Queen%20Premium.webp', 4.6, 3, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440003', '2026-02-20 08:30:00', 88),
(28, 'Organizador de Escritorio Bambu','Organizador multi-compartimento de bambu natural, para lapiceros, papeles y accesorios',                    24.99, 120, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Organizador%20de%20Escritorio%20Bambu.webp',         4.1, 3, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440003', '2026-03-10 11:00:00', 15),
(29, 'Espejo Decorativo Marco Dorado', 'Espejo circular 60cm con marco dorado estilo minimalista, apto pared',                                      59.99,  35, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Espejo%20Decorativo%20Marco%20Dorado.jpg',         4.4, 3, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440003', '2026-03-25 14:00:00', 22),
-- 🧴 Belleza y Cuidado Personal
(30, 'Set de Pinceles de Maquillaje', 'Set profesional de 15 pinceles con estuche, cerdas sinteticas suaves, lavables',                            29.99,  90, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Set%20de%20Pinceles%20de%20Maquillaje.webp',    4.5, 4, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440004', '2026-02-05 10:00:00', 40),
(31, 'Serum Vitamina C 30ml',         'Serum antioxidante con vitamina C al 15%, acido hialuronico y vitamina E, reafirma y unifica el tono',      44.99, 110, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Serum%20Vitamina%20C%2030ml.webp',    4.8, 4, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440004', '2026-03-01 09:30:00', 75),
(32, 'Protector Solar FPS 50 100ml',  'Protector solar de amplio espectro, formula oil-free, no deja residuo blanco, water resistant',              18.99, 200, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Protector%20Solar%20FPS%2050%20100ml.jpg',               4.3, 4, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440004', '2026-03-18 08:00:00', 33),
-- 🧸 Juguetes y Niños
(33, 'Set LEGO Creator 500 piezas',   'Set de construccion LEGO con 500 piezas para crear 3 modelos distintos, edad recomendada +8 anos',           69.99,  45, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Set%20LEGO%20Creator%20500%20piezas.webp', 4.9, 5, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440005', '2026-01-20 10:00:00', 110),
(34, 'Muneca Interactiva con Accesorios','Muneca que habla y canta, incluye set de ropa, peinados y accesorios, pilas incluidas, +3 anos',          39.99,  70, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Muneca%20Interactiva%20con%20Accesorios.jpg',           4.4, 5, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440005', '2026-02-28 11:00:00', 28),
(35, 'Bicicleta Infantil Rodado 16',  'Bicicleta para ninos 4-7 anos, con rueditas de apoyo desmontables, freno trasero y manillar ajustable',    129.99,  20, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Bicicleta%20Infantil%20Rodado%2016.webp', 4.6, 5, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440005', '2026-03-08 09:00:00', 18),
-- 🏋️ Deportes y Fitness
(36, 'Pelota de Futbol Profesional',  'Pelota de futbol tamano 5, cubierta de PU, costuras reforzadas, apta para cesped natural y sintetico',       34.99,  80, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Pelota%20de%20Futbol%20Profesional.webp',  4.5, 6, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440006', '2026-02-01 08:00:00', 42),
(37, 'Bicicleta de Montana 26"',      'Bicicleta MTB 21 velocidades, marco de aluminio, frenos de disco, horquilla delantera con suspension',      449.99,   8, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Bicicleta%20de%20Montana%2026.webp',   4.7, 6, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440006', '2026-01-10 10:00:00', 12),
(38, 'Soga para Saltar Profesional',  'Soga de crossfit con rodamientos de precision, cables de acero, mangos ergonomicos, largo ajustable',        14.99, 300, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Soga%20para%20Saltar%20Profesional.webp',  4.2, 6, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440006', '2026-04-10 07:00:00', 25),
-- 🖥️ Computación y Accesorios
(39, 'Monitor Curvo 27" Full HD',     'Monitor LED curvo 1500R, 1920x1080, 75Hz, 5ms, con entrada HDMI y DisplayPort, compatible con VESA',        299.99,  22, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Monitor%20Curvo%2027%20Full%20HD.webp',       4.6, 7, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440001', '2026-02-22 09:00:00', 35),
(40, 'Auriculares Gaming con Microfono','Auriculares over-ear 7.1 virtual, iluminacion RGB, microfono flexible con cancelacion de ruido, USB',       59.99,  75, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Auriculares%20Gaming%20con%20Microfono.webp',   4.4, 7, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440001', '2026-03-12 10:00:00', 48),
(41, 'Webcam Full HD 1080p',          'Camara web con microfono integrado, enfoque automatico, compatible con Zoom/Teams/Meet, clip universal',      49.99,  95, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Webcam%20Full%20HD%201080p.webp',       4.3, 7, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440001', '2026-03-28 11:30:00', 29),
-- 🍳 Electrodomésticos
(42, 'Freidora de Aire 5.5L Digital', 'Air fryer con pantalla digital, 8 programas preestablecidos, capacidad 5.5L, bajo consumo energetico',      119.99,  38, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Freidora%20de%20Aire%205.5L%20Digital.jpg',   4.8, 8, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440003', '2026-01-25 08:00:00', 92),
(43, 'Cafetera de Capsulas Express',  'Cafetera compatible con capsulas Nespresso, 19 bares de presion, deposito 0.6L, calentamiento en 25 seg',    89.99,  55, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Cafetera%20de%20Capsulas%20Express.jpg',   4.5, 8, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440003', '2026-02-14 09:00:00', 61),
(44, 'Aspiradora Robot con Mapeado',  'Aspiradora robotica con mapeo laser, navegacion inteligente, compatible con app y asistentes de voz',        249.99,  12, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Aspiradora%20Robot%20con%20Mapeado.webp',   4.6, 8, 'ACTIVE',  '550e8400-e29b-41d4-a716-446655440003', '2026-03-03 14:00:00', 37),
-- 🚗 Automotor y Herramientas
(45, 'Camara de Reversa Inalambrica', 'Camara trasera HD 170° con vision nocturna, transmision inalambrica, compatible con radios Android/iPhone',  39.99,  60, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Camara%20de%20Reversa%20Inalambrica.webp', 4.3, 9, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440006', '2026-02-08 10:00:00', 18),
(46, 'Compresor de Aire Portatil 12V','Inflador electrico portatil 150PSI, pantalla digital, corte automatico de presion, cable 3m, maletin',       54.99,  45, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Compresor%20de%20Aire%20Portatil%2012V.webp', 4.5, 9, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440006', '2026-03-14 09:30:00', 26),
(47, 'Alfombras Universales para Auto','Set de 4 alfombras de goma impermeables, antideslizantes, lavables, ajuste universal',                       29.99,  90, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Alfombras%20Universales%20para%20Auto.webp', 4.1, 9, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440006', '2026-04-04 08:00:00', 11),
-- 🐶 Mascotas
(48, 'Cama Ortopedica para Perro L',  'Cama con relleno de espuma viscoelastica, funda lavable, tamano L (80x60cm), ideal para razas grandes',      54.99,  35, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Cama%20Ortopedica%20para%20Perro%20L.webp',  4.7, 10, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440003', '2026-02-18 10:00:00', 44),
(49, 'Rascador para Gatos Torre',     'Torre rascador de 120cm con 3 niveles, cuerda de sisal, hamacas y juguetes colgantes, base estable',          79.99,  22, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Rascador%20para%20Gatos%20Torre.webp', 4.5, 10, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440003', '2026-03-22 11:00:00', 19),
(50, 'Correa Retractil 5 Metros',     'Correa retractil hasta 25kg, cinta reflectante, freno de seguridad, ergonomica, disponible en 3 colores',     19.99, 150, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Correa%20Retractil%205%20Metros.webp',  4.2, 10, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440003', '2026-04-11 09:00:00', 31)
ON CONFLICT (id) DO UPDATE SET seller_id = EXCLUDED.seller_id, status = EXCLUDED.status, created_at = EXCLUDED.created_at, reviews_count = EXCLUDED.reviews_count;

-- Product images para productos 21-50
INSERT INTO product_images (product_id, image_url) VALUES
(21, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/iPhone%2015%20Pro%20256GB.jpg'),
(22, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Tablet%20Samsung%20Galaxy%20Tab%20A9.webp'),
(23, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Powerbank%2020000mAh%20Carga%20Rapida.webp'),
(24, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Remera%20Polo%20Clasica.webp'),
(25, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Pantalon%20Chino%20Slim%20Fit.jpg'),
(26, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Campera%20Impermeable%20Windbreaker.webp'),
(27, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Set%20de%20Sabanas%20Queen%20Premium.webp'),
(28, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Organizador%20de%20Escritorio%20Bambu.webp'),
(29, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Espejo%20Decorativo%20Marco%20Dorado.jpg'),
(30, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Set%20de%20Pinceles%20de%20Maquillaje.webp'),
(31, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Serum%20Vitamina%20C%2030ml.webp'),
(32, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Protector%20Solar%20FPS%2050%20100ml.jpg'),
(33, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Set%20LEGO%20Creator%20500%20piezas.webp'),
(34, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Muneca%20Interactiva%20con%20Accesorios.jpg'),
(35, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Bicicleta%20Infantil%20Rodado%2016.webp'),
(36, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Pelota%20de%20Futbol%20Profesional.webp'),
(37, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Bicicleta%20de%20Montana%2026.webp'),
(38, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Soga%20para%20Saltar%20Profesional.webp'),
(39, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Monitor%20Curvo%2027%20Full%20HD.webp'),
(40, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Auriculares%20Gaming%20con%20Microfono.webp'),
(41, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Webcam%20Full%20HD%201080p.webp'),
(42, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Freidora%20de%20Aire%205.5L%20Digital.jpg'),
(43, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Cafetera%20de%20Capsulas%20Express.jpg'),
(44, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Aspiradora%20Robot%20con%20Mapeado.webp'),
(45, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Camara%20de%20Reversa%20Inalambrica.webp'),
(46, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Compresor%20de%20Aire%20Portatil%2012V.webp'),
(47, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Alfombras%20Universales%20para%20Auto.webp'),
(48, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Cama%20Ortopedica%20para%20Perro%20L.webp'),
(49, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Rascador%20para%20Gatos%20Torre.webp'),
(50, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Correa%20Retractil%205%20Metros.webp')
ON CONFLICT DO NOTHING;

-- Insert product images
INSERT INTO product_images (product_id, image_url) VALUES
(1, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Samsung%20Galaxy%20A54.png'),
(2, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Auriculares%20Sony%20WH-CH720.jpg'),
(4, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Zapatillas%20Running%20Pro.webp'),
(5, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Lampara%20LED%20de%20Piso.jpg'),
(6, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Almohada%20Premium%20Memory%20Foam.jpg'),
(7, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Crema%20Facial%20Hidratante.webp'),
(9, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Juego%20de%20ConstrucciOn%201000%20piezas.webp'),
(10, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Andador%20para%20Bebe.png'),
(11, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Mancuernas%20Ajustables%2020kg.webp'),
(12, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Colchoneta%20Yoga%20Premium.webp'),
(14, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Mouse%20Inalambrico%20Pro.png'),
(15, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Licuadora%20Digital%202000W.jpg'),
(16, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Microondas%20Inteligente.webp'),
(17, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Kit%20de%20Herramientas%2020%20piezas.webp'),
(18, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Pedal%20de%20Acelerador%20Deportivo.webp'),
(19, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Comida%20Premium%20para%20Perros.webp'),
(20, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Juguete%20Interactivo%20para%20Perro.webp'),
(61, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Marketplace%20Headphones%20Pro.jpg'),
(62, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Marketplace%20Smart%20Watch.jpg'),
(63, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Zapatillas%20Running%20Pro.webp')
ON CONFLICT DO NOTHING;

-- Align products sequence with the highest seeded product ID.
SELECT setval('products_id_seq', (SELECT COALESCE(MAX(id), 1) FROM products), true);

-- ─── Carritos de compra ──────────────────────────────────────────────────────

INSERT INTO carts (id, user_id, total_price, item_count, created_at, updated_at)
VALUES
    (1, 'cccccccc-cccc-cccc-cccc-cccccccccc01', 124.98, 2, '2026-06-10 10:00:00', '2026-06-14 11:00:00'),
    (2, 'cccccccc-cccc-cccc-cccc-cccccccccc02', 44.99,  1, '2026-06-12 09:00:00', '2026-06-12 09:30:00'),
    (3, 'cccccccc-cccc-cccc-cccc-cccccccccc03', 29.99,  1, '2026-06-13 16:00:00', '2026-06-13 16:00:00')
ON CONFLICT (user_id) DO UPDATE
SET total_price = EXCLUDED.total_price,
    item_count  = EXCLUDED.item_count,
    updated_at  = EXCLUDED.updated_at;

SELECT setval('carts_id_seq', (SELECT COALESCE(MAX(id), 1) FROM carts), true);

-- ─── Ítems de carrito ────────────────────────────────────────────────────────

INSERT INTO cart_items (cart_id, product_id, quantity, unit_price, total_price)
VALUES
    -- Laura: Auriculares Sony + Mouse Inalámbrico
    (1, 2,  1, 79.99,  79.99),
    (1, 14, 1, 34.99,  34.99),

    -- Carlos: Colchoneta Yoga
    (2, 12, 1, 44.99,  44.99),

    -- María: Comida Premium para Perros
    (3, 19, 1, 29.99,  29.99)
ON CONFLICT DO NOTHING;

-- ─── Reseñas de productos ────────────────────────────────────────────────────

INSERT INTO product_reviews (product_id, order_id, buyer_id, score, comment, created_at)
VALUES
    -- Laura reseña Samsung Galaxy A54 (orden 101)
    (1, '11111111-1111-1111-1111-111111111101',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Excelente teléfono, pantalla brillante y cámara increíble.',
     '2026-05-15 10:30:00'),

    -- Carlos reseña Zapatillas Running Pro (orden 102)
    (4, '11111111-1111-1111-1111-111111111102',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'Muy cómodas, buena amortiguación, talla ligeramente grande.',
     '2026-05-22 14:00:00'),

    -- María reseña Lámpara LED (orden 103)
    (5, '11111111-1111-1111-1111-111111111103',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     3, 'Bonita lámpara pero el control remoto no siempre responde.',
     '2026-06-02 09:00:00'),

    -- María reseña Almohada Memory Foam (orden 103)
    (6, '11111111-1111-1111-1111-111111111103',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'La mejor almohada que tuve, duermo mucho mejor.',
     '2026-06-02 09:15:00'),

    -- Laura reseña Mancuernas (orden 106)
    (11, '11111111-1111-1111-1111-111111111106',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Calidad top, el sistema de ajuste funciona perfecto.',
     '2026-06-05 16:30:00'),

    -- Carlos reseña Crema Facial (orden 107)
    (7, '11111111-1111-1111-1111-111111111107',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Hidrata muy bien y se absorbe rapido, sin sensacion grasosa.',
     '2026-05-31 09:00:00'),

    -- Carlos reseña Perfume Essence (orden 107)
    (8, '11111111-1111-1111-1111-111111111107',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'Aroma agradable y buena duracion en piel, el frasco es muy elegante.',
     '2026-05-31 09:20:00'),

    -- María reseña Juego de Construcción (orden 108)
    (9, '11111111-1111-1111-1111-111111111108',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'A mis hijos les encanto, piezas de muy buena calidad y bien prolijo el armado.',
     '2026-06-08 10:00:00'),

    -- Laura reseña Teclado Mecánico RGB (orden 101, producto adicional)
    (13, '11111111-1111-1111-1111-111111111101',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'El mejor teclado que tuve, las teclas tienen un tacto increible.',
     '2026-05-15 11:00:00'),

    -- Carlos reseña Colchoneta Yoga (orden 102, producto adicional)
    (12, '11111111-1111-1111-1111-111111111102',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'Buena densidad, no se desliza en el piso. Le faltaria ser un poco mas gruesa.',
     '2026-05-23 08:30:00'),

    -- Laura reseña iPhone 15 Pro (orden 109)
    (21, '11111111-1111-1111-1111-111111111109',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Una bestia de teléfono. La cámara es increíble y el titanio se siente premium.',
     '2026-05-10 11:00:00'),

    -- Carlos reseña Tablet Samsung (orden 109)
    (22, '11111111-1111-1111-1111-111111111109',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'Muy fluida para ver contenido y trabajar. La pantalla podria tener mejor brillo en exteriores.',
     '2026-05-10 11:30:00'),

    -- María reseña Powerbank (orden 110)
    (23, '11111111-1111-1111-1111-111111111110',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Cargó mi celular 3 veces completas. La pantalla LED es muy útil para ver cuánta batería queda.',
     '2026-05-18 14:00:00'),

    -- Laura reseña Campera Windbreaker (orden 110)
    (26, '11111111-1111-1111-1111-111111111110',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Perfecta para el frio y la lluvia. La capucha ajusta bien y no entra viento.',
     '2026-05-18 15:00:00'),

    -- Carlos reseña Set de Sábanas (orden 111)
    (27, '11111111-1111-1111-1111-111111111111',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'Suaves al tacto y no se arrugaron mucho después del lavado. Buen precio.',
     '2026-05-25 09:00:00'),

    -- María reseña Espejo Marco Dorado (orden 111)
    (29, '11111111-1111-1111-1111-111111111111',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Quedó hermoso en el living. El marco dorado le da un toque muy elegante.',
     '2026-05-25 10:00:00'),

    -- Laura reseña Sérum Vitamina C (orden 112)
    (31, '11111111-1111-1111-1111-111111111112',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Notei el cambio en el tono de mi piel en dos semanas. Se absorbe rapido y no deja sensacion pegajosa.',
     '2026-06-01 08:30:00'),

    -- Carlos reseña Protector Solar (orden 112)
    (32, '11111111-1111-1111-1111-111111111112',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'Buena proteccion y no deja residuo blanco. Un poco caro para el tamaño del pomo.',
     '2026-06-01 09:00:00'),

    -- María reseña Set LEGO Creator (orden 113)
    (33, '11111111-1111-1111-1111-111111111113',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Mi hijo armó los 3 modelos. Las instrucciones son claras y las piezas de muy buena calidad.',
     '2026-06-03 16:00:00'),

    -- Laura reseña Bicicleta Infantil (orden 113)
    (35, '11111111-1111-1111-1111-111111111113',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Mi hija aprendio a andar en bici en dos dias. Las rueditas de apoyo se sacan facilmente.',
     '2026-06-03 17:00:00'),

    -- Carlos reseña Pelota de Fútbol (orden 114)
    (36, '11111111-1111-1111-1111-111111111114',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Muy buena pelota, aguanta bien el rebote y la costura es resistente. La uso en cancha de tierra.',
     '2026-06-06 10:00:00'),

    -- María reseña Soga para Saltar (orden 114)
    (38, '11111111-1111-1111-1111-111111111114',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     4, 'Los rodamientos hacen que gire muy suave. Le doy 4 estrellas porque el largo minimo podria ser menor.',
     '2026-06-06 10:30:00'),

    -- Laura reseña Monitor Curvo (orden 115)
    (39, '11111111-1111-1111-1111-111111111115',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'La curva se nota mucho jugando. Colores vivos y sin ghosting a 75Hz.',
     '2026-06-09 12:00:00'),

    -- Carlos reseña Auriculares Gaming (orden 115)
    (40, '11111111-1111-1111-1111-111111111115',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'Sonido envolvente muy bueno. El microfono capta bien la voz sin mucho ruido de fondo.',
     '2026-06-09 12:30:00'),

    -- María reseña Freidora de Aire (orden 116)
    (42, '11111111-1111-1111-1111-111111111116',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Hago papas fritas sin aceite y quedan crocantes. Los 8 programas cubren todo lo que necesito.',
     '2026-06-11 19:00:00'),

    -- Laura reseña Cafetera de Cápsulas (orden 116)
    (43, '11111111-1111-1111-1111-111111111116',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'El café queda con una crema perfecta. Calienta rapidisimo y ocupa poco espacio en la mesada.',
     '2026-06-11 07:30:00'),

    -- Carlos reseña Cámara de Reversa (orden 117)
    (45, '11111111-1111-1111-1111-111111111117',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'La imagen es clara incluso de noche. La conexion inalambrica tarda un segundo en sincronizar al arrancar.',
     '2026-06-13 18:00:00'),

    -- María reseña Cama Ortopédica para Perro (orden 118)
    (48, '11111111-1111-1111-1111-111111111118',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Mi labrador la adoptó el primer día. La funda se saca y lava sin problemas.',
     '2026-06-14 09:00:00'),

    -- Laura reseña Rascador para Gatos (orden 118)
    (49, '11111111-1111-1111-1111-111111111118',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Mi gato ya no araña los muebles. Muy estable, no se cae aunque salte desde arriba.',
     '2026-06-14 09:30:00'),

    -- Carlos reseña Andador para Bebé (orden 119)
    (10, '11111111-1111-1111-1111-111111111119',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'A mi sobrino le encanta la música y las luces. Facil de armar y bien seguro.',
     '2026-06-15 11:00:00'),

    -- María reseña Mouse Inalámbrico (orden 119)
    (14, '11111111-1111-1111-1111-111111111119',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     3, 'Funciona bien pero el scroll a veces salta. La bateria dura lo que dice.',
     '2026-06-15 11:30:00'),

    -- Laura reseña Licuadora Digital (orden 120)
    (15, '11111111-1111-1111-1111-111111111120',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Tritura hielo sin problema. El vaso de vidrio es muy practico para llevar al trabajo.',
     '2026-06-16 08:00:00'),

    -- Carlos reseña Aspiradora Robot (orden 120)
    (44, '11111111-1111-1111-1111-111111111120',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'El mapeo es muy preciso, no se choca con nada. Desde la app se programa solo y avisa cuando terminó.',
     '2026-06-16 20:00:00')

ON CONFLICT (product_id, order_id) DO NOTHING;

-- ============================================================
-- Nuevos productos (IDs 65–111)
-- Nuevos sellers: 008 Patitas & Co · 009 Cerámica Dulce
--                 010 Teje & Diseña · 011 FitLife Pro · 012 KawaiiTech
-- ============================================================

-- ─── 🐾 Mascotas — Patitas & Co ─────────────────────────────────────────────
INSERT INTO products (id, name, description, price, stock, main_image, rating, category_id, status, seller_id, created_at, reviews_count) VALUES
(65,  'Woof Walk Bag Marrón',          'Bolso paseador de cuero vegano color marrón para llevar a tu perrito a caminar. Cierre seguro, correa ajustable y ventilación lateral. Tu mejor compañero viaja con estilo.',                                                                   34.99,  60, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/020d718f21c09294dd1ad11015492add.jpg',   4.6, 10, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440008', '2026-05-01 10:00:00', 28),
(66,  'Mini Paws Bolsito',             'El bolsito más adorable del mercado para mascotas pequeñas. Compacto, liviano y con tela suave en el interior. Ideal para salidas cortas y visitas al veterinario.',                                                                          19.99,  80, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/09a1b5e6d6d72cc56c725b16c511e966.jpg',   4.4, 10, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440008', '2026-05-03 11:00:00', 15),
(67,  'Explorer Carrier Canino',       'Bolso transportín de tela resistente para paseos largos. Malla transpirable en ambos laterales, base rígida antideslizante y bolsillo exterior para snacks y bolsitas.',                                                                      42.99,  45, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/20b5852a96c7c23fe5bd27e16d310f6c.jpg',   4.5, 10, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440008', '2026-05-05 09:00:00', 20),
(68,  'AstroPet Mochila Burbuja',      'Mochila con cúpula transparente para que tu perrito vea el mundo entero sin perderse nada. Ventilación superior, base acolchada lavable y correas ergonómicas acolchadas.',                                                                    55.99,  35, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/333aa0cc3f647beda6ddd9d41e0c17eb.jpg',   4.8, 10, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440008', '2026-05-08 10:00:00', 52),
(69,  'Trail Rider Mochila Canina',    'Mochila de trekking para perros que aman la aventura. Resistente al agua, cremalleras dobles de metal y panel de malla en el frente para máxima ventilación. Para exploradores de cuatro patas.',                                             49.99,  28, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/90ae8e8a51439765acc2f2ade1c5693e.jpg',   4.6, 10, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440008', '2026-05-10 11:00:00', 18),
(70,  'Correa Osito Kawaii',           'Correa para mascotas con diseño de osito tierno en el gancho. Nylon resistente con refuerzo en los puntos de tensión, cierre de seguridad y largo ajustable de 1.2 a 2 metros.',                                                             14.99, 120, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/825b04a169872a387d4e29763c796980.jpg',   4.5, 10, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440008', '2026-05-12 08:00:00', 33),
(71,  'Happy Paws Correa Celeste',     'Correa suave al tacto en celeste pastel con detalles estampados. Perfecta para razas pequeñas y medianas. Agarradera acolchada con relleno de neoprene para más comodidad en el paseo.',                                                      12.99, 140, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/d1ef34c058bf9dbe8a9fd16baa878806.jpg',   4.3, 10, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440008', '2026-05-14 09:30:00', 11),
(72,  'Sausage Dog Snack Bowl',        'Bowl para snacks y agua con forma de perro salchicha sonriente. Cerámica no tóxica con esmalte vitrificado, base antideslizante de silicona. Capacidad 350 ml, lavavajillas safe.',                                                           18.99,  70, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/279b890f0f6dafcf4b6e6129013983b6.jpg',   4.7, 10, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440008', '2026-05-16 10:00:00', 24)
ON CONFLICT (id) DO UPDATE SET seller_id = EXCLUDED.seller_id, status = EXCLUDED.status, created_at = EXCLUDED.created_at, reviews_count = EXCLUDED.reviews_count;

-- ─── 🏋️ Deportes y Fitness — FitLife Pro ────────────────────────────────────
INSERT INTO products (id, name, description, price, stock, main_image, rating, category_id, status, seller_id, created_at, reviews_count) VALUES
(73,  'Speed Rope Blanca Pro',         'Soga de salto de alta velocidad en blanco puro. Cables de acero trenzado recubiertos de PVC, rodamientos de bolas de precisión y mangos ergonómicos antideslizantes. Para tus mejores WODs.',                                                 16.99, 150, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/07a63cca1418081ca6e2cfdd38798f1a.jpg',   4.4,  6, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440011', '2026-04-15 09:00:00', 19),
(74,  'Pearl Dumbbells Set Blancas',   'Mancuernas de neoprene blanco con superficie antideslizante y acabado satinado. Disponibles de 1 a 5 kg por par. El accesorio chic que no puede faltar en tu home gym.',                                                                      44.99,  90, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/0bb8d12d392ab5a535db27512ea29a64.jpg',   4.6,  6, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440011', '2026-04-18 10:00:00', 37),
(75,  'Iron Gray Rack + Mancuernas',   'Set completo de mancuernas grises hexagonales con rack organizador de acero pintado en gris. Pesos del 2 al 10 kg. Ahorrá espacio y mantené tu gym siempre ordenado.',                                                                        189.99, 15, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/1fa2c1cd243a3da91d84624e768c0d50.jpg',   4.7,  6, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440011', '2026-04-20 11:00:00', 13),
(76,  'Iron Punch Bolsa de Boxeo',     'Bolsa de boxeo de cuero sintético, 25 kg de relleno compacto. Incluye cadena de acero con mosquetones reforzados y soporte giratorio. Ideal para golpes, combos y aliviar el estrés del día.',                                                 99.99,  20, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/81c93f7ad4801d49fbfb637772dd4d0a.jpg',   4.5,  6, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440011', '2026-04-22 12:00:00', 22),
(77,  'VeloCycle Home Bicicleta',      'Bicicleta estática digital con pantalla LED que muestra velocidad, tiempo, distancia y calorías. Resistencia magnética de 8 niveles, asiento ergonómico regulable y pedales antideslizantes. Pedaleá mientras ves tu serie favorita.',        259.99,  10, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/50c24bf8b1fcb463c8176334f9fc264e.jpg',   4.6,  6, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440011', '2026-04-25 13:00:00', 8)
ON CONFLICT (id) DO UPDATE SET seller_id = EXCLUDED.seller_id, status = EXCLUDED.status, created_at = EXCLUDED.created_at, reviews_count = EXCLUDED.reviews_count;

-- ─── 🏠 Hogar y Decoración — varios sellers ──────────────────────────────────
INSERT INTO products (id, name, description, price, stock, main_image, rating, category_id, status, seller_id, created_at, reviews_count) VALUES
(78,  'Alfombra Jardín Violeta',       'Alfombra de pelo corto con estampado floral en tonos violeta y lila. Suave al tacto, base antideslizante de látex y fácil de limpiar con aspiradora. Dale vida a cualquier rincón de tu hogar.',                                              59.99,  40, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/177045129635532e2e8664c6cbd9bdfb1561779f92_thumbnail_405x.webp', 4.5, 3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440010', '2026-05-02 09:00:00', 16),
(79,  'Sábanas Floral Violeta',        'Set de sábanas 4 piezas con estampado floral en tonos violeta, malva y verde menta. Microfibra de 1800 hilos, suave como una nube y resistente al lavado a máquina.',                                                                          74.99,  55, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/59f1ab870af4fe97423947e3f07a2a00.jpg',   4.7,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440003', '2026-05-04 10:00:00', 29),
(80,  'Puff Snorlax XL',              'Sillón puff gigante con forma de Snorlax en tela peluche de alta calidad. Relleno de espuma de alta densidad, funda desmontable y lavable. Porque dormir como Snorlax es una filosofía de vida entera.',                                       129.99,  18, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/23e1478379c6f17739435ece9c519cc6.jpg',   4.9,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440010', '2026-05-06 11:00:00', 47),
(81,  'Ganchos Gatito para Ropa',      'Set de 6 ganchos con forma de gatitos para tender la ropa. Plástico ABS resistente a la intemperie con resorte de acero inoxidable, no marcan las prendas y llenan de ternura tu tendedero.',                                                  9.99, 200, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/68fb9229c91a85e564bc085010230faf.jpg',   4.3,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440010', '2026-05-08 08:00:00', 38),
(82,  'Ranita Porta Esponja',          'Porta esponja de pileta con forma de ranita verde sonriente. Cerámica vidriada no absorbente, base maciza antideslizante. Le da un toque adorable al lavaplatos y mantiene la esponja ventilada.',                                              14.99,  90, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/e335838b1217d9a06110ebe56f5e9b70.jpg',   4.6,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440009', '2026-05-10 09:00:00', 21),
(83,  'Estante Organizador Cocina',    'Mueble organizador de cocina con 3 niveles regulables en altura. Acero cromado resistente con capacidad de 12 kg por estante. Armado sin herramientas, mantiene todo a mano y en orden.',                                                      54.99,  35, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/29cf0d3257686520849ffde6b870e99e.jpg',   4.4,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440003', '2026-05-12 10:00:00', 12),
(84,  'Torre Organizadora Lavaropa',   'Mueble lateral para lavaropa con 3 cajones deslizantes extraíbles. Plástico ABS de alta resistencia, ruedas con freno y capacidad total de 30 L. Aprovechá el espacio muerto al lado del lavaropa.',                                           69.99,  25, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/924849ebc2bd6fdca0d0509125b74c08.jpg',   4.3,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440003', '2026-05-14 11:00:00', 9),
(85,  'Portátazas Vintage',            'Mueble organizador de tazas estilo vintage con estructura de madera de pino. 8 ganchos de metal y 2 estantes superiores para guardar hasta 12 tazas y sus platos. Le da calidez a cualquier cocina.',                                          39.99,  50, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/bd40e96b200eac055776b911566b20a0.jpg',   4.5,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440003', '2026-05-16 09:00:00', 17),
(86,  'Chicarita Suculenta Deco',      'Mini planta artificial tipo suculenta en maceta de cerámica pintada. No necesita agua, ni luz, ni cuidados. Solo amor. Perfecta para escritorios, estantes, baños y rincones que piden vida.',                                                  12.99, 110, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/380504bd143513801507d42f3ed10f67.jpg',   4.8,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440010', '2026-05-18 10:00:00', 43),
(87,  'Rollie Ovejitas Deco',          'Rollo de papel higiénico decorativo con diseño de ovejitas tiernas. Celulosa suave de triple hoja, 200 hojas por rollo, pack de 4. El baño más cute de todo el barrio, garantizado.',                                                          11.99, 160, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/2ea2b6a907655563e0e2d304cefdb5d6.jpg',   4.2,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440010', '2026-05-19 08:30:00', 31),
(88,  'Rollie Perrito Deco Cocina',    'Rollo de cocina decorativo con diseño de perritos salchichas. Pack de 2 rollos, doble hoja súper absorbente y resistente. Limpiá con amor y estilo a partes iguales.',                                                                          9.99, 180, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/3db841a2c43b6f791c6bda5f197897f0.jpg',   4.3,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440010', '2026-05-20 09:00:00', 26),
(89,  'Ovejita Porta Control Remoto',  'Porta control remoto tejido a mano con forma de ovejita blanca y esponjosa. Lana acrílica lavable a mano, dos bolsillos laterales con capacidad para hasta 3 controles. Nunca más vas a perder el control.',                                    17.99,  75, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/6b764e2c3df6b07e4ae41f7075804748.jpg',   4.7,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440010', '2026-05-21 10:00:00', 34)
ON CONFLICT (id) DO UPDATE SET seller_id = EXCLUDED.seller_id, status = EXCLUDED.status, created_at = EXCLUDED.created_at, reviews_count = EXCLUDED.reviews_count;

-- ─── 🗓️ Calendarios de Cerámica — Cerámica Dulce ────────────────────────────
INSERT INTO products (id, name, description, price, stock, main_image, rating, category_id, status, seller_id, created_at, reviews_count) VALUES
(90,  'Calendario Eterno Kiki''s Cat',  'Calendario perpetuo de cerámica artesanal con diseño de Kiki''s Delivery Service. Tres piezas intercambiables para día, mes y año. Un eterno homenaje a los amantes del anime japonés, pintado a mano.',                                     29.99,  60, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/070b832039b1ff59e3463177bb8a72c9.jpg',   4.9,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440009', '2026-05-01 09:00:00', 55),
(91,  'Calendario Sol de Cerámica',    'Calendario perpetuo artesanal con motivo de sol bohemio en tonos terracota y dorado. Pintado a mano con esmalte vitrificado, cada pieza es única e irrepetible. Para quienes disfrutan la magia de lo hecho con amor.',                       27.99,  45, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/35e3ebc11de4c278df7dec792a150b14.jpg',   4.7,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440009', '2026-05-03 09:30:00', 32),
(92,  'Calendario Snoopy Cerámica',    'Calendario perpetuo de cerámica con Snoopy y Charlie Brown en sus mejores momentos. Pintado con colores vibrantes y esmalte durable. Ideal para escritorios, mesitas de luz y regalar con mucho amor.',                                         29.99,  50, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/92e55f6d69f45905670f20204d9b6995.jpg',   4.8,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440009', '2026-05-05 10:00:00', 41),
(93,  'Calendario Animal Cute Cerámica','Calendario perpetuo de cerámica con diseño animal a tu elección: patito, gatito, sapito o pingüino. Artesanal, pintado a mano con esmaltes no tóxicos. Indicá tu favorito en las notas del pedido.',                                           27.99,  80, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/f25d2f692b62456133df2386f6f0d5f6.jpg',   4.9,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440009', '2026-05-07 09:00:00', 68),
(94,  'Calendario Pokémon Fan Edition','Calendario perpetuo de cerámica con diseño de Pokémon pintado a mano. Elegí tu favorito al comprar. Edición coleccionable, ideal para fans de todas las edades. ¡Tenés que atraparlos todos!',                                                  29.99,  55, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/f832d9602a144ed710243c245009313e.jpg',   4.8,  3, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440009', '2026-05-09 10:00:00', 49)
ON CONFLICT (id) DO UPDATE SET seller_id = EXCLUDED.seller_id, status = EXCLUDED.status, created_at = EXCLUDED.created_at, reviews_count = EXCLUDED.reviews_count;

-- ─── 🍳 Cerámica de Cocina — Cerámica Dulce ──────────────────────────────────
INSERT INTO products (id, name, description, price, stock, main_image, rating, category_id, status, seller_id, created_at, reviews_count) VALUES
(95,  'Toast Art Soporte Cerámica',    'Soporte cerámico artesanal para tostadas, hecho a mano con arcilla blanca y esmalte coloreado. Elegí tu diseño al comprar: flores, rayas o puntitos. El desayuno nunca fue tan lindo.',                                                        18.99,  85, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/28f63a302d13e79c68e9b9fce8e16bbc.jpg',   4.6,  8, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440009', '2026-05-02 10:00:00', 27),
(96,  'Tea Party Set Cerámica',        'Set de té de cerámica artesanal en rojo y blanco estilo cute japonés: tetera de 600 ml, 2 tazas y azucarera. Esmaltado interior vitrificado, apto para microondas. El ritual del té, elevado.',                                               54.99,  40, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/6a5dcd0660c63b505ca9e65abae6d38c(1).jpg', 4.8, 8, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440009', '2026-05-04 09:00:00', 36),
(97,  'Violeta Full Vajilla',          'Vajilla completa de cerámica violeta para 4 personas: 4 platos planos, 4 hondos, 4 bowls y 4 tazas con plato. Esmaltado con óxidos vitrificados, apto lavavajillas. Porque la mesa también puede ser un cuadro.',                              189.99,  12, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/a2bc6f0673ba34ba5d6bab1ba04e7f7a.jpg',   4.7,  8, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440009', '2026-05-06 11:00:00', 14),
(98,  'Fry & Dip Apoyo Cerámica',      'Apoyo cerámico artesanal con dos compartimentos integrados: uno generoso para las papas fritas y otro más pequeño para el aderezo. Divertido, funcional y perfecto para el picadillo del finde con amigos.',                                    22.99,  65, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/bc8d9bb9707f7f8c7ae099823351913a.jpg',   4.5,  8, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440009', '2026-05-08 10:00:00', 23),
(99,  'Tea Rest Saquito Cerámica',     'Reposa saquito de té de cerámica pintado a mano con motivos florales o geométricos. Evita que el saquito moje la mesa y le da un toque sofisticado a tu momento de relax. Lavable, resistente y muy adorable.',                                 15.99,  95, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/efa8801e0d4378eadfdd6d5d1c7d41ef.jpg',   4.6,  8, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440009', '2026-05-10 09:30:00', 30),
(100, 'Medusa Kitchen Set Celeste',    'Set de 4 utensillos de cocina en celeste con ilustraciones de medusas flotantes: espátula de silicona, cucharón, pinza y espumadera. Mango de madera natural, colores que no destiñen. El mar en tu cocina.',                                  38.99,  55, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/19a5b2e506ad65831bc6728be5ebd363.jpg',   4.4,  8, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440009', '2026-05-12 10:00:00', 18)
ON CONFLICT (id) DO UPDATE SET seller_id = EXCLUDED.seller_id, status = EXCLUDED.status, created_at = EXCLUDED.created_at, reviews_count = EXCLUDED.reviews_count;

-- ─── 👗 Ropa y Moda — Teje & Diseña ─────────────────────────────────────────
INSERT INTO products (id, name, description, price, stock, main_image, rating, category_id, status, seller_id, created_at, reviews_count) VALUES
(101, 'Knit Hug Sweater Tejido',       'Sweater tejido artesanalmente en lana merino natural, suave y abrigado. Punto trenzado con detalles de cable, talle único oversized que abraza como un sueño. Cada pieza tarda 3 días en hacerse.',                                             69.99,  22, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/53048f409a35b0aad53fe86d7a939a6a.jpg',   4.8,  2, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440010', '2026-04-28 10:00:00', 24),
(102, 'Starry Night Bolso Tejido',     'Bolso tejido a mano inspirado en La Noche Estrellada de Van Gogh. Azul profundo con remolinos dorados en hilo metálico, interior forrado en tela y asa de cuero vegano. Arte portátil.',                                                         54.99,  30, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/474a3c7ebebab57235e5a38ba8c65e7e.jpg',   4.9,  2, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440010', '2026-04-30 11:00:00', 41),
(103, 'Monitos Crochet Bag',           'Bolso tejido en crochet con apliques de monitos coloridos bordados a mano. Cierre superior con cremallera, interior forrado y asa corta + tira larga desmontable. El bolso más alegre de toda la cuadra.',                                       44.99,  38, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/c047c1fdf1bdc70d8d76e0e95c9326f1.jpg',   4.7,  2, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440010', '2026-05-02 09:00:00', 19)
ON CONFLICT (id) DO UPDATE SET seller_id = EXCLUDED.seller_id, status = EXCLUDED.status, created_at = EXCLUDED.created_at, reviews_count = EXCLUDED.reviews_count;

-- ─── 🧴 Belleza y Cuidado Personal — Bella Natura / Cerámica Dulce ───────────
INSERT INTO products (id, name, description, price, stock, main_image, rating, category_id, status, seller_id, created_at, reviews_count) VALUES
(104, 'Rose Hand Soap Set',            'Set de 3 jabones de mano artesanales en tonos rosa suave. Glicerina vegetal de primera calidad, aceite de rosa mosqueta certificado y vitamina E. Sin parabenos, fragancia natural. Tu ritual de cuidado diario, redefinido.',                 24.99, 100, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/23153d3fbcc7f93463d964ef0a42e307.jpg',   4.7,  4, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440004', '2026-05-05 09:00:00', 29),
(105, 'Animalitos Porta Anteojos',     'Porta anteojos de cerámica artesanal con diseño de animalitos kawaii. Base estable, superficie suave que no raya los lentes. Elegí tu favorito al comprar: conejito, osito, gatito o zorrito.',                                                  19.99,  70, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/a6b3b2eecc67d338605270780cdf12d0.jpg',   4.6,  4, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440009', '2026-05-07 10:00:00', 22),
(106, 'Nube Bijou Organizer',          'Organizador de bijouterie en forma de nube blanca. Estructura de resina con 8 mini ganchos para collares, 6 compartimentos para aros y ranura para pulseras. Mantené tus joyas ordenadas con mucha onda.',                                       27.99,  55, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/1cff30c52077937c6b84c5496a93779f.jpg',   4.5,  4, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440010', '2026-05-09 09:30:00', 16)
ON CONFLICT (id) DO UPDATE SET seller_id = EXCLUDED.seller_id, status = EXCLUDED.status, created_at = EXCLUDED.created_at, reviews_count = EXCLUDED.reviews_count;

-- ─── 🖥️ Computación y Accesorios — KawaiiTech ───────────────────────────────
INSERT INTO products (id, name, description, price, stock, main_image, rating, category_id, status, seller_id, created_at, reviews_count) VALUES
(107, 'Knit Wrist Rest Teclado',       'Cojín de descanso de muñeca para teclado, tejido artesanalmente en algodón. Relleno de micropearlas memory foam, funda desmontable lavable a mano. Tu setup merece el accesorio más cómodo y con onda.',                                       22.99,  80, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/13f29ae1d5d2e51874c616cfed4c649c.jpg',   4.6,  7, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440012', '2026-05-03 10:00:00', 33),
(108, 'Whale Mouse Ergonómico',        'Mouse inalámbrico con diseño de ballena azul océano. Sensor óptico de 1600 DPI, 3 niveles ajustables, batería recargable vía USB-C con autonomía de 30 días. El compañero marino que tu escritorio necesitaba.',                               34.99,  65, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/284b289354a3fb80eb25743166fa9a5e.jpg',   4.7,  7, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440012', '2026-05-06 11:00:00', 51),
(109, 'Neko Joystick Stand',           'Porta joystick de cerámica con forma de gatito gris sentado. Base antideslizante de silicona, capacidad para 2 joysticks o controles. Para que tu setup gamer tenga la personalidad que siempre le faltó.',                                     24.99,  45, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/c383350b3c5c0f041014e250711aa64e.jpg',   4.8,  7, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440012', '2026-05-09 09:00:00', 28)
ON CONFLICT (id) DO UPDATE SET seller_id = EXCLUDED.seller_id, status = EXCLUDED.status, created_at = EXCLUDED.created_at, reviews_count = EXCLUDED.reviews_count;

-- ─── 📱 Electrónica y Tecnología — TecnoShop BA ─────────────────────────────
INSERT INTO products (id, name, description, price, stock, main_image, rating, category_id, status, seller_id, created_at, reviews_count) VALUES
(110, 'Canon PIXMA TR4720 Rosa',       'Impresora multifunción Canon edición color rosa: impresión, escaneo, copia y fax. WiFi integrado, compatible con Alexa y Google Assistant, impresión desde smartphone. El home office más aesthetic que puedas imaginar.',                      149.99,  20, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/213d80a1750e263249a72e326ef4bfd8.jpg',   4.5,  1, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440001', '2026-05-10 10:00:00', 17),
(111, 'PowerStrip Rosa 5 Tomas',       'Zapatilla eléctrica en rosa pastel con 5 tomas y 2 puertos USB integrados. Cable de 2 metros trenzado, protección contra sobretensión y fusible de seguridad. Porque hasta los cables y enchufes pueden tener onda.',                            22.99, 110, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/400f0a4c5264d6140ab4d45cf4e5f87a.jpg',   4.4,  1, 'ACTIVE', '550e8400-e29b-41d4-a716-446655440012', '2026-05-12 09:00:00', 23)
ON CONFLICT (id) DO UPDATE SET seller_id = EXCLUDED.seller_id, status = EXCLUDED.status, created_at = EXCLUDED.created_at, reviews_count = EXCLUDED.reviews_count;

-- ─── Imágenes de productos nuevos ───────────────────────────────────────────
INSERT INTO product_images (product_id, image_url) VALUES
(65,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/020d718f21c09294dd1ad11015492add.jpg'),
(66,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/09a1b5e6d6d72cc56c725b16c511e966.jpg'),
(67,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/20b5852a96c7c23fe5bd27e16d310f6c.jpg'),
(68,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/333aa0cc3f647beda6ddd9d41e0c17eb.jpg'),
(69,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/90ae8e8a51439765acc2f2ade1c5693e.jpg'),
(70,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/825b04a169872a387d4e29763c796980.jpg'),
(71,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/d1ef34c058bf9dbe8a9fd16baa878806.jpg'),
(72,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/279b890f0f6dafcf4b6e6129013983b6.jpg'),
(73,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/07a63cca1418081ca6e2cfdd38798f1a.jpg'),
(74,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/0bb8d12d392ab5a535db27512ea29a64.jpg'),
(75,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/1fa2c1cd243a3da91d84624e768c0d50.jpg'),
(76,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/81c93f7ad4801d49fbfb637772dd4d0a.jpg'),
(77,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/50c24bf8b1fcb463c8176334f9fc264e.jpg'),
(78,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/177045129635532e2e8664c6cbd9bdfb1561779f92_thumbnail_405x.webp'),
(79,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/59f1ab870af4fe97423947e3f07a2a00.jpg'),
(80,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/23e1478379c6f17739435ece9c519cc6.jpg'),
(81,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/68fb9229c91a85e564bc085010230faf.jpg'),
(82,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/e335838b1217d9a06110ebe56f5e9b70.jpg'),
(83,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/29cf0d3257686520849ffde6b870e99e.jpg'),
(84,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/924849ebc2bd6fdca0d0509125b74c08.jpg'),
(85,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/bd40e96b200eac055776b911566b20a0.jpg'),
(86,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/380504bd143513801507d42f3ed10f67.jpg'),
(87,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/2ea2b6a907655563e0e2d304cefdb5d6.jpg'),
(88,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/3db841a2c43b6f791c6bda5f197897f0.jpg'),
(89,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/6b764e2c3df6b07e4ae41f7075804748.jpg'),
(90,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/070b832039b1ff59e3463177bb8a72c9.jpg'),
(91,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/35e3ebc11de4c278df7dec792a150b14.jpg'),
(92,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/92e55f6d69f45905670f20204d9b6995.jpg'),
(93,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/f25d2f692b62456133df2386f6f0d5f6.jpg'),
(94,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/f832d9602a144ed710243c245009313e.jpg'),
(95,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/28f63a302d13e79c68e9b9fce8e16bbc.jpg'),
(96,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/6a5dcd0660c63b505ca9e65abae6d38c(1).jpg'),
(97,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/a2bc6f0673ba34ba5d6bab1ba04e7f7a.jpg'),
(98,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/bc8d9bb9707f7f8c7ae099823351913a.jpg'),
(99,  'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/efa8801e0d4378eadfdd6d5d1c7d41ef.jpg'),
(100, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/19a5b2e506ad65831bc6728be5ebd363.jpg'),
(101, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/53048f409a35b0aad53fe86d7a939a6a.jpg'),
(102, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/474a3c7ebebab57235e5a38ba8c65e7e.jpg'),
(103, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/c047c1fdf1bdc70d8d76e0e95c9326f1.jpg'),
(104, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/23153d3fbcc7f93463d964ef0a42e307.jpg'),
(105, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/a6b3b2eecc67d338605270780cdf12d0.jpg'),
(106, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/1cff30c52077937c6b84c5496a93779f.jpg'),
(107, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/13f29ae1d5d2e51874c616cfed4c649c.jpg'),
(108, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/284b289354a3fb80eb25743166fa9a5e.jpg'),
(109, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/c383350b3c5c0f041014e250711aa64e.jpg'),
-- Impresora rosa Canon: segunda imagen del mismo producto
(110, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/213d80a1750e263249a72e326ef4bfd8.jpg'),
(110, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/adeed3a037ed2353de4a455553bc8efe(1).jpg'),
(111, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial1/400f0a4c5264d6140ab4d45cf4e5f87a.jpg')
ON CONFLICT DO NOTHING;

SELECT setval('products_id_seq', (SELECT COALESCE(MAX(id), 1) FROM products), true);

-- ─── Reseñas de productos nuevos (órdenes 121–135) ──────────────────────────
INSERT INTO product_reviews (product_id, order_id, buyer_id, score, comment, created_at)
VALUES
    -- Laura reseña AstroPet Mochila Burbuja (orden 121)
    (68, '11111111-1111-1111-1111-111111111121',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Mi chihuahua viaja adentro mirando todo. La cúpula es resistente y ventila muy bien. La gente en la calle se vuelve loca de amor.',
     '2026-06-01 11:00:00'),

    -- Laura reseña Correa Osito Kawaii (orden 121)
    (70, '11111111-1111-1111-1111-111111111121',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'El osito del gancho es muy tierno y la correa aguanta perfectamente a mi perro de 8 kg. Ya me la pidieron copiada dos vecinas.',
     '2026-06-01 11:30:00'),

    -- Carlos reseña Iron Punch Bolsa de Boxeo (orden 122)
    (76, '11111111-1111-1111-1111-111111111122',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Sólida, bien rellena y la cadena no chirría. La tengo colgada en el garage hace un mes y no perdió forma. Muy buena compra.',
     '2026-06-02 18:00:00'),

    -- Carlos reseña VeloCycle Home (orden 122)
    (77, '11111111-1111-1111-1111-111111111122',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'Silenciosa y estable, perfecto para el departamento. La pantalla LED es básica pero cumple. Le saco una estrella porque el manual viene solo en inglés.',
     '2026-06-02 19:00:00'),

    -- María reseña Alfombra Jardín Violeta (orden 123)
    (78, '11111111-1111-1111-1111-111111111123',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'El color es exactamente el de la foto. La base antideslizante es un golazo, no se mueve ni un centímetro. Quedó hermosa en el cuarto.',
     '2026-06-03 10:00:00'),

    -- María reseña Sábanas Floral Violeta (orden 123)
    (79, '11111111-1111-1111-1111-111111111123',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Suavísimas y el estampado no perdió color después de tres lavados. Combinan perfectamente con la alfombra que compré en el mismo pedido.',
     '2026-06-03 10:30:00'),

    -- Laura reseña Calendario Eterno Kiki's Cat (orden 124)
    (90, '11111111-1111-1111-1111-111111111124',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Llegó envuelto con tanto amor que casi no lo quería abrir. El pintado es increíblemente prolijo, lo tengo en el escritorio y no paro de mirarlo.',
     '2026-06-04 09:00:00'),

    -- Laura reseña Calendario Snoopy (orden 124)
    (92, '11111111-1111-1111-1111-111111111124',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Lo compré para regalar y terminé quedándomelo. El Snoopy es adorable y la cerámica se siente muy resistente. Calidad artesanal de verdad.',
     '2026-06-04 09:30:00'),

    -- Carlos reseña Tea Party Set Cerámica (orden 125)
    (96, '11111111-1111-1111-1111-111111111125',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'La tetera conserva el calor un montón y el set completo es una obra de arte. Mi novia se lo quiso robar en el momento que lo vio.',
     '2026-06-05 08:30:00'),

    -- Carlos reseña Tea Rest Saquito (orden 125)
    (99, '11111111-1111-1111-1111-111111111125',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'Muy lindo y funcional. Le doy 4 porque es un poco más chico de lo que esperaba, pero cumple su función y queda hermoso en la mesa.',
     '2026-06-05 09:00:00'),

    -- María reseña Starry Night Bolso Tejido (orden 126)
    (102, '11111111-1111-1111-1111-111111111126',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Es una obra de arte que llevás con vos. El interior forrado es un detalle que marca la diferencia. Lo llevo a todos lados y siempre me preguntan dónde lo compré.',
     '2026-06-06 11:00:00'),

    -- María reseña Knit Hug Sweater (orden 126)
    (101, '11111111-1111-1111-1111-111111111126',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'La lana es increíblemente suave, no pica para nada. El talle oversized queda perfecto para usar con leggins o jeans. Ya lo lavé a mano y no se deformó.',
     '2026-06-06 11:30:00'),

    -- Laura reseña Canon PIXMA Rosa (orden 127)
    (110, '11111111-1111-1111-1111-111111111127',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Imprime perfecto desde el celular por WiFi y el color rosa es más lindo en persona que en la foto. El home office nunca había sido tan bonito.',
     '2026-06-07 10:00:00'),

    -- Carlos reseña Whale Mouse Ergonómico (orden 128)
    (108, '11111111-1111-1111-1111-111111111128',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Conexión estable, el DPI es suave y la ballena es demasiado tierna. La batería dura semanas. Es el único mouse que uso ahora.',
     '2026-06-08 09:00:00'),

    -- Carlos reseña Knit Wrist Rest (orden 128)
    (107, '11111111-1111-1111-1111-111111111128',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'Muy cómodo para largas jornadas de escritura. La funda lavable es un gran plus. Le saco una estrella porque tardó un poco más en llegar de lo estimado.',
     '2026-06-08 09:30:00'),

    -- María reseña Sausage Dog Bowl (orden 129)
    (72, '11111111-1111-1111-1111-111111111129',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Mi dachshund come en su bowl de dachshund. La base de silicona no se mueve ni cuando el flaco come rápido. Calidad de cerámica muy buena.',
     '2026-06-09 08:00:00'),

    -- María reseña Happy Paws Correa Celeste (orden 129)
    (71, '11111111-1111-1111-1111-111111111129',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     4, 'Muy suave y el celeste es muy lindo. La agarradera acolchada se agradece en paseos largos. El cierre podría ser un poco más robusto.',
     '2026-06-09 08:30:00'),

    -- Laura reseña Puff Snorlax XL (orden 130)
    (80, '11111111-1111-1111-1111-111111111130',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Tuve que pedir permiso para sentarme porque mi gato lo adoptó al instante. La tela peluche es suavísima y mantiene la forma. Vale cada peso.',
     '2026-06-10 20:00:00'),

    -- Carlos reseña Neko Joystick Stand (orden 131)
    (109, '11111111-1111-1111-1111-111111111131',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'El gatito es demasiado tierno y sostiene los joysticks perfectamente. Todos los que vienen a jugar me preguntan dónde lo compré. Setup +10 en personalidad.',
     '2026-06-11 15:00:00'),

    -- María reseña Nube Bijou Organizer (orden 132)
    (106, '11111111-1111-1111-1111-111111111132',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Por fin tengo los collares sin enredarse. Los ganchos tienen el largo justo y los compartimentos de aros son perfectos. Lindo y muy funcional.',
     '2026-06-12 09:00:00'),

    -- Laura reseña Rose Hand Soap Set (orden 133)
    (104, '11111111-1111-1111-1111-111111111133',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'El aroma a rosa mosqueta es delicado y no artificial. Después de usarlos tengo las manos suaves sin necesitar crema. Los volvería a comprar mil veces.',
     '2026-06-13 08:00:00'),

    -- Carlos reseña Portátazas Vintage (orden 134)
    (85, '11111111-1111-1111-1111-111111111134',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'Le da un ambiente muy cálido a la cocina. La madera es sólida y los ganchos aguantan bien el peso. Le doy 4 porque el tono de la madera es un poco más claro que en la foto.',
     '2026-06-14 10:00:00'),

    -- Carlos reseña Torre Organizadora Lavaropa (orden 134)
    (84, '11111111-1111-1111-1111-111111111134',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Aproveché un espacio que tenía muerto hace años. Los cajones deslizan suave y tiene mucho más lugar de lo que parece. Muy recomendable.',
     '2026-06-14 10:30:00'),

    -- María reseña Medusa Kitchen Set (orden 135)
    (100, '11111111-1111-1111-1111-111111111135',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Las medusas son una idea hermosa y los utensillos son de buena calidad. El mango de madera es cómodo y el color celeste no desteñió nada con el uso. Cocinar con estilo.',
     '2026-06-15 19:00:00'),

    -- Laura reseña Pearl Dumbbells Blancas (orden 136)
    (74, '11111111-1111-1111-1111-111111111136',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Por fin unas mancuernas que no arruinan la estética del cuarto. El neoprene no resbala ni aunque estés sudada. Las uso todos los días.',
     '2026-06-16 07:30:00'),

    -- María reseña Chicarita Suculenta Deco (orden 136)
    (86, '11111111-1111-1111-1111-111111111136',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'La puse en el baño y todo el mundo piensa que es real. No necesita ningún cuidado y alegra cualquier rincón. La maceta pintada es un encanto.',
     '2026-06-16 10:00:00'),

    -- Carlos reseña Calendario Animal Cute (orden 137)
    (93, '11111111-1111-1111-1111-111111111137',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Pedí el sapito y llegó pintado de manera impecable. Cada pieza encaja perfectamente. Lo regalé y la persona lloró de la ternura. 10/10.',
     '2026-06-17 09:00:00'),

    -- Laura reseña Ovejita Porta Control (orden 138)
    (89, '11111111-1111-1111-1111-111111111138',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Fin del caos de controles remotos en mi casa. La ovejita es esponjosa, linda y tiene exactamente el tamaño justo. Hasta mi marido la ama.',
     '2026-06-17 20:00:00'),

    -- María reseña Monitos Crochet Bag (orden 139)
    (103, '11111111-1111-1111-1111-111111111139',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Los monitos tienen una expresión adorable y el tejido es muy resistente. Lo uso a diario y no perdió forma. La tira larga es muy práctica.',
     '2026-06-18 11:00:00'),

    -- Carlos reseña PowerStrip Rosa (orden 140)
    (111, '11111111-1111-1111-1111-111111111140',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'El rosa es muy lindo y los puertos USB son un plus enorme. El cable de 2 metros llega perfecto. Le saco una estrella porque esperaba que fuera un poco más largo.',
     '2026-06-18 14:00:00'),

    -- Laura reseña Fry & Dip Apoyo Cerámica (orden 140)
    (98, '11111111-1111-1111-1111-111111111140',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Es la cosa más práctica y adorable que tengo en la cocina. Los dos compartimentos son del tamaño exacto. Todo el mundo me pregunta de dónde lo saqué.',
     '2026-06-18 15:00:00'),

    -- María reseña Woof Walk Bag Marrón (orden 141)
    (65, '11111111-1111-1111-1111-111111111141',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Llevo a mi beagle cargado cuando se cansa en los paseos largos. El cuero vegano se ve de muy buena calidad y el cierre es súper seguro. Muy contenta con la compra.',
     '2026-06-19 09:00:00'),

    -- Carlos reseña Mini Paws Bolsito (orden 141)
    (66, '11111111-1111-1111-1111-111111111141',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'Perfecto para el gato de mi novia. Es compacto, liviano y la tela interior es muy suave. Le saco una estrella porque el cierre podría ser un poco más grande para las manos.',
     '2026-06-19 09:30:00'),

    -- Laura reseña Explorer Carrier Canino (orden 142)
    (67, '11111111-1111-1111-1111-111111111142',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'La base rígida hace toda la diferencia, mi perro viaja cómodo y sin rebotar. Las mallas laterales ventilan muy bien incluso en días de calor. Lo recomiendo sin dudar.',
     '2026-06-19 11:00:00'),

    -- María reseña Trail Rider Mochila Canina (orden 142)
    (69, '11111111-1111-1111-1111-111111111142',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Fui a la costanera con mi perro adentro y la mochila aguantó todo el día sin ningún problema. La tela repele el agua y las cremalleras son de muy buena calidad.',
     '2026-06-19 12:00:00'),

    -- Carlos reseña Speed Rope Blanca Pro (orden 143)
    (73, '11111111-1111-1111-1111-111111111143',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Los rodamientos hacen que la soga gire suavísimo, notás la diferencia respecto a las baratas. El largo se ajusta fácil y los mangos no resbalan aunque estés transpirado.',
     '2026-06-19 18:00:00'),

    -- Laura reseña Iron Gray Rack + Mancuernas (orden 143)
    (75, '11111111-1111-1111-1111-111111111143',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'El rack es muy robusto y ocupa poco espacio. Las mancuernas hexagonales no ruedan y el acabado es impecable. Mi home gym nunca quedó tan organizado.',
     '2026-06-19 18:30:00'),

    -- María reseña Ganchos Gatito para Ropa (orden 144)
    (81, '11111111-1111-1111-1111-111111111144',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Son adorables y funcionales. No marcan la ropa para nada y el plástico se siente resistente. Los compré para mí y terminé regalando dos juegos más.',
     '2026-06-20 08:00:00'),

    -- Carlos reseña Ranita Porta Esponja (orden 144)
    (82, '11111111-1111-1111-1111-111111111144',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'La ranita quedó perfecta al lado del lavaplatos. La cerámica se lava fácil y no absorbe olores. Mi cocina ganó mucho carácter con este detalle.',
     '2026-06-20 09:00:00'),

    -- Laura reseña Estante Organizador Cocina (orden 145)
    (83, '11111111-1111-1111-1111-111111111145',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     4, 'Muy práctico y el armado fue en menos de 10 minutos sin herramientas. Los estantes son sólidos. Le doy 4 porque la altura entre niveles podría ser un poco mayor.',
     '2026-06-20 10:00:00'),

    -- María reseña Rollie Ovejitas Deco (orden 145)
    (87, '11111111-1111-1111-1111-111111111145',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     4, 'Las ovejitas son muy tiernas y el papel es suave. Le doy 4 porque esperaba que el diseño fuera un poco más grande en el rollo, pero el baño quedó muy cute igual.',
     '2026-06-20 11:00:00'),

    -- Carlos reseña Rollie Perrito Deco Cocina (orden 146)
    (88, '11111111-1111-1111-1111-111111111146',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Mi novia me mandó a comprar papel de cocina y volví con este. Primer vez que alguien se alegra de ver un rollo de papel. El diseño es muy lindo y absorbe bien.',
     '2026-06-20 12:00:00'),

    -- Laura reseña Calendario Sol de Cerámica (orden 146)
    (91, '11111111-1111-1111-1111-111111111146',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Es tan bonito que da lástima cambiarle la fecha. El terracota y el dorado combinan perfecto con mi escritorio de madera. Sin duda el regalo más hermoso que me hice.',
     '2026-06-20 14:00:00'),

    -- María reseña Calendario Pokémon Fan Edition (orden 147)
    (94, '11111111-1111-1111-1111-111111111147',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Pedí el Gengar y llegó pintado con un nivel de detalle increíble. Lo tengo en el escritorio del trabajo y es el tema de conversación de toda la oficina.',
     '2026-06-20 15:30:00'),

    -- Carlos reseña Toast Art Soporte Cerámica (orden 147)
    (95, '11111111-1111-1111-1111-111111111147',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Pedí el de flores y es exactamente lo que esperaba. Las tostadas ya no manchan la mesada y el desayuno se convirtió en un momento mucho más lindo.',
     '2026-06-20 16:00:00'),

    -- Laura reseña Violeta Full Vajilla (orden 148)
    (97, '11111111-1111-1111-1111-111111111148',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'La vajilla completa es espectacular. El violeta es profundo y uniforme en todas las piezas. Ya pasó tres veces por el lavavajillas y no perdió ni el color ni el esmalte.',
     '2026-06-21 10:00:00'),

    -- María reseña Animalitos Porta Anteojos (orden 148)
    (105, '11111111-1111-1111-1111-111111111148',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Pedí el conejito y es lo más adorable que tengo en el escritorio. La superficie es suave y no raya los lentes para nada. Un detalle que hace la diferencia.',
     '2026-06-21 11:00:00'),

    -- Carlos reseña Remera Polo Clasica (orden 149)
    (24, '11111111-1111-1111-1111-111111111149',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'El algodón piqué es de muy buena calidad y no perdió la forma después de varios lavados. El color es fiel a la foto. Le saco una estrella porque encogió un poco la primera vez.',
     '2026-06-21 09:00:00'),

    -- Laura reseña Pantalon Chino Slim Fit (orden 149)
    (25, '11111111-1111-1111-1111-111111111149',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'La tela stretch es comodísima para trabajar todo el día. El corte slim fit queda muy prolijo sin apretar. Ya compré en dos colores más.',
     '2026-06-21 09:30:00'),

    -- María reseña Set de Pinceles de Maquillaje (orden 150)
    (30, '11111111-1111-1111-1111-111111111150',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Las cerdas son muy suaves y no pierden pelo con el uso. El estuche es un plus enorme para guardarlos. Se lavan fácil y secan rápido. Calidad profesional a buen precio.',
     '2026-06-21 10:30:00'),

    -- Carlos reseña Organizador de Escritorio Bambu (orden 150)
    (28, '11111111-1111-1111-1111-111111111150',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'El bambu es sólido y el acabado muy prolijo. Tiene más compartimentos de lo que se ve en la foto. Le saco una estrella porque uno de los bordes llegó con una pequeña marca.',
     '2026-06-21 11:30:00'),

    -- Laura reseña Webcam Full HD 1080p (orden 151)
    (41, '11111111-1111-1111-1111-111111111151',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Se ve muy bien en las llamadas de Zoom, el enfoque automático funciona perfecto aunque me mueva. El microfono capta la voz sin mucho ruido de fondo. Muy buena relación precio-calidad.',
     '2026-06-21 13:00:00'),

    -- María reseña Correa Retractil 5 Metros (orden 151)
    (50, '11111111-1111-1111-1111-111111111151',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     4, 'El mecanismo retráctil funciona suave y el freno responde al instante. La cinta reflectante es un golazo para paseos nocturnos. Le saco una estrella porque el botón de freno es un poco duro.',
     '2026-06-21 14:00:00'),

    -- Carlos reseña Compresor de Aire Portatil 12V (orden 152)
    (46, '11111111-1111-1111-1111-111111111152',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Lo probé en los 4 neumáticos y el corte automático de presión funciona exactamente como dice. La pantalla digital es clara y el cable de 3 metros llega cómodo a cualquier rueda.',
     '2026-06-21 16:00:00'),

    -- Laura reseña Microondas Inteligente (orden 152)
    (16, '11111111-1111-1111-1111-111111111152',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     4, 'La app funciona bien para programar desde el celular. El sensor de humedad hace que la comida no quede reseca. Le doy 4 porque la configuración del wifi inicial fue un poco complicada.',
     '2026-06-21 17:00:00'),

    -- María reseña Kit de Herramientas 20 piezas (orden 153)
    (17, '11111111-1111-1111-1111-111111111153',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Todo lo que necesitás para el mantenimiento básico está en el estuche. Las herramientas se sienten sólidas y el estuche cierra bien. Ideal para tener en casa.',
     '2026-06-21 18:00:00'),

    -- Carlos reseña Alfombras Universales para Auto (orden 153)
    (47, '11111111-1111-1111-1111-111111111153',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'Se ajustan bien al piso del auto y no se deslizan para nada. Se lavan con una manga y quedan como nuevas. Le doy 4 porque la trasera llegó con un recorte que no coincidía exacto.',
     '2026-06-21 19:00:00'),

    -- Laura reseña Tablet Samsung Galaxy Tab A9 (orden 154)
    (22, '11111111-1111-1111-1111-111111111154',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Fluida para ver series, navegar y hacer videollamadas. La pantalla tiene buenos colores aunque en el sol cuesta un poco verla. Muy recomendable para uso diario.',
     '2026-06-22 08:00:00'),

    -- María reseña Muneca Interactiva con Accesorios (orden 154)
    (34, '11111111-1111-1111-1111-111111111154',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Mi hija de 4 años no la suelta. Habla, canta y los accesorios son de muy buena calidad. Llegó con todas las pilas puestas, un detalle que se agradece muchísimo.',
     '2026-06-22 09:00:00'),

    -- Carlos reseña Bicicleta de Montana (orden 155)
    (37, '11111111-1111-1111-1111-111111111155',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'El cambio de velocidades es muy suave y los frenos de disco responden perfecto en bajada. El armado lleva como 40 minutos pero vale cada minuto. Excelente bicicleta para el precio.',
     '2026-06-22 10:00:00'),

    -- Laura reseña Cafetera de Capsulas Express (orden 155)
    (43, '11111111-1111-1111-1111-111111111155',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Ya la tengo hace dos meses y no falló ni una sola vez. La crema del café es perfecta y calienta en menos de 30 segundos como dice. La recomiendo a todo el mundo.',
     '2026-06-22 10:30:00'),

    -- ── Puff Snorlax XL (80): producto estrella, 3 reseñas ──────────────────
    (80, '11111111-1111-1111-1111-111111111156',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Lo compré creyendo que iba a ser una pavada y me tiene dormido todas las noches en el living. La tela peluche no pierde pelo y aguanta el peso sin problema. Obra maestra.',
     '2026-06-10 21:00:00'),
    (80, '11111111-1111-1111-1111-111111111157',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Es enorme, suavísimo y el Snorlax quedó perfecto en el cuarto de mi hijo. La funda se saca y lava sin perder la forma. Fue el regalo de cumpleaños más celebrado de la historia.',
     '2026-06-11 10:00:00'),

    -- ── AstroPet Mochila Burbuja (68): 3 reseñas ────────────────────────────
    (68, '11111111-1111-1111-1111-111111111156',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Mi gato viaja adentro de la burbuja mirando todo el barrio como si fuera el rey del mundo. La ventilación es excelente y no protesta para nada. Mejor compra del año.',
     '2026-06-01 14:00:00'),
    (68, '11111111-1111-1111-1111-111111111158',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Las correas ergonómicas hacen que no se sienta nada el peso del perro. La cúpula es sólida y transparente, no se raya. En el parque todo el mundo para a fotografiarla.',
     '2026-06-02 10:00:00'),

    -- ── Calendario Animal Cute Cerámica (93): 3 reseñas ─────────────────────
    (93, '11111111-1111-1111-1111-111111111157',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Pedí el pingüino y es absolutamente perfecto. El pintado a mano se nota en cada detalle. Ya lo compré tres veces más para regalar y cada uno fue un éxito total.',
     '2026-06-17 10:00:00'),
    (93, '11111111-1111-1111-1111-111111111158',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'El patito que pedí llegó con un embalaje hermoso. La cerámica es resistente y el mecanismo de las piezas encaja perfecto. Es mi objeto favorito del escritorio sin dudas.',
     '2026-06-18 09:00:00'),

    -- ── Starry Night Bolso Tejido (102): 3 reseñas ──────────────────────────
    (102, '11111111-1111-1111-1111-111111111159',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'El hilo metálico dorado brilla en la luz de manera increíble. Lo llevé a una cena y fue el centro de atención de la noche. El interior forrado protege todo muy bien.',
     '2026-06-07 11:00:00'),
    (102, '11111111-1111-1111-1111-111111111160',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Lo compré para regalarle a mi hermana y cuando llegó casi me lo quedo yo. La calidad del tejido es impresionante para el precio. El asa de cuero vegano es un detalle muy fino.',
     '2026-06-08 12:00:00'),

    -- ── Whale Mouse Ergonómico (108): 3 reseñas ─────────────────────────────
    (108, '11111111-1111-1111-1111-111111111159',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'El diseño de ballena es una genialidad pero lo que más me sorprendió es lo cómodo que es ergonómicamente. Llevo horas trabajando y la muñeca no se cansa. Perfecto.',
     '2026-06-09 10:00:00'),
    (108, '11111111-1111-1111-1111-111111111160',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     4, 'Muy lindo y preciso. El DPI ajustable es una ventaja enorme. Le doy 4 porque el dongle USB ocupa un puerto que a veces necesito para otra cosa, pero es un detalle menor.',
     '2026-06-10 09:00:00'),

    -- ── Ovejita Porta Control Remoto (89): 3 reseñas ────────────────────────
    (89, '11111111-1111-1111-1111-111111111161',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Le regalé una a mi mamá y me pidió dos más para las hermanas. Resuelve el caos de controles con mucha ternura. La lana acrílica es suave y fácil de lavar a mano.',
     '2026-06-18 21:00:00'),
    (89, '11111111-1111-1111-1111-111111111162',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'La ovejita tiene una cara adorable y los bolsillos laterales son del tamaño exacto para los controles. Nunca más busco el control entre los almohadones del sillón.',
     '2026-06-19 20:00:00'),

    -- ── Neko Joystick Stand (109): 3 reseñas ────────────────────────────────
    (109, '11111111-1111-1111-1111-111111111161',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'La base de silicona no se mueve ni un milímetro aunque apoye los joysticks de golpe. El gatito es una obra de arte en cerámica. Mi setup gamer nunca fue tan adorable.',
     '2026-06-12 16:00:00'),
    (109, '11111111-1111-1111-1111-111111111162',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Lo vi en redes y no pude resistirlo. Llegó muy bien embalado y la cerámica se siente de muy buena calidad. El gatito tiene una expresión tierna que me hace sonreír cada vez que lo miro.',
     '2026-06-13 15:00:00'),

    -- ── Knit Hug Sweater (101): 3 reseñas ───────────────────────────────────
    (101, '11111111-1111-1111-1111-111111111163',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'La lana merino no pica absolutamente nada. Lo lavé a mano siguiendo las instrucciones y quedó perfecto. Cada vez que lo uso alguien me pregunta dónde lo conseguí.',
     '2026-06-07 09:00:00'),
    (101, '11111111-1111-1111-1111-111111111164',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'El trenzado es impecable, se ve el trabajo artesanal en cada punto. Talle único oversized muy bien pensado, queda bien en distintos cuerpos. Vale completamente el precio.',
     '2026-06-08 10:00:00'),

    -- ── Chicarita Suculenta Deco (86): 3 reseñas ────────────────────────────
    (86, '11111111-1111-1111-1111-111111111163',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Compré 4 para distintos ambientes de la casa. La maceta de cerámica pintada es muy linda y la planta se ve realista. Precio muy accesible para lo que es.',
     '2026-06-17 11:00:00'),
    (86, '11111111-1111-1111-1111-111111111164',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'La planta artificial se ve muy real y la maceta es de cerámica de verdad. Le doy 4 porque esperaba que fuera un poco más grande, pero en el escritorio queda perfecta igual.',
     '2026-06-18 12:00:00'),

    -- ── Iron Gray Rack + Mancuernas (75): 3 reseñas ─────────────────────────
    (75, '11111111-1111-1111-1111-111111111165',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'El rack es super robusto y no ocupa nada de espacio. Las mancuernas hexagonales no ruedan y el acabado en gris mate es muy premium. Mi home gym quedó como de revista.',
     '2026-06-20 07:30:00'),
    (75, '11111111-1111-1111-1111-111111111166',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Llegó muy bien embalado y el armado del rack fue en 15 minutos. La variedad de pesos cubre todos los ejercicios que necesito. Una inversión que vale muchísimo la pena.',
     '2026-06-20 08:30:00'),

    -- ── Sausage Dog Snack Bowl (72): 3 reseñas ──────────────────────────────
    (72, '11111111-1111-1111-1111-111111111165',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'El bowl con forma de perro salchicha es la cosa más tierna que existe. La base de silicona no se mueve y la cerámica se lava perfecto en el lavavajillas. Genial.',
     '2026-06-10 08:30:00'),
    (72, '11111111-1111-1111-1111-111111111166',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Lo compré por el diseño y resultó ser de muy buena calidad también. La cerámica es sólida y pesada, no se vuelca fácil. Mi perro come en él todos los días.',
     '2026-06-11 09:00:00'),

    -- ── Tea Party Set Cerámica (96): 3 reseñas ──────────────────────────────
    (96, '11111111-1111-1111-1111-111111111167',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'El set llegó perfectamente embalado sin un raspón. La tetera tiene un pico muy bien diseñado que no gotea. El rojo y blanco es aún más lindo en persona que en la foto.',
     '2026-06-06 08:00:00'),
    (96, '11111111-1111-1111-1111-111111111168',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Lo uso todas las tardes y se convirtió en mi ritual favorito. La cerámica mantiene el calor mucho más que el vidrio. El azucarera tiene la tapa justa, no se cae.',
     '2026-06-07 16:00:00'),

    -- ── Woof Walk Bag Marrón (65): 3 reseñas ────────────────────────────────
    (65, '11111111-1111-1111-1111-111111111167',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'Llevo a mi maltés en este bolso para caminar y es comodísimo para los dos. La ventilación lateral funciona perfecto y el cierre nunca se abrió solo. Muy recomendable.',
     '2026-06-01 10:00:00'),
    (65, '11111111-1111-1111-1111-111111111168',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'El cuero vegano tiene una textura muy premium, no parece sintético para nada. El bolso aguanta bien el peso de 4 kg sin deformarse. Compra más que recomendada.',
     '2026-06-02 11:00:00'),

    -- ── Calendario Kiki's Cat (90): 3 reseñas ───────────────────────────────
    (90, '11111111-1111-1111-1111-111111111169',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     5, 'Soy fanático de Kiki y este calendario es el mejor objeto de mi escritorio. El pintado a mano es increíblemente detallado. Lo tengo hace meses y siempre me pone de buen humor.',
     '2026-06-05 10:00:00'),
    (90, '11111111-1111-1111-1111-111111111170',
     'cccccccc-cccc-cccc-cccc-cccccccccc03',
     5, 'Lo compré como regalo y la persona lloró de la emoción. Las piezas encajan perfectamente y la cerámica se siente muy sólida. Sin dudas el regalo más especial que di este año.',
     '2026-06-06 09:00:00'),

    -- ── Monitos Crochet Bag (103): 3 reseñas ────────────────────────────────
    (103, '11111111-1111-1111-1111-111111111169',
     'cccccccc-cccc-cccc-cccc-cccccccccc01',
     5, 'El crochet es de muy buena calidad y los monitos bordados son una preciosura. Lo uso para ir al trabajo todos los días y aguanta perfecto. La tira larga es muy cómoda.',
     '2026-06-19 10:00:00'),
    (103, '11111111-1111-1111-1111-111111111170',
     'cccccccc-cccc-cccc-cccc-cccccccccc02',
     4, 'El tejido es resistente y los colores muy vivos. La cremallera funciona bien. Le doy 4 porque quisiera que el interior también estuviera forrado, pero para el precio está muy bien.',
     '2026-06-20 13:00:00')

ON CONFLICT (product_id, order_id) DO NOTHING;
