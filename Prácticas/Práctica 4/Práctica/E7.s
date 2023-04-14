.data
tabla: .word 8,9,5,7,3,2,6,4,1,10
x: .word 5
cant: .word 0
res: .word 0
.code
ld r5,x(r0) ; x
daddi r4,r0,10 ; cantidad de elementos
dadd r6,r0,r0 ; desplazamiento
daddi r2,r0,0 ;cant
daddi r3,r0,1 ; poner en res r3 o r0
loop: ld r1,tabla(r6)
      slt r8,r5,r1
      bnez r8,es_mayor
      sd r0,res(r6)
      j sigo
      es_mayor: daddi r2,r2,1
                sd r3,res(r6)
      sigo: daddi r4,r4,-1
            daddi r6,r6,8 
            bnez r4,loop
sd r2,cant(r0)
halt