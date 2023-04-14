.data
cadena1: .byte 1,2,3,4,5,0
cadena2: .byte 1,2,4,8,64,0
.text
daddi $a0, $zero, cadena1
daddi $a1, $zero, cadena2
jal difiere
halt

difiere: lb $t0, 0($a0)
         lb $t1, 0($a1)
         daddi $a0, $a0, 1
         daddi $a1, $a1, 1
         beqz $t0, iguales
         beqz $t1, iguales
         beq $t0, $t1, difiere
         dadd $v0, $zero, $a0
         j fin
         iguales: daddi $v0, $zero, -1
                  fin: jr $ra