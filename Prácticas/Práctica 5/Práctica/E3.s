.data
base: .double 5.85
altura: .double 13.47
superficie: .double 0.0
.code
l.d f1, base(r0) ; f1 = base
l.d f2, altura(r0) ; f2 = altura
mul.d f4, f1, f2
daddi r1, r0, 2
mtc1 r1, f5
cvt.d.l f3, f5 ; f3 = 2
div.d f4, f4, f3 ; f4 = superficie
s.d f4, superficie(r0)
halt