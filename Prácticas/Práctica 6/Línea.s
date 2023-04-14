.data
coorX: 	.byte   24			; coordenada X de un punto	
coorY: 	.byte   24			; coordenada Y de un punto
color: 	.byte   255, 0, 255, 0	        ; color: máximo rojo + máximo azul => magenta
CONTROL: .word32 0x10000		; Dirección de mapeo
DATA:	.word32 0x10008		        ; Dirección de mapeo
	
.text
lwu	$s6, CONTROL($zero)		        ; $s6 = dirección de CONTROL
lwu	$s7, DATA($zero)		        ; $s7 = dirección de DATA

daddi	$t0, $zero, 7		                ; $t0 = 7 -> función 7: limpiar pantalla gráfica
sd	$t0, 0($s6)			        ; CONTROL recibe 7 y limpia la pantalla gráfica

lbu	$s0, coorX($zero)		        ; $s0 = valor de coordenada X
sb	$s0, 5($s7)			        ; DATA+5 recibe el valor de coordenada X

lbu	$s1, coorY($zero)		        ; $s1 = valor de coordenada Y
sb	$s1, 4($s7)			        ; DATA+4 recibe el valor de coordenada Y

lwu	$s2, color($zero)		        ; $s2 = valor de color a pintar (OJO, no ld)
sw	$s2, 0($s7)			        ; DATA recibe el valor del color a pintar

daddi $t1, $0, 20                               ; contador iniciado en 20 porque quiero hacer una linea de ese largo

daddi	$t0, $0, 5		                ; $t0 = 5 -> función 5: salida gráfica

loop:   sd $t0, 0($s6)			        ; CONTROL recibe 5 y produce el dibujo del punto
        daddi $s1, $s1, 1                       ; se incrementa la coordenada Y
        daddi $t1, $t1, -1                      ; decremento el contador
        sb $s1, 4($s7)		                ; DATA+4 recibe el valor de coordenada Y
        bnez $t1, loop                          ; y si no es 0 sigo
halt
