import pandas as pd

# Ruta del archivo de entrada
archivo_entrada = 'C:/DAM/Practicas/1DAM.csv'  # Cambia esto por el nombre y ruta de tu archivo

# Cargar el archivo CSV original con la codificación adecuada (ISO-8859-1 o latin1) y delimitador ";"
df = pd.read_csv(archivo_entrada, encoding='ISO-8859-1', delimiter=';')

# Eliminar la fila 27 (índice 26)
if len(df) > 25:
    df = df.drop(index=25).reset_index(drop=True)  # El índice 25 es la fila 26
    print("Fila 26 eliminada correctamente.")
else:
    print("El DataFrame no tiene suficientes filas para eliminar la fila 26.")

# Eliminar las primeras 16 filas
df = df.iloc[17:].reset_index(drop=True)  # Esto elimina las primeras 16 filas y reinicia el índice

# Renombrar las columnas manualmente
df.columns = ['Columna1', 'Columna2', 'NO', 'Columna4', 'Columna5', 'Columna6', 'Alumno/a', 'Columna8', 'Columna9', 'Columna10']

# Seleccionar las columnas 'NO' (índice 2) y 'Alumno/a' (índice 6)
df_seleccionado = df[['NO', 'Alumno/a']]

# Separar la columna 'Alumno/a' en 'Apellido' y 'Nombre'
df_seleccionado[['Apellido', 'Nombre']] = df_seleccionado['Alumno/a'].str.split(',', expand=True)

# Eliminar la columna 'Alumno/a' porque ya hemos separado los datos
df_seleccionado = df_seleccionado.drop(columns=['Alumno/a'])

# Eliminar las filas vacías (con valores NaN)
df_seleccionado = df_seleccionado.dropna()

# Guardar el nuevo archivo CSV con las columnas seleccionadas y con codificación UTF-8
archivo_salida = 'C:/DAM/Practicas/1DAM_filtrado.csv'  # Nombre del nuevo archivo
df_seleccionado.to_csv(archivo_salida, index=False, encoding='utf-8-sig')  # Usar 'utf-8-sig' para compatibilidad con Excel

print(f"El nuevo archivo CSV se ha guardado como '{archivo_salida}'")