(define (problem puerto)
	(:domain puerto)
	(:objects
		m1,m2 - muelle
		ct1,ct2 - cinta
		g1,g2 - grua
		p11,p12,p13,p21,p22,p23 - pila
		c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11 - contenedor
		n3,n2,n1,n0 - altura
)
	(:init
	
		(not_ocupada ct1)
		(not_ocupada ct2)	
		(notCinta ct2 m1)	
		(notCinta ct1 m2)
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
		(at c1 p11)
		(at c7 p11)
		
		(on c1 p11)
		(on c7 c1)
		(top c7 p11)
		(altura_pila p11 n2)
		
		; ______ pila 2
		(at c9 p12)
		(at c10 p12)
		
		(on c9 p12)
		(on c10 c9)
		(top c10 p12)
		(altura_pila p12 n2)
		
		; ______ pila 3
		(at c11 p13)
		
		(on c11 p13)
		(top c11 p13)
		(altura_pila p12 n1)
		
		
		; ------ muelle 2

		; ______ pila 1
		(at c8 p21)
		(at c4 p21)
		
		(on c4 p21)
		(on c8 c4)
		(top c8 p21)
		(altura_pila p21 n2)
		
		; ______ pila 2
		(at c2 p22)
		(at c3 p22)
		(at c5 p22)		
	
		(on c5 p22)
		(on c3 c5)
		(on c2 c3)
		(top c2 p22)
		(altura_pila p22 n3)
		
		; ______ pila 3
		(at c6 p23)
		
		(on c6 p23)
		(top c6 p23)
		(altura_pila p23 n1)

		

		; Goals		
		(isgoal c3)
		(isgoal c4)	
		(isgoal c6)
		(isgoal c7)
	)
	
	(:goal 
		(and 
			(top c4 p11)
			(top c3 p12)
			(top c7 p11)
		)
	)
)
