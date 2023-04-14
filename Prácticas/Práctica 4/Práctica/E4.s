.data
tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
num: .word 7
long: .word 10
.code
ld r1, long(r0); r1=10
ld r2, num(r0); r2=7
dadd r3, r0, r0; r3=0
dadd r10, r0, r0; r10=0
loop: ld r4, tabla(r3); poner contenido del arreglo en r4 desplazando con r3
beq r4, r2, listo; si r4=r2 (r2=7) ya está en num. Por lo tanto terminó el arreglo 
daddi r1, r1, -1; dec r1
daddi r3, r3, 8; le sumo 8 a r3 para desplazar 8 bytes a la derecha y pasar al siguiente número
bnez r1, loop; mientras r1 no sea igual a 0 loopeo
j fin; si r1=0 terminé
listo: daddi r10, r0, 1; r10=1
fin: halt