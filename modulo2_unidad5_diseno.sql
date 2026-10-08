 -- =============================================================================
-- BodegaTech — Script de Inventario (Módulo 2)
-- Motor: SQL Server (SSMS)
-- =============================================================================

-- ── SECCIÓN DDL ──────────────────────────────────────────────────────────────

-- Paso 1: Eliminar la tabla si ya existe para permitir re-ejecución sin errores
DROP TABLE IF EXISTS inventario;
GO

-- Paso 2: Creación de la tabla inventario
CREATE TABLE inventario (
    -- id_producto: INT como clave primaria única (PK) para identificar cada producto.
    id_producto INT PRIMARY KEY,

    -- nombre_producto: VARCHAR(100) almacena texto variable hasta 100 caracteres para el nombre comercial.
    nombre_producto VARCHAR(100) NOT NULL,

    -- categoria: VARCHAR(50) permite agrupar los artículos por sector (Computación, Audio, Accesorios, etc.).
    categoria VARCHAR(50) NOT NULL,

    -- precio_unitario: DECIMAL(10,2) garantiza precisión exacta en valores monetarios en USD, evitando errores de redondeo de FLOAT.
    precio_unitario DECIMAL(10,2) NOT NULL,

    -- stock_actual: INT para registrar unidades enteras disponibles en depósito.
    stock_actual INT NOT NULL,

    -- stock_minimo: INT define el umbral entero de seguridad para reposición de stock.
    stock_minimo INT NOT NULL,

    -- fecha_ingreso: DATE almacena únicamente la fecha de alta (AAAA-MM-DD) sin incluir la hora.
    fecha_ingreso DATE NOT NULL,

    -- activo: BIT guarda un valor lógico binario (1 = disponible, 0 = descontinuado) optimizando el almacenamiento.
    activo BIT DEFAULT 1
);
GO

-- ── SECCIÓN DML ──────────────────────────────────────────────────────────────

-- Paso 3: Carga inicial de los 10 productos del inventario
INSERT INTO inventario (id_producto, nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo)
VALUES 
    (1, 'Laptop Pro 15', 'Computación', 1200.00, 15, 3, '2024-01-10', 1),
    (2, 'Mouse Inalámbrico', 'Accesorios', 28.00, 80, 10, '2024-01-10', 1),
    (3, 'Monitor 4K 27"', 'Computación', 450.00, 12, 2, '2024-01-15', 1),
    (4, 'Teclado Mecánico', 'Accesorios', 95.00, 40, 5, '2024-01-15', 1),
    (5, 'Laptop Basic 14', 'Computación', 650.00, 20, 3, '2024-02-01', 1),
    (6, 'Auriculares BT Pro', 'Audio', 120.00, 35, 5, '2024-02-01', 1),
    (7, 'Hub USB-C 7 puertos', 'Accesorios', 45.00, 60, 10, '2024-02-10', 1),
    (8, 'Webcam HD 1080p', 'Accesorios', 85.00, 25, 5, '2024-02-10', 1),
    (9, 'SSD Externo 1TB', 'Almacenamiento', 130.00, 18, 3, '2024-03-01', 1),
    (10, 'Parlante Bluetooth', 'Audio', 60.00, 45, 8, '2024-03-01', 1);
GO

-- Paso 4: Registro de ventas del día actualizando stock_actual (usando WHERE obligatoriamente)
-- Laptop Pro 15 (id 1): se vendieron 3 unidades (15 -> 12)
UPDATE inventario 
SET stock_actual = stock_actual - 3 
WHERE id_producto = 1;

-- Mouse Inalámbrico (id 2): se vendieron 12 unidades (80 -> 68)
UPDATE inventario 
SET stock_actual = stock_actual - 12 
WHERE id_producto = 2;

-- Auriculares BT Pro (id 6): se vendieron 5 unidades (35 -> 30)
UPDATE inventario 
SET stock_actual = stock_actual - 5 
WHERE id_producto = 6;
GO

-- Paso 5: Descontinuar la Webcam HD 1080p (id 8) asignando activo = 0
UPDATE inventario 
SET activo = 0 
WHERE id_producto = 8;
GO

-- ── SECCIÓN VALIDACIÓN ───────────────────────────────────────────────────────

-- Paso 6: Consulta de validación final
SELECT * FROM inventario;