(define (problem puerto)
	(:domain puerto)
	(:objects
		m1 m2 - muelle
		ct1 ct2 - cinta
		g1 g2 - grua
		p11 p12 p13 p21 p22 p23 - pila
		c11,c21,c31 - contenedor
		c12,c22,c32 - contenedor
		n3 n2 n1 n0 - altura
)
	(:init
		
		; pilas gruas y cintas en muelles
		(in ct1 m1)
		(in g1 m1)
		(in p11 m1)
		(in p12 m1)
		(in p13 m1)
		(vacia g1)
		
		
		(in ct2 m2)
		(in g2 m2)
		(in p21 m2)
		(in p22 m2)
		(in p23 m2)
		(vacia g2)

		(next n0 n1)
		(next n1 n2)
		(next n2 n3)
		
		; contenedores en las pilas
		; ------ muelle 1

		; ______ pila 1
		(at c11 p11)
		(at c21 p11)
		(at c31 p11)
		
		(on c11 p11)
		(on c21 c11)
		(on c31 c21)
		(top c31 p11)
		(altura p11 n3)
		
		; ______ pila 2
		(at c12 p12)
		(at c22 p12)
		
		(on c12 p12)
		(on c22 c12)
		(top c22 p12)
		(altura p12 n2)
		
		
		;p13
		(top p13 p13)
		(altura p13 n0)
		
		
	)
	
	(:goal 
		(and 
			(top c12 p11)
		
		)
	)
)
