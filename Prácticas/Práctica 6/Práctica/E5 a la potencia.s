.data
control: .word32 0x10000
data: .word32 0x10008
one: .double 1
texto: .asciiz "Ingrese un numero (1ro flotante y despues entero): "

.text
lwu $s0, data($0) ; s0 = data
lwu $s1, control($0) ; s1 = control
daddi $sp, $0, 0x400 ;  inicializo la pila
jal aLaPotencia
halt

ingreso: daddi $t0, $0, texto                ; t0 = direccion del string
         sd $t0, 0($s0)                      ; pongo la direccion del string en data
         daddi $t0, $0, 4                    ; t0 = 4
         sd $t0, 0($s1)                      ; pongo 4 en control para imprimir string
         daddi $t0, $0, 8                    ; t0 = 8
         sd $t0, 0($s1)                      ; pongo 8 en contol para leer un numero
         ld $v0, 0($s0)                      ; guardo el numero leído en v0
         jr $ra                    
         
aLaPotencia: daddi $sp, $sp, -8
            sd $ra, 0($sp)                   ; push ra
            jal ingreso
            mtc1 $v0, f1                     ; pongo la base en f1
            mov.d f2, f1                     ; f2 = f1
            jal ingreso
            dadd $t1, $0, $v0                ; pongo la potencia en t1
            bnez $t1, normal                 ; si la potencia es mayor a 0 pasa
            l.d f2, one($0)                  ; si la potencia era 0, f2 = 1
            j uno
            normal: daddi $t1, $t1, -1       ; se descarta una potencia
                    beqz $t1, uno            ; si la potencia era 1 aca dio 0, asi que f2 = f2 sin elevar
                    pot: mul.d f2, f2, f1    ; f2 elevado a la f1
                         daddi $t1, $t1, -1  ; decremento la potencia
                         bnez $t1, pot       ; si aun no dio 0 sigo
            uno: s.d f2, 0($s0)              ; pongo el resultado en data
                 daddi $t0, $0, 3            ; t0 = 3
                 sd $t0, 0($s1)              ; pongo el 3 en control para que imprima un numero en coma flotante
            ld $ra, 0($sp)                   ; pop ra
            daddi $sp, $sp, 8
            jr $ra 