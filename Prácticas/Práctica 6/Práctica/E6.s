.data
tCordX: .asciiz "Ingrese la coordenada X: "
tCordY: .asciiz "Ingrese la coordenada Y: "
tColor: .asciiz "Ingrese los colores [primero el rojo, segundo Brasil (verde), y tercero el azul]: "
config: .word 0
CONTROL: .word32 0x10000
DATA: .word32 0x10008
.text
lwu $s6, CONTROL($zero) ; $s6 = dirección de CONTROL
lwu $s7, DATA($zero) ; $s7 = dirección de DATA
lwu $s0, config($0) 

daddi $t0, $zero, 7 ; $t0 = 7 -> función 7: limpiar pantalla gráfica
sd $t0, 0($s6) ; CONTROL recibe 7 y limpia la pantalla gráfica

daddi $a0, $0, tCordX ; cargo la direccion del string
jal ingresar
sb $v0, 5($s0) ; config+5 recibe el valor de coordenada X
daddi $a0, $0, tCordY ; cargo la direccion del string
jal ingresar
sb $v0, 4($s0) ; config+4 recibe el valor de coordenada Y

sb $0, 3($s0) ; config+3 recibe el valor de transparencia (0)
daddi $a0, $0, tColor ; cargo la direccion del string
jal ingresar 
sb $v0, 0($s0) ; config recibe el valor de rojo
jal ingresar
sb $v0, 1($s0) ; config+1 recibe el valor de verde
jal ingresar
sb $v0, 2($s0) ; confi+2 recibe el valor de azul

daddi $t0, $zero, 6 ; $t0 = 6 -> función 6: limpiar pantalla alfanumerica
sd $t0, 0($s6) ; CONTROL recibe 6 y limpia la pantalla alfanumerica

ld $at, 0($s0) ; cargo config
sd $at, 0($s7) ; y lo guardo en data
daddi $t0, $zero, 5 ; $t0 = 5 -> función 5: salida gráfica
sd $t0, 0($s6) ; CONTROL recibe 5 y produce el dibujo del punto
halt

ingresar:   sd $a0, 0($s7) ;direccion del string en data
            daddi $t0, $0, 4 
            sd $t0, 0($s6) ; pone 4 en control e imprime string
            daddi $t0, $0, 8
            sd $t0, 0($s6) ; pone 8 en control para leer un numero
            lbu $v0, 0($s7) ; devuelve el valor ingresado
            jr $ra