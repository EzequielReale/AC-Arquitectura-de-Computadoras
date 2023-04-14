.data
tabla: .word 1,2,3,4,5,6,7,8,9,0
cant: .word 0
.text
daddi $sp, $0, 0x400
daddi $a0, $0, tabla
dadd $v1, $0, $0
jal numero
sd $v1, cant($0)
halt

numero: daddi $sp, $sp, -8
        sd $ra, 0($sp)
        loop: ld $t0, 0($a0)
              jal es_impar
              beqz $v0, es_par
              daddi $v1, $v1, 1
              es_par: daddi $a0, $a0, 8
                      bnez $t0, loop
                      ld $ra, 0($sp)
                      daddi $sp, $sp, 8
                      jr $ra
                      
es_impar: andi $v0, $t0, 1
          jr $ra