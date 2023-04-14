.data
DATA: .word32 0x10008
CONTROL: .word32 0x10000
cadena: .asciiz ""
carac: .asciiz ""
.text
lwu $s0,DATA($zero)
lwu $s1,CONTROL($zero)
daddi $t3,$zero,48
daddi $t1,$zero,9
daddi $t5,$zero,4
daddi $t2,$zero,0
leer:   sd $t1,0($s1) #control recibe 9 y lee un caracter
        lbu $s2,0($s0) #s2 recibe el caracter leido
        beq $s2,$t3,fin
        sb $s2,cadena($t2) #guardo en cadena el caracter leido
        daddi $t0,$t2,cadena #t0= direccion del msj a mostrar
        sd $t0,0($s0) # data recibe el puntero al comienzo del mensaje
        sd $t5,0($s1) #control recibe 4 e imprime
        daddi $t2,$t2,1
        j leer
fin:    jal imprimirnormal
daddi $t3,$zero,0
jal imprimirReves
halt
imprimirnormal: daddi $t0,$zero,cadena
                sd $t0,0($s0)
                sd $t5,0($s1)
                jr $ra
imprimirReves:  daddi $t2,$t2,-1
                daddi $t0,$t2,cadena #se pasa la direc de memoria del ultimo caracter
                lbu $t6,0($t0)
                sb $t6,carac($t3)
                daddi $t3,$t3,1
                bnez $t2,imprimirReves
                daddi $t0,$zero,carac
                sd $t0,0($s0)
                sd $t5,0($s1)
                jr $ra