(define (problem puerto_muy_facil)
	(:domain puerto)
	(:objects
		m1 m2 - muelle
		ct1 ct2 - cinta
		g1 g2 - grua
		p1 p2 - pila
		c1 c2 c3 - contenedor
		n2 n1 n0 - altura
)
	(:init
		(not_ocupada ct1)
		(not_ocupada ct2)	
		(notCinta ct2 m1)	
		(notCinta ct1 m2)
		(next n0 n1)
		(next n1 n2)
		
		; pilas gruas y cintas en muelles
		(in ct1 m1)
		(in g1 m1)
		(in p1 m1)
		(vacia g1)
		
		(in ct2 m2)
		(in g2 m2)
		(in p2 m2)
		(vacia g2)

		
		; contenedores en las pilas
		(at c1 p1)
		(at c2 p1)
		(on c2 p1)
		(on c1 c2)
		(top c1 p1)
		(altura_pila p1 n2)
		
		
		
		;; Comentar para pila vacia
		(at c3 p2)
		(on c3 p2)
		(top c3 p2)
		
		;; Descomentar para pila vacia
		(top p2 p2)
		(altura_pila p2 n0)
		
		
	)
	
	(:goal 
		(and 
			(top c1 p2)
		
		)
	)
)
