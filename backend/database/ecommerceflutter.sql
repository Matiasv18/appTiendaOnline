CREATE DATABASE IF NOT EXISTS ecommerceflutter;
USE ecommerceflutter;

-- ─── TABLA: users ────────────────────────────────────────────────────────────
-- Guarda los usuarios registrados (nombre, email, contraseña encriptada)
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,        -- ID único que se genera solo
  name VARCHAR(100) NOT NULL,               -- Nombre del usuario
  email VARCHAR(150) NOT NULL UNIQUE,       -- Email único (no se puede repetir)
  password VARCHAR(255) NOT NULL,           -- Contraseña encriptada (bcrypt)
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Fecha de registro
);

-- ─── TABLA: categories ───────────────────────────────────────────────────────
-- Tipos de productos: Electrónica, Ropa, Hogar, Deportes
CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(255)
);

-- ─── TABLA: products ─────────────────────────────────────────────────────────
-- Catálogo de productos de la tienda
CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,            -- Precio con 2 decimales
  imagen_url VARCHAR(255),                  -- URL de la imagen
  category_id INT NOT NULL,                 -- A qué categoría pertenece
  FOREIGN KEY (category_id) REFERENCES categories(id) -- Relación con categories
);

-- ─── TABLA: cart_items ───────────────────────────────────────────────────────
-- Carrito de cada usuario (persistencia en BD, no local)
CREATE TABLE IF NOT EXISTS cart_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,                     -- De qué usuario es el carrito
  product_id INT NOT NULL,                  -- Qué producto lleva
  quantity INT NOT NULL DEFAULT 1,          -- Cuántas unidades
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  UNIQUE KEY unique_user_product (user_id, product_id) -- Un usuario no repite el mismo producto
);

-- ─── DATOS INICIALES: 4 categorías ───────────────────────────────────────────
INSERT INTO categories (name, description) VALUES
('Electrónica', 'Dispositivos y gadgets tecnológicos'),
('Ropa', 'Prendas de vestir para toda ocasión'),
('Hogar', 'Artículos para el hogar'),
('Deportes', 'Equipamiento y accesorios deportivos');

-- ─── DATOS INICIALES: 10 productos ─────────────────────────────────────────────
INSERT INTO products (name, description, price, imagen_url, category_id) VALUES
('Auriculares Bluetooth', 'Auriculares inalámbricos con cancelación de ruido', 49.99, 'https://picsum.photos/seed/auriculares/300/300', 1),
('Smartwatch', 'Reloj inteligente con monitor de actividad', 89.99, 'https://picsum.photos/seed/smartwatch/300/300', 1),
('Camiseta Básica', 'Camiseta de algodón 100% en varios colores', 19.99, 'https://picsum.photos/seed/camiseta/300/300', 2),
('Jeans Clásicos', 'Pantalón jeans corte recto', 39.99, 'https://picsum.photos/seed/jeans/300/300', 2),
('Lámpara LED', 'Lámpara de escritorio con luz regulable', 24.99, 'https://picsum.photos/seed/lampara/300/300', 3),
('Set de Sábanas', 'Juego de sábanas de algodón tamaño queen', 34.99, 'https://picsum.photos/seed/sabanas/300/300', 3),
('Balón de Fútbol', 'Balón oficial tamaño 5', 29.99, 'https://picsum.photos/seed/balon/300/300', 4),
('Mancuernas 5kg', 'Par de mancuernas de 5 kg cada una', 44.99, 'https://picsum.photos/seed/mancuernas/300/300', 4),
('Tablet 10"', 'Tablet con pantalla de 10 pulgadas', 199.99, 'https://picsum.photos/seed/tablet/300/300', 1),
('Chaqueta Deportiva', 'Chaqueta ligera para entrenamiento', 54.99, 'https://picsum.photos/seed/chaqueta/300/300', 2);