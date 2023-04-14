.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
texto: .asciiz ""
.text
lwu $s0, DATA($zero)
lwu $s1, CONTROL($zero)

daddi $t3, $0, 0xD ; pongo en t3 el ascii del enter para comparar y terminar el mensaje
dadd $t0, $0, $0 ; arranco el contador en 0

daddi $t1, $0, 9 
loop: sd $t1, 0($s1) ; pongo el 9 en control para leer un caracter
      lbu $t2, 0($s0) ; y guardo el caracter en t2
      sb $t2, texto($t0) ; lo guardo en el string
      daddi $t0, $t0, 1 ; incremento el contador
      bne $t2, $t3, loop ; si el caracter no es el enter vuelvo a loop

daddi $t0, $0, texto 
sd $t0, 0($s0) ; pongo en data la direcion del string
daddi $t0, $zero, 6
sd $t0, 0($s1) ; limpio la pantalla alfanumerica
daddi $t0, $zero, 4
sd $t0, 0($s1) ; imprimo el string

halt