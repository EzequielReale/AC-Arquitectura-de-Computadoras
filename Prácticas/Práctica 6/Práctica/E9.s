.data
CONTROL:        .word32 0x10000
DATA:           .word32 0x10008
#-------TABLA DE COLORES-----------
# -Código de color en  word32 : 0xAA BB GG RR
color_fondo:    .word32 0x00FFFFFF
color_cursor:   .word32 0x00999999
color_1:        .word32 0x000000FF
color_2:        .word32 0x0000FF00
color_3:        .word32 0x00FF0000
color_4:        .word32 0x0000FFFF
color_5:        .word32 0x00FFFF00
color_6:        .word32 0x00FFFF66
color_7:        .word32 0x00993377
color_8:        .word32 0x005599DD

#-------TABLA DE COMANDOS-----#
# Barra : Selecciona color de cursor o borrador(color de fondo)
barra:          .byte 0x20
#Teclas 1-8 : 8 colores distintos
tecla_0:        .ascii "0"
tecla_1:        .ascii "1"
tecla_2:        .ascii "2"
tecla_3:        .ascii "3"
tecla_4:        .ascii "4"
tecla_5:        .ascii "5"
tecla_6:        .ascii "6"
tecla_7:        .ascii "7"
tecla_8:        .ascii "8"
# Teclas a,s,d,w : Desplazamiento
izquierda:      .ascii "a"
abajo:          .ascii "s"
derecha:        .ascii "d"
arriba:        .ascii "w"

.text
                lwu $s0,CONTROL($0)
                lwu $s1,DATA($0)
                daddi $s2,$0,24 
                daddi $s3,$0,24 
                daddi $s4,$0,5 
                daddi $s5,$0,9 
                lwu $v0,color_fondo($0)
                lwu $a1,color_cursor($0)

                sw $a1,0($s1)
                sb $s2,4($s1)
                sb $s3,5($s1)
                sd $s4,0($s0)
loop:           sd $s5,0($s0)
                lbu $a0,0($s1)
                lbu $t0,tecla_1($0) 
                slt $t2,$a0,$t0
                bnez $t2,es_cero

                lbu $t0,tecla_8($0)
                daddi $t0,$t0,1
                slt $t2,$a0,$t0
                beqz $t2,es_direccion
es_color:       lbu $t0,tecla_1($0)
                daddi $t1,$0,8
                dsubu $a0,$a0,$t0
                dmulu $a0,$a0,$t1
                lwu $a1,color_1($a0) 
                j graficar 
es_direccion:   lbu $t0,izquierda($0)
                bne $t0,$a0,es_s
                daddi $s3,$s3,-1
                j graficar
es_s:           lbu $t0,abajo($0)
                bne $t0,$a0,es_d
                daddi $s2,$s2,-1
                j graficar
es_d:           lbu $t0,derecha($0)
                bne $t0,$a0,es_w
                daddi $s3,$s3,1
                j graficar
es_w:           lbu $t0,arriba($0)
                bne $t0,$a0,graficar
                daddi $s2,$s2,1
                j graficar
es_cero:        lbu $t0,tecla_0($0)
                bne $a0,$t0,es_barra
                j fin
es_barra:       lbu $t0,barra($0)
                bne $a0,$t0,es_cero
                dadd $a1,$0,$v0
graficar:       sw $a1,0($s1) 
                sb $s2,4($s1)
                sb $s3,5($s1)
                sd $s4,0($s0)
                j loop
fin:            halt