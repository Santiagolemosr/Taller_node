CREATE DATABASE IF NOT EXISTS Taller_feria;
USE Taller_feria;

-- Tabla de artesanos
CREATE TABLE artesanos (
    id_artesano INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla de productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

-- Tabla de ventas
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_artesano INT,
    id_producto INT,
    fecha DATE NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_artesano) REFERENCES artesanos(id_artesano),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Insertar artesanos
INSERT INTO artesanos (nombre) VALUES
('María López'),
('Juan Pérez'),
('Ana Torres'),
('Carlos Gómez'),
('Luisa Martínez');

-- Insertar productos
INSERT INTO productos (nombre, precio) VALUES
('Pulsera artesanal', 15000.00),
('Bolso tejido', 80000.00),
('Sombrero vueltiao', 120000.00),
('Collar de piedras', 30000.00),
('Hamaca', 200000.00);

-- Insertar ventas
INSERT INTO ventas (id_artesano, id_producto, fecha, cantidad) VALUES
(1, 1, '2025-09-01', 3),
(2, 2, '2025-10-02', 2),
(3, 3, '2025-07-02', 1),
(4, 4, '2025-04-03', 4);
select * from ventas;

-- Consulta 1: artesanos que más han vendido
SELECT a.nombre, SUM(v.cantidad) AS total_vendido
FROM artesanos a
JOIN ventas v ON a.id_artesano = v.id_artesano
GROUP BY a.nombre
ORDER BY total_vendido DESC;

-- Consulta 2: promedio de ventas por producto
SELECT p.nombre, AVG(cantidad) promedio
FROM productos p
JOIN ventas v USING(id_producto)
GROUP BY p.nombre;

-- Consulta 3: días con ventas superiores al promedio mensual
SELECT fecha, SUM(cantidad) AS total_dia
FROM ventas
GROUP BY fecha
HAVING SUM(cantidad) > (
  SELECT AVG(total_mes)
  FROM (
    SELECT SUM(cantidad) AS total_mes
    FROM ventas
    GROUP BY YEAR(fecha), MONTH(fecha)
  ) m
);
