-- Tabla de clientes, donde el campo de correo electrónico es obligatorio pero el campo de teléfono puede ser nulo.
CREATE TABLE Cliente (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    correo_electronico TEXT UNIQUE NOT NULL,
    telefono TEXT
);

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

-- Tabla de registro de pedidos
CREATE TABLE RegistroPedidos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER,
    id_pedido INTEGER NOT NULL,
    fecha_registro DATE NOT NULL DEFAULT (strftime('%Y-%m-%d', 'now')),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id)
);

-- Regla de negocio: máximo 5 pedidos por cliente
CREATE TRIGGER limit_pedidos_before_insert BEFORE
INSERT
    ON RegistroPedidos FOR EACH ROW BEGIN -- Verificar si el cliente ya tiene 5 o más pedidos
SELECT
    RAISE(
        ABORT,
        'No se pueden agregar más de 5 pedidos simultaneos por cliente'
    )
FROM
    RegistroPedidos
WHERE
    cliente_id = NEW.cliente_id
GROUP BY
    cliente_id
HAVING
    COUNT(*) >= 5;

END;