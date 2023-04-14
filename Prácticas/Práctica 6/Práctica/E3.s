.data
control: .word32 0x10000
data: .word32 0x10008
texto: .asciiz "Ingrese un numero: "

.text
lwu $s0, data($0) ; s0 = data
lwu $s1, control($0) ; s1 = control
daddi $sp, $0, 0x400 ;  inicializo la pila
jal resultado
halt

ingreso: daddi $t0, $0, texto ; t0 = direccion del string
        sd $t0, 0($s0) ; pongo la direccion del string en data
        daddi $t0, $0, 4 ; t0 = 4
        sd $t0, 0($s1) ; pongo 4 en control para imprimir string
        daddi $t0, $0, 8 ; t0 = 8
        sd $t0, 0($s1) ; pongo 8 en contol para leer un numero
        ld $a0, 0($s0) ; guardo el numero leído en a0
        beqz $a0, ingreso ; si no es un numero vuelvo a pedir que lo ingrese
        jr $ra

resultado: daddi $sp, $sp, -8
          sd $ra, 0($sp) ; push ra

          jal ingreso
          dadd $t1, $0, $a0 ; pongo el 1er numero en t1
          jal ingreso
          dadd $t1, $t1, $a0 ; le sumo el 2do
          sd $t1, 0($s0) ; pongo el resultado en data
          daddi $t0, $0, 2 ; t0 = 2
          sd $t0, 0($s1) ; pongo el 2 en control para que imprima un numero entero

          ld $ra, 0($sp) ; pop ra
          daddi $sp, $sp, 8
          jr $ra 