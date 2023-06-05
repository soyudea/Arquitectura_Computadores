# Definición de la matriz de 3x3 en la sección de datos
.data
matriz: .word 1, 2, 3
        .word 4, 5, 6
        .word 7, 8, 9

# Puntero a la matriz
matriz_ptr: .word matriz

# Variables para la fila y columna actual
fila: .word 0
columna: .word 0

# Tamaño de la matriz (3x3)
tamano: .word 3

# Código en la sección de texto
.text
main:
    # Cargar el puntero a la matriz en $t0
    lw $t0, matriz_ptr

    # Cargar el tamaño de la matriz en $t1
    lw $t1, tamano

    # Iniciar el bucle externo para recorrer las filas
    li $t2, 0 # Inicializar el contador de filas en 0
bucle_fila:
    # Iniciar el bucle interno para recorrer las columnas
    li $t3, 0 # Inicializar el contador de columnas en 0
bucle_columna:
    # Calcular el índice del elemento en la matriz
    mul $t4, $t2, $t1         # Multiplicar el contador de filas por el tamaño de la matriz
    add $t4, $t4, $t3         # Sumar el contador de columnas
    sll $t4, $t4, 2           # Multiplicar por 4 para obtener el desplazamiento en bytes
    add $t5, $t0, $t4         # Calcular la dirección de memoria del elemento en la matriz
    lw $t6, ($t5)             # Acceder al valor del elemento en la matriz

    # Realizar alguna operación en el valor del elemento (ejemplo: imprimir el valor)
    li $v0, 1                # Cargar el código de la llamada al sistema para imprimir entero
    move $a0, $t6            # Cargar el valor del elemento en el registro de argumento
    syscall                  # Llamar al sistema para imprimir el valor
    addi $t3, $t3, 1         # Incrementar el contador de columnas

    # Comparar el contador de columnas con el tamaño de la matriz
    blt $t3, $t1, bucle_columna     # Volver al bucle interno si no se han recorrido todas las columnas
    addi $t2, $t2, 1               # Incrementar el contador de filas

    # Comparar el contador de filas con el tamaño de la matriz
    blt $t2, $t1, bucle_fila # Volver al bucle externo si no se han recorrido todas las filas

    # Fin del programa