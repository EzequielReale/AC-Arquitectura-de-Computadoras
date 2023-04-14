                        .data
CONTROL: .word32  0x10000
DATA: .word32  0x10008
COLOR: .byte  255, 0, 255, 0
NEGA: .word    0x80000000
                        .code
              lwu      R24, DATA(R0)
              daddi   R2,  R0,  5
              lwu      R25,  CONTROL(R0)
              lwu      R9,   COLOR(R0)
;            
              daddi   R4,  R0,  9
              ld         R7,  NEGA(R0)
              daddi   R22,  R0,  32
              jal        ingre     ; subrutina que lee un número ingresado por teclado y verifica que sea un número
              jal        muestra   ; subrutina que dibuja el número en la terminal gráfica
              halt
;
ingre:        sd   R4, (R25)         ; R4=9 lectura de teclado
              lbu  R3, (R24)          ; R3 contiene el caracter de la tecla apretada
              daddi  R3, R3,  -0x30   ; resto 30h (ASCII)
              dadd  R5, R3, R0        ; trabajo sobre R5
              dsrlv   R21, R5, R22    ; quiero ver si el número es negativo, desplazo 32 porque el and con 64 no me funcionó
               and  R21,  R21, R7     ; si es negativo no es un número
              bnez  R21, ingre
              dadd  R5,  R3,  R0      ; si es positivo puede ser un número ó una letra
              daddi  R5,  R5,  - 10   ; como resto 10,ahora si es negativo (0.....9) es un número
              dsrlv    R21, R5, R22   
              and   R21, R21, R7
               beqz  R21, ingre
               jr   R31
;
muestra:      beq  R3, R0,  cero
                   daddi  R3,  R3, -1
                    ;beqz  R3,  uno
                    daddi  R3,  R3, -1
                    ;beqz  R3,  dos
                     daddi  R3,  R3, -1
                    ;beqz  R3,  tres
                    daddi  R3,  R3, -1
                    ;beqz  R3,  cuatro
                    daddi  R3,  R3, -1
                    ;beqz  R3,  cinco
                    daddi  R3,  R3, -1
                    ;beqz  R3,  seis
                     daddi  R3,  R3, -1
                    ;beqz  R3,  siete
                    daddi  R3,  R3, -1
                    beqz  R3,  ocho
                    daddi  R3,  R3,  -1
                    ;beqz  R3, nueve
;
ocho:      daddi  R10,  R0,  10
              sb       R10,  5(R24)
              daddi  R11,  R0,  16
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
             daddi  R10,  R0,  10
              sb       R10,  5(R24)
              daddi  R11,  R0, 17
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
              daddi  R10,  R0,  11
              sb       R10,  5(R24)
              daddi  R11,  R0,  18
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
              daddi  R10,  R0,  12
              sb       R10,  5(R24)
              daddi  R11,  R0,  18
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)             
;
              daddi  R10,  R0,  13
              sb       R10,  5(R24)
              daddi  R11,  R0,  18
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
               daddi  R10,  R0,  14
              sb       R10,  5(R24)
              daddi  R11,  R0,  16
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
             daddi  R10,  R0,  14
              sb       R10,  5(R24)
              daddi  R11,  R0, 17
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
              daddi  R10,  R0,  14
              sb       R10,  5(R24)
              daddi  R11,  R0,  14
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
             daddi  R10,  R0,  14
              sb       R10,  5(R24)
              daddi  R11,  R0, 13
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
              daddi  R10,  R0,  13
              sb       R10,  5(R24)
              daddi  R11,  R0,  12
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
             daddi  R10,  R0,  12
              sb       R10,  5(R24)
              daddi  R11,  R0, 12
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
              daddi  R10,  R0,  11
              sb       R10,  5(R24)
              daddi  R11,  R0, 12
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
             daddi  R10,  R0,  10
              sb       R10,  5(R24)
              daddi  R11,  R0, 13
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
              daddi  R10,  R0,  10
              sb       R10,  5(R24)
              daddi  R11,  R0, 14
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
 ;
              daddi  R10,  R0,  13
              sb       R10,  5(R24)
              daddi  R11,  R0, 15
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
             daddi  R10,  R0,  12
              sb       R10,  5(R24)
              daddi  R11,  R0, 15
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
              daddi  R10,  R0,  11
              sb       R10,  5(R24)
              daddi  R11,  R0, 15
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
              j          afuera
;
cero:     daddi  R10,  R0,  10
              sb       R10,  5(R24)
              daddi  R11,  R0,  16
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
             daddi  R10,  R0,  10
              sb       R10,  5(R24)
              daddi  R11,  R0, 17
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
              daddi  R10,  R0,  11
              sb       R10,  5(R24)
              daddi  R11,  R0,  18
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
              daddi  R10,  R0,  12
              sb       R10,  5(R24)
              daddi  R11,  R0,  18
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)             
;
              daddi  R10,  R0,  13
              sb       R10,  5(R24)
              daddi  R11,  R0,  18
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
               daddi  R10,  R0,  14
              sb       R10,  5(R24)
              daddi  R11,  R0,  16
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
             daddi  R10,  R0,  14
              sb       R10,  5(R24)
              daddi  R11,  R0, 17
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
              daddi  R10,  R0,  14
              sb       R10,  5(R24)
              daddi  R11,  R0,  14
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
             daddi  R10,  R0,  14
              sb       R10,  5(R24)
              daddi  R11,  R0, 13
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
              daddi  R10,  R0,  13
              sb       R10,  5(R24)
              daddi  R11,  R0,  12
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
             daddi  R10,  R0,  12
              sb       R10,  5(R24)
              daddi  R11,  R0, 12
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
              daddi  R10,  R0,  11
              sb       R10,  5(R24)
              daddi  R11,  R0, 12
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
             daddi  R10,  R0,  10
              sb       R10,  5(R24)
              daddi  R11,  R0, 13
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
              daddi  R10,  R0,  10
              sb       R10,  5(R24)
              daddi  R11,  R0, 14
              sb       R11,  4(R24)  
              sw      R9,   0(R24)
              sd       R2,   0(R25)
;
               j         afuera 
afuera:    jr        R31


