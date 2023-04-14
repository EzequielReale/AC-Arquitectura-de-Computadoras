.data
CONTROL: .word32  0x10000
DATA: .word32  0x10008
fin: .byte 0
texto: .asciiz "" 
.text
lwu $s0, CONTROL($0)                            ; cargo control
lwu $s1, DATA($0)                               ; cargo data

jal ingre                                       ; ingreso el string

daddi $a0, $0, texto                            ; pongo la direccion del string en a0 para pasarlo a la subrutina
jal imprimir                                    ; imprimo el string

dadd $a0, $0, $v0                               ; pongo la direccion de finalizacion del string en a0 para llamar a la subrutina reordenar
jal reordenar                                   ; reordeno el string

jal imprimir                                    ; imprimo el string dado vuelta (a0 mantiene el mismo valor que antes, es la direccion de inicio del string)

halt


ingre:  daddi $t1, $0, 0x30                     ; codigo ascii del 0
        daddi $t2, $0, 9                        ; pongo el codigo para pedir ingresar un caracter
        dadd $t3, $0, $0                        ; t3 desplazamiento para ingresar en string
        loopIngre:  sd $t2, 0($s0)              ; pido el ingreso del caracter poniendo el 9 en control
                    lbu $t0, 0($s1)             ; guardo el caracter desde data
                    sb $t0, texto($t3)          ; pongo en caracter en la cadena desplazada t3 veces
                    daddi $t3, $t3, 1           ; incremento t3 (desplazamiento)
                    bne $t0, $t1, loopIngre     ; si el caracter ingresado no coincide con el ascii del 0 sigo
        
        dadd $v0, $0, $t3 
        daddi $v0, $v0, texto                   ; en estas 2 lineas me hago con la direccion de fin del string + 1
        jr $ra

reordenar:  daddi $t1, $a0, -1                  ; t1 tiene la direccion de memoria del string a invertir
            dadd $t2, $0, $a0                   ; t2 tiene la direccion de inicio del nuevo string
            loopReo: lbu $t0, 0($t1)            ; tomo un caracter del string anterior
                     sb $t0, 0($t2)             ; lo guardo en el nuevo
                     daddi $t1, $t1, -1         ; decremento t1 para agarrar en caracter anterior
                     daddi $t2, $t2, 1          ; incremento t2 para seguir completando el string nuevo
                     bnez $t0, loopReo          ; si t0 tomo el valor de 0 es porque el string termino
            jr $ra

imprimir: daddi $t0, $0, 4                      ; codigo para imprimir un string
          sd $a0, 0($s1)                        ; direccion del string
          sd $t0, 0($s0)                        ; pongo el codigo para imprimir string en control e imprime
          jr $ra