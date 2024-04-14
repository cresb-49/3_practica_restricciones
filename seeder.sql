-- Ingresar 10 tuplas con 5 valores nulos en el campo de teléfono
INSERT INTO
    Cliente (nombre, correo_electronico, telefono)
VALUES
    ('Juan Pérez', 'juan@example.com', '123456789'),
    ('María García', 'maria@example.com', '987654321'),
    ('Luis González', 'luis@example.com', '456789123'),
    ('Ana Martínez', 'ana@example.com', '321654987'),
    (
        'Pedro Rodríguez',
        'pedro@example.com',
        '654987321'
    ),
    ('Sofía López', 'sofia@example.com', NULL),
    ('Carlos Sánchez', 'carlos@example.com', NULL),
    ('Laura Díaz', 'laura@example.com', NULL),
    ('Miguel Ramírez', 'miguel@example.com', NULL),
    ('Elena Torres', 'elena@example.com', NULL);

-- Intentar insertar un cliente sin correo electrónico (fallará)
INSERT INTO
    Cliente (nombre, telefono)
VALUES
    ('Roberto Jiménez', '123456789');

INSERT INTO
    Producto (nombre, precio)
VALUES
    ('Smartphone XYZ Pro', 699.99),
    ('Laptop ABC 15" 8GB RAM', 1200.00),
    ('Tablet GHI 10" 32GB', 320.50),
    ('Auriculares Bluetooth JKL', 59.95),
    ('Cargador USB-C 45W', 24.99);

INSERT INTO
    Inventario (producto_id, cantidad)
VALUES
    (1, 50),
    -- 50 Smartphones XYZ Pro
    (2, 40),
    -- 40 Laptops ABC
    (3, 70),
    -- 70 Tablets GHI
    (4, 150),
    -- 150 Auriculares Bluetooth JKL
    (5, 200);

-- 200 Cargadores USB-C
INSERT INTO
    Pedido (cliente_id, fecha_pedido, total)
VALUES
    (1, '2023-04-10', 1400.00),
    (2, '2023-04-11', 689.94),
    (3, '2023-04-12', 400.44);

INSERT INTO
    DetallePedido (pedido_id, producto_id, cantidad, subtotal)
VALUES
    (1, 2, 1, 1200.00),
    -- 1 Laptop ABC para el pedido 1
    (1, 5, 2, 49.98),
    -- 2 Cargadores USB-C para el pedido 1
    (2, 1, 1, 699.99),
    -- 1 Smartphone XYZ Pro para el pedido 2
    (3, 3, 1, 320.50),
    -- 1 Tablet GHI para el pedido 3
    (3, 4, 2, 119.90);

-- 2 Auriculares Bluetooth JKL para el pedido 3
INSERT INTO
    Compra (cliente_id, fecha_compra, total)
VALUES
    (1, '2023-04-10', 1400.00),
    (2, '2023-04-11', 689.94);

INSERT INTO
    DireccionEntrega (cliente_id, direccion)
VALUES
    (1, '123 Electronic Ave, Tech City'),
    (2, '456 Gadget St, Innovation Park'),
    (3, '789 Circuit Ln, Silicon Valley'),
    (4, '1010 Hardware Dr, Tech Town'),
    (5, '1112 Software Blvd, Digital City'),
    (6, '1314 Mobile Ave, Tech City'),
    (7, '1516 Tablet Way, Innovation Park'),
    (8, '1718 Console St, Silicon Valley'),
    (9, '1920 Accessory Rd, Tech Town'),
    (10, '2122 Charger Ln, Digital City');

INSERT INTO
    RegistroPedidos (cliente_id, id_pedido)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);

INSERT INTO
    Pedido (cliente_id, fecha_pedido, total)
VALUES
    (3, '2023-04-25', 300.00),
    (3, '2023-04-26', 450.00),
    (3, '2023-04-27', 200.00),
    (3, '2023-04-28', 350.00);

INSERT INTO
    DetallePedido (pedido_id, producto_id, cantidad, subtotal)
VALUES
    (6, 1, 1, 300.00),
    -- 1 Smartphone XYZ Pro para el pedido 6
    (7, 2, 1, 450.00),
    -- 1 Laptop ABC para el pedido 7
    (8, 4, 4, 200.00),
    -- 4 Auriculares Bluetooth JKL para el pedido 8
    (9, 5, 15, 350.00);

-- 15 Cargadores USB-C para el pedido 9
INSERT INTO
    RegistroPedidos (cliente_id, id_pedido)
VALUES
    (3, 4),
    (3, 5),
    (3, 6),
    (3, 7);

INSERT INTO
    Pedido (cliente_id, fecha_pedido, total)
VALUES
    (4, '2023-04-29', 1319.90);

INSERT INTO
    DetallePedido (pedido_id, producto_id, cantidad, subtotal)
VALUES
    (8, 2, 1, 1200.00), -- 1 Laptop ABC
    (8, 4, 2, 119.90); -- 2 Auriculares Bluetooth JKL
    
INSERT INTO
    RegistroPedidos (cliente_id, id_pedido)
VALUES
    (3, 8);