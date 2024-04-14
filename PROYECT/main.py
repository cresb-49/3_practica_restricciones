import sqlite3

# Conectar a la base de datos (si no existe, la creará)
conexion = sqlite3.connect('database.db')

# Crear un cursor
cursor = conexion.cursor()

# Crear una tabla (si no existe)
cursor.execute('''CREATE TABLE IF NOT EXISTS usuarios
                  (id INTEGER PRIMARY KEY, nombre TEXT, edad INTEGER)''')

# Insertar datos
cursor.execute(
    "INSERT INTO usuarios (nombre, edad) VALUES (?, ?)", ('Juan', 30))
cursor.execute(
    "INSERT INTO usuarios (nombre, edad) VALUES (?, ?)", ('María', 25))

# Guardar cambios
conexion.commit()

# Consultar datos
cursor.execute("SELECT * FROM usuarios")
usuarios = cursor.fetchall()
for usuario in usuarios:
    print(usuario)

# Cerrar la conexión
conexion.close()
