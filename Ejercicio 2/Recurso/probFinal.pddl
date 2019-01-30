(define (problem puerto)
	(:domain puerto)
	(:objects
		m1 m2 - muelle
		ct1 ct2 - cinta
		g1 g2 - grua
		p11 p12 p13 p21 p22 p23 - pila
		c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 - contenedor
)
	(:init
		(= (gasolina g1) 15)
		(= (gasolina g2) 15)
		(= (total-gas-used) 0)
		;Definimos el peso de las cajas
		(= (peso c1) 1)(= (peso c2) 1)
		(= (peso c3) 1)(= (peso c4) 1)
		(= (peso c5) 1)(= (peso c6) 1)
		(= (peso c7) 1)(= (peso c8) 1)
		(= (peso c9) 1)(= (peso c10) 1)
		(= (peso c11) 1)
		
		(not_cargando g1)
		(not_cargando g2)
		
		;Definimos la altura de los muelles
		(=(maxaltura m1) 3)
		(=(maxaltura m2) 3)
		
		;Definimos la distancia y velocidad de las cintas
		(=(distancia  ct1) 10 )
		(=(distancia  ct2) 10 ) 
		(=(velocidad ct1) 5)
		(=(velocidad ct2) 5)
	
	
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
		

		; contenedores en las pilas
		
		; ------ MUELLE 1
		; ______ PILA 1 ______
		(at c1 p11)
		(at c7 p11)
		; ______
		(on c1 p11)
		(on c7 c1)
		(top c7 p11)
		(=(altura p11) 2) 
		; ______ PILA 2 ______
		(at c9 p12)
		(at c10 p12)
		; ______
		(on c9 p12)
		(on c10 c9)
		(top c10 p12)
		(=(altura p12) 2) 
		; ______ PILA 3 ______
		(at c11 p13)
		; ______
		(on c11 p13)
		(top c11 p13)
		(=(altura p13) 1) 
		
		
		; ------ MUELLE 2
		; ______ PILA 1
		(at c8 p21)
		(at c4 p21)
		; ______
		(on c4 p21)
		(on c8 c4)
		(top c8 p21)
		(=(altura p21) 2) 
		; ______ PILA 2
		(at c2 p22)
		(at c3 p22)
		(at c5 p22)		
		; ______
		(on c5 p22)
		(on c3 c5)
		(on c2 c3)
		(top c2 p22)
		(=(altura p22) 3) 
		; ______ PILA 3
		(at c6 p23)
		; ______
		(on c6 p23)
		(top c6 p23)
		(=(altura p23) 1) 
		

		; Goals		
		(isgoal c3)
		(isgoal c4)	
		(isgoal c7)
	)
	
	(:goal 
		(and 
			(top c4 p12)
			(top c3 p13)
			(top c7 p23)
			(vacia g1)
			(vacia g2)
			(not_ocupada ct1)
			(not_ocupada ct2)
		)
	)
	;(:metric minimize (total-gas-used))
	(:metric minimize (total-time))
)
