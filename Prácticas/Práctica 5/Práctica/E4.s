.data
peso: .double 85.0
estatura: .double 1.8
IMC: .double 0.0
inf: .double 18.5
norm: .double 25
sobre: .double 30
estado: .word 0.0
.code
l.d f2, estatura(r0) ; f2 = estatura
mul.d f2, f2, f2 ; f2 = estatura2
l.d f1, peso(r0) ; f1 = peso
l.d f4, inf(r0) ; f4 = IMC inferior
l.d f5, norm(r0) ; f5 = IMC normal
l.d f6, sobre(r0) ; f6 = IMC sobrepeso
div.d f3, f1, f2 ; f3 = IMC
c.lt.d f4, f3
bc1f infrapeso
c.lt.d f5, f3
bc1f normal
c.lt.d f6, f3
bc1f sobrepeso
j obesidad
infrapeso: daddi r1, r0, 1
sd r1, estado(r0)
j fin
normal: daddi r1, r0, 2
sd r1, estado(r0)
j fin
sobrepeso: daddi r1, r0, 3
sd r1, estado(r0)
j fin
obesidad: daddi r1, r0, 4
sd r1, estado(r0)
fin: s.d f3, IMC(r0)
halt