UPDATE products
SET imagen_url = CASE
  WHEN id = 1 AND name = 'Audífonos Bluetooth' THEN 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=700&q=80'
  WHEN id = 2 AND name = 'Smartwatch' THEN 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&w=700&q=80'
  WHEN id = 3 AND name = 'Camiseta básica' THEN 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=700&q=80'
  WHEN id = 4 AND name = 'Jean clásico' THEN 'https://images.unsplash.com/photo-1542272604-787c3835535d?auto=format&fit=crop&w=700&q=80'
  WHEN id = 5 AND name = 'Juego de sábanas' THEN 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&w=700&q=80'
  WHEN id = 6 AND name = 'Lámpara de mesa' THEN 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&w=700&q=80'
  WHEN id = 7 AND name = 'Balón de fútbol' THEN 'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?auto=format&fit=crop&w=700&q=80'
  WHEN id = 8 AND name = 'Mancuernas ajustables' THEN 'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?auto=format&fit=crop&w=700&q=80'
  ELSE imagen_url
END
WHERE (id = 1 AND name = 'Audífonos Bluetooth')
   OR (id = 2 AND name = 'Smartwatch')
   OR (id = 3 AND name = 'Camiseta básica')
   OR (id = 4 AND name = 'Jean clásico')
   OR (id = 5 AND name = 'Juego de sábanas')
   OR (id = 6 AND name = 'Lámpara de mesa')
   OR (id = 7 AND name = 'Balón de fútbol')
   OR (id = 8 AND name = 'Mancuernas ajustables');

SELECT id, name, imagen_url
FROM products
WHERE id BETWEEN 1 AND 8
ORDER BY id;
