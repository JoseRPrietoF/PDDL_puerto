(define (problem puerto)
	(:domain puerto)
	(:objects
		m1 - muelle
		ct1 - cinta
		g1 - grua
		p11,p12,p13 - pila
		c1,c2,c3,c4,c5- contenedor
)
	(:init
		;Definimos el peso de las cajas
		(= (peso c1) 1)(= (peso c2) 1)
		(= (peso c3) 1)(= (peso c4) 1)
		(= (peso c5) 1)
		
		;Definimos la altura de los muelles
		(=(maxaltura m1) 3)
		
		;Definimos la distancia y velocidad de las cintas
		(=(distancia  ct1) 10 )
		(=(velocidad ct1) 5)
		(not_ocupada ct1)
		
		; pilas gruas y cintas en muelles
		(in ct1 m1)
		(in g1 m1)
		(in p11 m1)
		(in p12 m1)
		(in p13 m1)
		(vacia g1)
		
		

		; contenedores en las pilas
		
		; ------ MUELLE 1
		; ______ PILA 1 ______
		(at c1 p11)
		(at c4 p11)
		; ______
		(on c1 p11)
		(on c4 c1)
		(top c4 m1)
		(=(altura p11) 2) 
		; ______ PILA 2 ______
		(at c2 p12)
		(at c15 p12)
		; ______
		(on c2 p12)
		(on c5 c9)
		(top c15 m1)
		(=(altura p12) 2) 
		; ______ PILA 3 ______
		(at c3 p13)
		; ______
		(on c3 p13)
		(top c3 m1)
		(=(altura p13) 1) 
		
		

		; Goals		
		(isgoal c1)
		(isgoal c2)	
		(isgoal c3)
	)
	
	(:goal 
		(and 
			(top c1 m1)
			(top c2 m1)
			(top c3 m1)
		)
	)
	(:metric minimize (total-time))
)
