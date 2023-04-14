.data
CONTROL: .word32  0x10000
DATA: .word32  0x10008
config: .byte 0,255,0,0,5,5 
.text
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)

daddi $sp, $0, 0x400

jal ingre
dadd $a0, $0, $v0
jal ingre
dadd $a1, $0, $v0

jal rectangulo
halt


ingre:  daddi $t0, $0, 8
        sd $t0, 0($s0)
        lbu $v0, 0($s1)
        jr $ra

rectangulo: daddi $sp, $sp, -16
            sd $a0, 8($sp)
            sd $a1, 0($sp) ; apilo los valores de a para volverlos a usar más adelante

            ld $t0, config($0) ; $t0 tiene el color y coordenadas
            sd $t0, 0($s1) ; guardo la config en data
            
            lbu $t2, 4($s1) ; tomo la coordenada y inicial
            

            vertical: daddi $t1, $0, 5
                      sd $t1, 0($s0) ; imprime
                      daddi $a0, $a0, -1 ; decrementa el contador
                      daddi $t2, $t2, 1
                      sb $t2, 4($s1) ; incrementa y - lo almacena en data
                      bnez $a0, vertical

            lbu $t2, 5($s1) ; tomo la coordenada x inicial

            horizontal: daddi $t1, $0, 5
                        sd $t1, 0($s0) ; imprime
                        daddi $a1, $a1, -1 ; decrementa el contador
                        daddi $t2, $t2, 1
                        sb $t2, 5($s1) ; incrementa x - lo almacena en data
                        bnez $a1, horizontal

            ld $a1, 0($sp)
            ld $a0, 8($sp)
            daddi $sp, $sp, 16 ; desapilo los valores de a para usarlos ahora

            lbu $t2, 4($s1) ; tomo la coordenada y inicial

            vertical2: daddi $t1, $0, 5
                      sd $t1, 0($s0) ; imprime
                      daddi $a0, $a0, -1 ; decrementa el contador
                      daddi $t2, $t2, -1
                      sb $t2, 4($s1) ; incrementa y - lo almacena en data
                      bnez $a0, vertical2

            lbu $t2, 5($s1) ; tomo la coordenada x inicial

            horizontal2: daddi $t1, $0, 5
                        sd $t1, 0($s0) ; imprime
                        daddi $a1, $a1, -1 ; decrementa el contador
                        daddi $t2, $t2, -1
                        sb $t2, 5($s1) ; incrementa x - lo almacena en data
                        bnez $a1, horizontal2
            jr $ra