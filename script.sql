-- Tabla de clientes, donde el campo de correo electrónico es obligatorio pero el campo de teléfono puede ser nulo.
CREATE TABLE Cliente (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    correo_electronico TEXT UNIQUE NOT NULL,
    telefono TEXT
);

-- Ingresar 10 tuplas con 5 valores nulos en el campo de teléfono
INSERT INTO
    Cliente (nombre, correo_electronico, telefono)
VALUES
    ('Juan Pérez', 'juan@example.com', '123456789'),
    ('María García', 'maria@example.com', '987654321'),
    ('Luis González', 'luis@example.com', '456789123'),
    ('Ana Martínez', 'ana@example.com', '321654987'),
    ('Pedro Rodríguez', 'pedro@example.com','654987321'),
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

-- Tabla de pedidos con llave primaria que puede ser nula
CREATE TABLE Pedido (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER,
    fecha_pedido DATE NOT NULL,
    total DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id) ON UPDATE RESTRICT ON DELETE CASCADE
);

-- Tabla de productos
CREATE TABLE Producto (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL
);

-- Tabla de detalles de pedido
CREATE TABLE DetallePedido (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pedido_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES Producto(id) ON UPDATE CASCADE
);

-- Tabla de inventario de productos
CREATE TABLE Inventario (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    producto_id INTEGER UNIQUE,
    cantidad INTEGER NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES Producto(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabla de compras realizadas por los clientes
CREATE TABLE Compra (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER,
    fecha_compra DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id) ON UPDATE CASCADE ON DELETE
    SET
        NULL
);

-- Tabla de direcciones de entrega de los clientes
CREATE TABLE DireccionEntrega (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER,
    direccion TEXT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Regla de negocio: máximo 5 pedidos por cliente
CREATE TABLE RegistroPedidos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER,
    fecha_registro DATE NOT NULL DEFAULT (strftime('%Y-%m-%d', 'now')),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id),
    CHECK (
        (
            SELECT
                COUNT(*)
            FROM
                Pedido
            WHERE
                Pedido.cliente_id = RegistroPedidos.cliente_id
        ) <= 5
    )
);

-- Intentar insertar un sexto pedido para un cliente y capturar el error
BEGIN;

INSERT INTO
    RegistroPedidos (cliente_id)
VALUES
    (1);

EXCEPTION
WHEN CHECK constraint_error THEN
SELECT
    'No se pueden agregar más de 5 pedidos por cliente';
END;

COMMIT;