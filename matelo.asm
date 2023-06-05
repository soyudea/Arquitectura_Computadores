.data
buffer: .space 256  # Reservar espacio en la memoria para el buffer de entrada
msg: .asciiz "Ingrese una palabra: "  # Mensaje para solicitar la palabra al usuario

.text
main:
    # Imprimir el mensaje para solicitar la palabra
    li $v0, 4  # Cargar el código de servicio 4 en $v0 para imprimir una cadena
    la $a0, msg  # Cargar la dirección de memoria del mensaje en $a0
    syscall  # Llamar al sistema para imprimir el mensaje

    # Leer la palabra ingresada por el usuario
    li $v0, 8  # Cargar el código de servicio 8 en $v0 para leer una cadena
    la $a0, buffer  # Cargar la dirección de memoria del buffer en $a0
    li $a1, 255  # Cargar la longitud máxima de la palabra en $a1
    syscall  # Llamar al sistema para leer la palabra

    # Fin del programa
    li $v0, 10  # Cargar el código de servicio 10 en $v0 para salir del programa
    syscall  # Llamar al sistema para salir del programa