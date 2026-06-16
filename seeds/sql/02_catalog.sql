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
INSERT INTO products (id, name, description, price, stock, main_image, rating, category_id, is_active, seller_id, created_at, reviews_count) VALUES
(1, 'Samsung Galaxy A54', 'Smartphone con pantalla AMOLED de 6.4 pulgadas, 128GB almacenamiento, cámara de 50MP', 299.99, 45, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Samsung%20Galaxy%20A54.png', 4.5, 1, true, '550e8400-e29b-41d4-a716-446655440001', '2026-04-30 10:00:00', 120),
(2, 'Auriculares Sony WH-CH720', 'Auriculares inalámbricos con cancelación de ruido, batería 35 horas, conector 3.5mm', 79.99, 120, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Auriculares%20Sony%20WH-CH720.jpg', 4.3, 1, true, '550e8400-e29b-41d4-a716-446655440001', '2026-04-29 11:00:00', 80),
(3, 'Camiseta Básica Premium - DISCONTINUED', 'Producto descontinuado - no disponible', 24.99, 0, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Camiseta%20Basica%20Premium.webp', 4.6, 2, false, '550e8400-e29b-41d4-a716-446655440002', '2026-04-10 09:00:00', 5),
(4, 'Zapatillas Running Pro', 'Zapatillas deportivas con tecnología de amortiguación, para hombre y mujer', 89.99, 80, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Zapatillas%20Running%20Pro.webp', 4.4, 2, true, '550e8400-e29b-41d4-a716-446655440002', '2026-04-28 12:00:00', 95),
(5, 'Lámpara LED de Piso', 'Lámpara moderna con control remoto, 3 temperaturas de color, bajo consumo energético', 45.99, 65, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Lampara%20LED%20de%20Piso.jpg', 4.2, 3, true, '550e8400-e29b-41d4-a716-446655440003', '2026-04-20 14:00:00', 30),
(6, 'Almohada Premium Memory Foam', 'Almohada ergonómica con viscoelástica de alta densidad, funda removible', 59.99, 150, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Almohada%20Premium%20Memory%20Foam.jpg', 4.7, 3, true, '550e8400-e29b-41d4-a716-446655440003', '2026-04-25 08:00:00', 200),
(7, 'Crema Facial Hidratante', 'Crema hidratante con vitamina E y ácido hialurónico, para todo tipo de piel', 34.99, 180, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Crema%20Facial%20Hidratante.webp', 4.5, 4, true, '550e8400-e29b-41d4-a716-446655440004', '2026-04-18 09:30:00', 50),
(8, 'Perfume Essence', 'Eau de Parfum de 100ml, aroma floral y fresco, larga duración', 49.99, 95, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Perfume%20Essence.jpg', 4.1, 4, true, '550e8400-e29b-41d4-a716-446655440004', '2026-04-15 10:15:00', 12),
(9, 'Juego de Construcción 1000 piezas', 'Set de bloques de construcción educativos para niños +3 años, estimula creatividad', 39.99, 110, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Juego%20de%20ConstrucciOn%201000%20piezas.webp', 4.8, 5, true, '550e8400-e29b-41d4-a716-446655440005', '2026-04-05 16:00:00', 300),
(10, 'Andador para Bebé', 'Andador interactivo con actividades, música y luces, seguro para bebés +6 meses', 64.99, 55, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Andador%20para%20Bebe.png', 4.3, 5, true, '550e8400-e29b-41d4-a716-446655440005', '2026-04-22 13:00:00', 40),
(11, 'Mancuernas Ajustables 20kg', 'Par de mancuernas ajustables de 20kg total, con sistema de ajuste rápido', 69.99, 70, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Mancuernas%20Ajustables%2020kg.webp', 4.6, 6, true, '550e8400-e29b-41d4-a716-446655440006', '2026-03-30 09:00:00', 60),
(12, 'Colchoneta Yoga Premium', 'Colchoneta de yoga antideslizante, 6mm grosor, material eco-friendly', 44.99, 140, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Colchoneta%20Yoga%20Premium.webp', 4.4, 6, true, '550e8400-e29b-41d4-a716-446655440006', '2026-04-26 07:45:00', 25),
(13, 'Teclado Mecánico RGB', 'Teclado gaming mecánico con iluminación RGB, switches personalizables', 89.99, 85, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Teclado%20Mecanico%20RGB.jpg', 4.7, 7, true, '550e8400-e29b-41d4-a716-446655440001', '2026-04-12 18:00:00', 150),
(14, 'Mouse Inalámbrico Pro', 'Mouse de precisión con 3 niveles DPI ajustables, batería 12 meses', 34.99, 160, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Mouse%20Inalambrico%20Pro.png', 4.2, 7, true, '550e8400-e29b-41d4-a716-446655440001', '2026-04-08 08:30:00', 20),
(15, 'Licuadora Digital 2000W', 'Licuadora potente con 8 velocidades, jarra de vidrio y vaso para llevar', 99.99, 48, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Licuadora%20Digital%202000W.jpg', 4.5, 8, true, '550e8400-e29b-41d4-a716-446655440003', '2026-04-02 11:00:00', 45),
(16, 'Microondas Inteligente', 'Microondas 30L con control wifi, sensores de humedad, 10 niveles potencia', 189.99, 32, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Microondas%20Inteligente.webp', 4.0, 8, true, '550e8400-e29b-41d4-a716-446655440003', '2026-04-27 15:00:00', 10),
(17, 'Kit de Herramientas 20 piezas', 'Set completo de herramientas para mantenimiento básico del auto en estuche', 54.99, 75, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Kit%20de%20Herramientas%2020%20piezas.webp', 4.4, 9, true, '550e8400-e29b-41d4-a716-446655440006', '2026-04-06 12:00:00', 22),
(18, 'Pedal de Acelerador Deportivo', 'Pedal deportivo ajustable universal, material aluminio, fácil instalación', 42.99, 50, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Pedal%20de%20Acelerador%20Deportivo.webp', 3.9, 9, true, '550e8400-e29b-41d4-a716-446655440006', '2026-04-03 09:15:00', 8),
(19, 'Comida Premium para Perros', 'Alimento balanceado 10kg, con proteínas naturales, para razas medianas', 29.99, 0, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Comida%20Premium%20para%20Perros.webp', 4.6, 10, true, '550e8400-e29b-41d4-a716-446655440003', '2026-04-01 10:00:00', 65),
(20, 'Juguete Interactivo para Perro', 'Juguete goma resistente con dispensador de premios, tamaño mediano', 24.99, 105, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Juguete%20Interactivo%20para%20Perro.webp', 4.3, 10, false, '550e8400-e29b-41d4-a716-446655440003', '2026-04-21 17:00:00', 7),
(61, 'Marketplace Headphones Pro', 'Auriculares premium para usar en pruebas del endpoint por usuario', 149.99, 25, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Marketplace%20Headphones%20Pro.jpg', 4.8, 1, true, '550e8400-e29b-41d4-a716-446655440007', '2026-04-30 13:00:00', 4),
(62, 'Marketplace Smart Watch', 'Reloj inteligente activo para validar listados por seller', 199.99, 18, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Marketplace%20Smart%20Watch.jpg', 4.6, 1, true, '550e8400-e29b-41d4-a716-446655440007', '2026-04-30 14:00:00', 2),
(63, 'Marketplace Archived Item', 'Producto inactivo para validar filtrado de estado', 59.99, 12, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Zapatillas%20Running%20Pro.webp', 4.1, 1, false, '550e8400-e29b-41d4-a716-446655440007', '2026-04-30 15:00:00', 1)
ON CONFLICT (id) DO UPDATE SET seller_id = EXCLUDED.seller_id, created_at = EXCLUDED.created_at, reviews_count = EXCLUDED.reviews_count;

-- ─── Productos adicionales (IDs 21–50) ──────────────────────────────────────

INSERT INTO products (id, name, description, price, stock, main_image, rating, category_id, is_active, seller_id, created_at, reviews_count) VALUES
-- 📱 Electrónica y Tecnología
(21, 'iPhone 15 Pro 256GB',           'Smartphone Apple con chip A17 Pro, camara de 48MP, USB-C y titanio',                                      999.99,  15, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/iPhone%2015%20Pro%20256GB.jpg',             4.9, 1, true,  '550e8400-e29b-41d4-a716-446655440001', '2026-03-15 10:00:00', 89),
(22, 'Tablet Samsung Galaxy Tab A9',  'Tablet 10.5" con pantalla LCD, 64GB, WiFi, ideal para entretenimiento y trabajo',                          349.99,  28, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Tablet%20Samsung%20Galaxy%20Tab%20A9.webp',             4.4, 1, true,  '550e8400-e29b-41d4-a716-446655440001', '2026-03-20 11:00:00', 45),
(23, 'Powerbank 20000mAh Carga Rapida','Bateria portatil con carga rapida 22.5W, 2 puertos USB + USB-C, pantalla LED',                             39.99, 200, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Powerbank%2020000mAh%20Carga%20Rapida.webp',       4.3, 1, true,  '550e8400-e29b-41d4-a716-446655440001', '2026-04-01 09:00:00', 67),
-- 👕 Ropa y Moda
(24, 'Remera Polo Clasica',           'Remera estilo polo 100% algodon pique, disponible en 6 colores, tallas S-XXL',                              19.99, 150, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Remera%20Polo%20Clasica.webp',       4.2, 2, true,  '550e8400-e29b-41d4-a716-446655440002', '2026-02-10 08:00:00', 30),
(25, 'Pantalon Chino Slim Fit',       'Pantalon casual slim fit, tela stretch comoda, colores neutros, tallas 28-38',                              49.99,  85, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Pantalon%20Chino%20Slim%20Fit.jpg',       4.5, 2, true,  '550e8400-e29b-41d4-a716-446655440002', '2026-02-15 09:00:00', 55),
(26, 'Campera Impermeable Windbreaker','Campera cortaviento impermeable, capucha desmontable, tallas S-XL, varios colores',                         89.99,  40, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Campera%20Impermeable%20Windbreaker.webp',       4.7, 2, true,  '550e8400-e29b-41d4-a716-446655440002', '2026-03-05 10:00:00', 20),
-- 🏠 Hogar y Decoración
(27, 'Set de Sabanas Queen Premium',  'Juego de sabanas 4 piezas, microfibra suave 1800 hilos, lavable a maquina',                                  79.99,  60, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Set%20de%20Sabanas%20Queen%20Premium.webp', 4.6, 3, true,  '550e8400-e29b-41d4-a716-446655440003', '2026-02-20 08:30:00', 88),
(28, 'Organizador de Escritorio Bambu','Organizador multi-compartimento de bambu natural, para lapiceros, papeles y accesorios',                    24.99, 120, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Organizador%20de%20Escritorio%20Bambu.webp',         4.1, 3, true,  '550e8400-e29b-41d4-a716-446655440003', '2026-03-10 11:00:00', 15),
(29, 'Espejo Decorativo Marco Dorado', 'Espejo circular 60cm con marco dorado estilo minimalista, apto pared',                                      59.99,  35, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Espejo%20Decorativo%20Marco%20Dorado.jpg',         4.4, 3, true,  '550e8400-e29b-41d4-a716-446655440003', '2026-03-25 14:00:00', 22),
-- 🧴 Belleza y Cuidado Personal
(30, 'Set de Pinceles de Maquillaje', 'Set profesional de 15 pinceles con estuche, cerdas sinteticas suaves, lavables',                            29.99,  90, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Set%20de%20Pinceles%20de%20Maquillaje.webp',    4.5, 4, true,  '550e8400-e29b-41d4-a716-446655440004', '2026-02-05 10:00:00', 40),
(31, 'Serum Vitamina C 30ml',         'Serum antioxidante con vitamina C al 15%, acido hialuronico y vitamina E, reafirma y unifica el tono',      44.99, 110, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Serum%20Vitamina%20C%2030ml.webp',    4.8, 4, true,  '550e8400-e29b-41d4-a716-446655440004', '2026-03-01 09:30:00', 75),
(32, 'Protector Solar FPS 50 100ml',  'Protector solar de amplio espectro, formula oil-free, no deja residuo blanco, water resistant',              18.99, 200, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Protector%20Solar%20FPS%2050%20100ml.jpg',               4.3, 4, true,  '550e8400-e29b-41d4-a716-446655440004', '2026-03-18 08:00:00', 33),
-- 🧸 Juguetes y Niños
(33, 'Set LEGO Creator 500 piezas',   'Set de construccion LEGO con 500 piezas para crear 3 modelos distintos, edad recomendada +8 anos',           69.99,  45, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Set%20LEGO%20Creator%20500%20piezas.webp', 4.9, 5, true, '550e8400-e29b-41d4-a716-446655440005', '2026-01-20 10:00:00', 110),
(34, 'Muneca Interactiva con Accesorios','Muneca que habla y canta, incluye set de ropa, peinados y accesorios, pilas incluidas, +3 anos',          39.99,  70, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Muneca%20Interactiva%20con%20Accesorios.jpg',           4.4, 5, true,  '550e8400-e29b-41d4-a716-446655440005', '2026-02-28 11:00:00', 28),
(35, 'Bicicleta Infantil Rodado 16',  'Bicicleta para ninos 4-7 anos, con rueditas de apoyo desmontables, freno trasero y manillar ajustable',    129.99,  20, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Bicicleta%20Infantil%20Rodado%2016.webp', 4.6, 5, true, '550e8400-e29b-41d4-a716-446655440005', '2026-03-08 09:00:00', 18),
-- 🏋️ Deportes y Fitness
(36, 'Pelota de Futbol Profesional',  'Pelota de futbol tamano 5, cubierta de PU, costuras reforzadas, apta para cesped natural y sintetico',       34.99,  80, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Pelota%20de%20Futbol%20Profesional.webp',  4.5, 6, true,  '550e8400-e29b-41d4-a716-446655440006', '2026-02-01 08:00:00', 42),
(37, 'Bicicleta de Montana 26"',      'Bicicleta MTB 21 velocidades, marco de aluminio, frenos de disco, horquilla delantera con suspension',      449.99,   8, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Bicicleta%20de%20Montana%2026.webp',   4.7, 6, true,  '550e8400-e29b-41d4-a716-446655440006', '2026-01-10 10:00:00', 12),
(38, 'Soga para Saltar Profesional',  'Soga de crossfit con rodamientos de precision, cables de acero, mangos ergonomicos, largo ajustable',        14.99, 300, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Soga%20para%20Saltar%20Profesional.webp',  4.2, 6, true,  '550e8400-e29b-41d4-a716-446655440006', '2026-04-10 07:00:00', 25),
-- 🖥️ Computación y Accesorios
(39, 'Monitor Curvo 27" Full HD',     'Monitor LED curvo 1500R, 1920x1080, 75Hz, 5ms, con entrada HDMI y DisplayPort, compatible con VESA',        299.99,  22, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Monitor%20Curvo%2027%20Full%20HD.webp',       4.6, 7, true,  '550e8400-e29b-41d4-a716-446655440001', '2026-02-22 09:00:00', 35),
(40, 'Auriculares Gaming con Microfono','Auriculares over-ear 7.1 virtual, iluminacion RGB, microfono flexible con cancelacion de ruido, USB',       59.99,  75, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Auriculares%20Gaming%20con%20Microfono.webp',   4.4, 7, true,  '550e8400-e29b-41d4-a716-446655440001', '2026-03-12 10:00:00', 48),
(41, 'Webcam Full HD 1080p',          'Camara web con microfono integrado, enfoque automatico, compatible con Zoom/Teams/Meet, clip universal',      49.99,  95, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Webcam%20Full%20HD%201080p.webp',       4.3, 7, true,  '550e8400-e29b-41d4-a716-446655440001', '2026-03-28 11:30:00', 29),
-- 🍳 Electrodomésticos
(42, 'Freidora de Aire 5.5L Digital', 'Air fryer con pantalla digital, 8 programas preestablecidos, capacidad 5.5L, bajo consumo energetico',      119.99,  38, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Freidora%20de%20Aire%205.5L%20Digital.jpg',   4.8, 8, true,  '550e8400-e29b-41d4-a716-446655440003', '2026-01-25 08:00:00', 92),
(43, 'Cafetera de Capsulas Express',  'Cafetera compatible con capsulas Nespresso, 19 bares de presion, deposito 0.6L, calentamiento en 25 seg',    89.99,  55, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Cafetera%20de%20Capsulas%20Express.jpg',   4.5, 8, true,  '550e8400-e29b-41d4-a716-446655440003', '2026-02-14 09:00:00', 61),
(44, 'Aspiradora Robot con Mapeado',  'Aspiradora robotica con mapeo laser, navegacion inteligente, compatible con app y asistentes de voz',        249.99,  12, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Aspiradora%20Robot%20con%20Mapeado.webp',   4.6, 8, true,  '550e8400-e29b-41d4-a716-446655440003', '2026-03-03 14:00:00', 37),
-- 🚗 Automotor y Herramientas
(45, 'Camara de Reversa Inalambrica', 'Camara trasera HD 170° con vision nocturna, transmision inalambrica, compatible con radios Android/iPhone',  39.99,  60, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Camara%20de%20Reversa%20Inalambrica.webp', 4.3, 9, true, '550e8400-e29b-41d4-a716-446655440006', '2026-02-08 10:00:00', 18),
(46, 'Compresor de Aire Portatil 12V','Inflador electrico portatil 150PSI, pantalla digital, corte automatico de presion, cable 3m, maletin',       54.99,  45, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Compresor%20de%20Aire%20Portatil%2012V.webp', 4.5, 9, true, '550e8400-e29b-41d4-a716-446655440006', '2026-03-14 09:30:00', 26),
(47, 'Alfombras Universales para Auto','Set de 4 alfombras de goma impermeables, antideslizantes, lavables, ajuste universal',                       29.99,  90, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Alfombras%20Universales%20para%20Auto.webp', 4.1, 9, true, '550e8400-e29b-41d4-a716-446655440006', '2026-04-04 08:00:00', 11),
-- 🐶 Mascotas
(48, 'Cama Ortopedica para Perro L',  'Cama con relleno de espuma viscoelastica, funda lavable, tamano L (80x60cm), ideal para razas grandes',      54.99,  35, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Cama%20Ortopedica%20para%20Perro%20L.webp',  4.7, 10, true, '550e8400-e29b-41d4-a716-446655440003', '2026-02-18 10:00:00', 44),
(49, 'Rascador para Gatos Torre',     'Torre rascador de 120cm con 3 niveles, cuerda de sisal, hamacas y juguetes colgantes, base estable',          79.99,  22, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Rascador%20para%20Gatos%20Torre.webp', 4.5, 10, true, '550e8400-e29b-41d4-a716-446655440003', '2026-03-22 11:00:00', 19),
(50, 'Correa Retractil 5 Metros',     'Correa retractil hasta 25kg, cinta reflectante, freno de seguridad, ergonomica, disponible en 3 colores',     19.99, 150, 'https://sgfjfdeuftwaopaodzar.supabase.co/storage/v1/object/public/product_bazaar/oficial/Correa%20Retractil%205%20Metros.webp',  4.2, 10, true, '550e8400-e29b-41d4-a716-446655440003', '2026-04-11 09:00:00', 31)
ON CONFLICT (id) DO UPDATE SET seller_id = EXCLUDED.seller_id, created_at = EXCLUDED.created_at, reviews_count = EXCLUDED.reviews_count;

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
     '2026-05-23 08:30:00')
ON CONFLICT (product_id, order_id) DO NOTHING;
