import random
import mysql.connector
from namesgenerator import get_random_name

# Establecer la conexión con la base de datos
conexion = mysql.connector.connect(
    host='localhost',
    user='juan',
    password='R.e.m.n.5',
    database='Taquilla'
)

# Generar e insertar valores aleatorios en la tabla "Recinto"
cursor = conexion.cursor()
num_recintos = 10  # Cambia este valor según la cantidad deseada de recintos

for i in range(num_recintos):
    nombre_recinto = get_random_name()
    localidades_recinto = random.randint(100, 10000)  # Rango de 100 a 10000 localidades

    # Ejecutar el procedimiento almacenado utilizando parámetros de Python
    cursor.callproc('crear_recinto', (nombre_recinto, localidades_recinto))
    conexion.commit()

# Cerrar la conexión con la base de datos
cursor.close()
conexion.close()
