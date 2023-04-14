.data
CONTROL: .word32  0x10000
DATA: .word32  0x10008
tabla: .double 0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0
tabla2: .double 0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0
fin: .byte 0
.text
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)                                       ; cargo control y data

jal ingresar

daddi $a0, $0, tabla                                    ; a0 = direccion tabla
daddi $a1, $0, tabla2                                   ; a1 = direccion tabla2
jal promedio

jal imprimir
halt

ingresar: daddi $t1, $0, tabla                          ; t1 = direccion tabla
          daddi $t2, $0, tabla2                         ; t2 = direccion tabla2
          daddi $t0, $0, 8                              ; 8 para pedir ingresar un número
          loopIngre: sd $t0, 0($s0)                     ; pongo el 8 en control
                     l.d f1, 0($s1)                     ; tomo el numero de data
                     s.d f1, 0($t1)                     ; pongo el numero en tabla
                     daddi $t1, $t1, 8                  ; avanzo una posición
                     bne $t1, $t2, loopIngre            ; si la dirección no es igual que la de tabla 2 sigo
          jr $ra

promedio: dadd $t1, $0, $a0                             ; t1 = direccion tabla
          dadd $t2, $0, $a1                             ; t2 = direccion tabla2
          daddi $t3, $0, 2                              ; t3 = 2
          mtc1 $t3, f3                                  ; pongo el 2 en un registro de punto flotante para hacer la división
          cvt.d.l f3, f3                                ; convierto el 2 en flotante
          daddi $t3, $0, fin                            ; t3 = direccion fin
          loopProm: l.d f1, 0($t1)                      ; cargo un número del arreglo en f1
                    l.d f2, 8($t1)                      ; cargo el que sigue en f2
                    add.d f1, f1, f2                    ; los sumo
                    div.d f1, f1, f3                    ; los divido por 2 para hacer el promedio
                    daddi $t1, $t1, 8                   ; avanzo en tabla
                    s.d f1, 0($t2)                      ; guardo el promedio en tabla2
                    daddi $t2, $t2, 8                   ; avanzo en tabla 2
                    bne $t2, $t3, loopProm              ; si tabla 2 no llegó al final sigo
          jr $ra

imprimir: dadd $t1, $0, $a1                             ; t1 = direccion tabla
          daddi $t0, $0, 3                              ; 3 para imprimir un número en coma flotante
          daddi $t2, $0, fin                            ; t2 = direccion fin
          loopImprimir: l.d f1, 0($t1)                  ; cargo el número de tabla 2
                        s.d f1, 0($s1)                  ; pongo el número en data
                        daddi $t1, $t1, 8               ; avanzo 1 posición en tabla2
                        sd $t0, 0($s0)                  ; pongo el 3 en control
                        bne $t1, $t2, loopImprimir      ; si la dirección no es igual a fin sigo
          jr $ra 