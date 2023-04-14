.data
CERO:   .byte 2, 8, 3, 8, 4, 8, 1, 7, 5, 7, 1, 6, 5, 6, 1, 5, 5, 5, 1, 4, 5, 4, 1, 3, 5, 3, 1, 2, 5, 2, 2, 1, 3, 1, 4, 1, -1, 1, 1, 1, 1
UNO:    .byte 3, 8, 3, 7, 3, 6, 3, 5, 3, 4, 3, 3, 3, 2, 3, 1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
DOS:    .byte 2, 8, 3, 8, 4, 8, 1, 7, 5, 7, 5, 6, 4, 5, 5, 5, 2, 4, 3, 4, 4, 4, 1, 3, 2, 3, 1, 2, 5, 2, 1, 1, 2, 1, 3, 1, 4, 1, 5, 1, -1
TRES:   .byte 2, 8, 3, 8, 4, 8, 1, 7, 5, 7, 5, 6, 4, 5, 5, 5, 2, 4, 3, 4, 4, 4, 4, 3, 5, 3, 1, 2, 5, 2, 2, 1, 3, 1, 4, 1, -1, 1, 1, 1, 1
CUATRO: .byte 4, 7, 5, 7, 3, 6, 5, 6, 2, 5, 5, 5, 1, 4, 5, 4, 1, 3, 2, 3, 3, 3, 4, 3, 5, 3, 5, 2, 5, 1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
CINCO:  .byte 2, 8, 3, 8, 4, 8, 5, 8, 1, 7, 1, 6, 1, 5, 2, 5, 2, 4, 3, 4, 4, 4, 5, 3, 5, 2, 1, 1, 2, 1, 3, 1, 4, 1, -1, 1, 1, 1, 1, 1, 1
SEIS:   .byte 2, 8, 3, 8, 4, 8, 1, 7, 5, 7, 1, 6, 1, 5, 1, 4, 2, 4, 3, 4, 4, 4, 5, 4, 1, 3, 5, 3, 1, 2, 5, 2, 2, 1, 3, 1, 4, 1, -1, 1, 1
SIETE:  .byte 1, 8, 2, 8, 3, 8, 4, 8, 5, 8, 1, 7, 5, 7, 5, 6, 4, 5, 5, 5, 3, 4, 4, 4, 3, 3, 3, 2, 3, 1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
OCHO:   .byte 2, 8, 3, 8, 4, 8, 1, 7, 5, 7, 1, 6, 5, 6, 2, 5, 3, 5, 4, 5, 1, 4, 5, 4, 1, 3, 5, 3, 1, 2, 5, 2, 2, 1, 3, 1, 4, 1, -1, 1, 1
NUEVE:  .byte 2, 8, 3, 8, 4, 8, 1, 7, 5, 7, 1, 6, 5, 6, 2, 5, 3, 5, 4, 5, 5, 5, 5, 4, 5, 3, 5, 2, 2, 1, 3, 1, 4, 1, -1, 1, 1, 1, 1, 1, 1
color:   .byte 255, 255, 255, 0
CONTROL: .word32 0x10000
DATA: .word32 0x10008
.text
lwu $s6, CONTROL($zero) ; $s6 = dirección de CONTROL
lwu $s7, DATA($zero) ; $s7 = dirección de DATA
daddi $t0, $zero, 6 ; $t0 = 6 -> función 6: limpiar pantalla alfanumérica
sd $t0, 0($s6) ; CONTROL recibe 6 y limpia la pantalla
daddi $t0, $zero, 8
sd $t0, 0($s6)
ld $t1, 0($s7)
dadd $t2, $zero, $zero
daddi $v0, $zero, CERO
loop: beq $t1, $t2, terminar
daddi $t2, $t2, 1
daddi $v0, $v0, 48
j loop
terminar: jal imprimirNumero
halt
imprimirNumero: daddi $t0, $zero, 7 ; $t0 = 7 -> función 7: limpiar pantalla gráfica
sd $t0, 0($s6) ; CONTROL recibe 7 y limpia la pantalla gráfica
lw $t1, color($zero)
sw $s2, 0($s7) ; DATA recibe el valor del color a pintar
daddi $t2, $zero, -1
loop2: lb $t1, 0($v0)
beq $t1, $t2, terminar2
sb $t1, 5($s7) ; DATA+5 recibe el valor de coordenada X
daddi $v0, $v0, 1
lb $t1, 0($v0)
sb $t1, 4($s7) ; DATA+4 recibe el valor de coordenada Y
daddi $v0, $v0, 1
daddi $t0, $zero, 5 ; $t0 = 5 -> función 5: salida gráfica
sd $t0, 0($s6) ; CONTROL recibe 5 y produce el dibujo del punto
j loop2
terminar2: jr $ra