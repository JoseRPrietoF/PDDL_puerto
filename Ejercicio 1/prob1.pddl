(define (problem puerto_muy_facil2)
	(:domain puerto)
	(:objects
		m1 m2 - muelle
		ct1 ct2 - cinta
		g1 g2 - grua
		p11 p12 p13 p21 p22 p23 - pila
		c1,c2,c3 - contenedor
		n2 n1 n0 - object
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
		
		; contenedores en las pilas
		; ------ muelle 1
		;p11
		(at c1 p11)
		(at c2 p11)
		
		(on c1 p11)
		(on c2 c1)
		(top c2 p11)
		
		
		
		
		;p12
		(top p12 p12)
		
		
		
		;p13
		(top p13 p13)
		
		
		
		
		
		
		; ------- muelle 2
		;p21
		(at c3 p21)
		
		(on c3 p21)
		(top c3 p21)
		
		;p22
		(top p22 p22)
		
		;p23
		(top p23 p23)
		
		
	)
	
	(:goal 
		(and 
			(top c1 p21)
		
		)
	)
)
