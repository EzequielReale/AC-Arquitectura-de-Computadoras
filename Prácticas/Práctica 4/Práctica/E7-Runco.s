                       .data
          Tabla:       .word   1,4,5,6,6,8,2,2,9,10
          Res:         .word   0,0,0,0,0,0,0,0,0,0
          X:           .word   4
          Long:        .word  10
          Cant:        .word   0
                       
                       .code    
                  LD    R1, Long(R0)
                  LD    R2, X(R0)
                  DADD  R3, R0, R0
                  DADD  R5, R0, R0
                  DADDI R8, R0, 1
         SIGO:    LD    R4, Tabla(R3)
                  SLT   R6, R4, R2
                  BNEZ  R6, ES_MENOR
                  DSUB  R7, R4, R2
                  BEQZ  R7, ES_MENOR
                  SD    R8, Res(R3)
                  DADDI R5, R5, 1
      ES_MENOR:   DADDI R3, R3, 8
                  DADDI R1, R1, -1
                  BNEZ  R1, SIGO
                  SD    R5, Cant(R0)
                  HALT