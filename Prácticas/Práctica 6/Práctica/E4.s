.data
control: .word32 0x10000
data: .word32 0x10008
clave: .asciiz "a2d2"
bien: .asciiz "Bienvenido"
mal: .asciiz "Error"

.text
lwu $s0, data($0) ; s0 = data
lwu $s1, control($0) ; s1 = control
daddi $sp, $0, 0x400 ;  inicializo la pila
jal respuesta
halt

char: daddi $t0, $0, 9 ; t0 = 9
      sd $t0, 0($s1) ; pongo 9 en contol para leer un caracter
      lbu $v0, 0($s0) ; guardo el caracter leído en v0
      jr $ra

respuesta:  daddi $sp, $sp, -8
            sd $ra, 0($sp) ; push ra
            daddi $t1, $0, clave ; t1 = direccion de clave
            daddi $t2, $0, 4 ; hasta 4 caracteres t2
            comprobacion:   jal char
                            lbu $t0, 0($t1) ; t0 = caracter de la clave
                            bne $v0, $t0, error ; si no coinciden los caracteres da error
                            daddi $t2, $t2, -1
                            daddi $t1, $t1, 1
                            bnez $t2, comprobacion
            daddi $t0, $0, bien
            sd $t0, 0($s0) ; pongo en data el string de bien
            daddi $t0, $0, 4
            sd $t0, 0($s1) ; pongo en control 4 para imprimir el string
            j fin

            error: daddi $t0, $0, mal
            sd $t0, 0($s0) ; pongo en data el string de mal
            daddi $t0, $0, 4
            sd $t0, 0($s1) ; pongo en control 4 para imprimir el string
            
            fin: ld $ra, 0($sp) ; pop ra
                 daddi $sp, $sp, 8
                 jr $ra 
