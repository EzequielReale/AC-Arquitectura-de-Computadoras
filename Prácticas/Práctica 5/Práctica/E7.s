.data
m: .byte 10
tabla: .byte 1,3,5,7,9,11,13,15,17,19
cant: .byte 0
.text
dadd $v0, $zero, $zero
daddi $at, $zero, cant
daddi $a1, $zero, tabla ; dirección de tabla
dsub $a2, $at, $a1 ; cantidad de elementos de tabla
lb $a0, m($zero) ; valor m
jal mayores
sb $v0, cant($zero)
halt

mayores: lb $t0, 0($a1)
         slt $t1, $a0, $t0 ; si el de la derecha es más grande $t1=1
         beqz $t1, sigo
         daddi $v0, $v0, 1
         sigo: daddi $a1, $a1, 1
               bne $a1, $a2, mayores
               jr $ra
