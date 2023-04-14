.data
a: .word 2
x: .word 2
y: .word 3
.code
ld r3,a(r0)
ld r1,x(r0)
ld r2,y(r0)
while: daddi r3,r3,-1
       dadd r1,r1,r2  
       bnez r3,while
sd r1,x(r0)
sd r3,a(r0)
halt