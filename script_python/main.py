import sqlite3

# Conectar a la base de datos
conn = sqlite3.connect('database.db')
cursor = conn.cursor()

# Restricciones de llave foránea estén activadas
cursor.execute("PRAGMA foreign_keys = ON;")

# Información del pedido
cliente_id = 4
fecha_pedido = '2023-04-29'
total = 0  # Inicialmente 0, actualizaremos después de insertar detalles
max_pedidos = 5  # Máximo número de pedidos permitidos por cliente

try:
    # Contar el número de pedidos existentes para el cliente
    cursor.execute(
        "SELECT COUNT(*) FROM RegistroPedidos WHERE cliente_id = ?", (cliente_id,))
    num_pedidos = cursor.fetchone()[0]

    if num_pedidos >= max_pedidos:
        raise Exception(
            f"El cliente {cliente_id} ya ha alcanzado el máximo de {max_pedidos} pedidos permitidos.")

    # Insertar el pedido
    cursor.execute("INSERT INTO Pedido (cliente_id, fecha_pedido, total) VALUES (?, ?, ?)",
                   (cliente_id, fecha_pedido, total))
    pedido_id = cursor.lastrowid  # Recuperar el ID del nuevo pedido insertado

    # Detalles del pedido
    productos = [
        (pedido_id, 1, 1, 699.99),  # 1 Smartphone XYZ Pro
        (pedido_id, 5, 3, 74.97)    # 3 Cargadores USB-C
    ]

    # Insertar detalles del pedido
    cursor.executemany("INSERT INTO DetallePedido (pedido_id, producto_id, cantidad, subtotal) VALUES (?, ?, ?, ?)",
                       productos)

    # Actualizar el total del pedido después de añadir detalles
    nuevo_total = sum(item[3] for item in productos)  # Suma de los subtotales
    cursor.execute("UPDATE Pedido SET total = ? WHERE id = ?",
                   (nuevo_total, pedido_id))

    # Insertar registro del pedido
    cursor.execute(
        "INSERT INTO RegistroPedidos (cliente_id, id_pedido) VALUES (?,?)", (cliente_id, pedido_id))

    # Hacer commit de las transacciones
    conn.commit()
    print(f"Pedido creado con éxito. ID del pedido: {pedido_id}")

except sqlite3.IntegrityError as e:
    print("Error al manejar la base de datos:", e)
    conn.rollback()  # Revertir todos los cambios si ocurre un error
except Exception as e:
    print(e)
    conn.rollback()  # Revertir todos los cambios si se alcanza el límite de pedidos

finally:
    # Cerrar conexión a la base de datos
    conn.close()
