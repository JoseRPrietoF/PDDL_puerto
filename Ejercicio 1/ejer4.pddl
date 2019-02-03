(define (problem puerto)
	(:domain puerto)
	(:objects
		m1 m2 - muelle
		ct1 ct2 - cinta
		g1 g2 - grua
		p11 p12 p21 p22 - pila
		c1 c2 c3 c4 c5 - contenedor
		n2 n1 n0 - altura
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
		(vacia g1)
		
		(in ct2 m2)
		(in g2 m2)
		(in p21 m2)
		(in p22 m2)
		(vacia g2)

		(next n0 n1)
		(next n1 n2)
		
		; contenedores en las pilas
		; ------ muelle 1

		; ______ pila 1
		(at c4 p11)
		(at c5 p11)
		
		(on c4 p11)
		(on c5 c4)
		(top c5 m1)
		(altura_pila p11 n2)
		
		; ______ pila 2
		
		(top p12 m1)
		(altura_pila p12 n0)
		
		; ------ muelle 2

		; ______ pila 1
		(at c1 p21)
		(on c1 p21)

		(top c1 m2)
		(altura_pila p21 n1)
		
		; ______ pila 2
		(at c2 p22)
		(at c3 p22)
	
		(on c3 p22)
		(on c2 c3)
		(top c2 m2)
		(altura_pila p22 n2)

		

		; Goals		
		(isgoal c3)
		(isgoal c4)	
		(isgoal c1)	
	)
	
	(:goal 
		(and 
			(top c4 m1)
			(top c1 m1)
			(top c3 m1)
		)
	)
)
