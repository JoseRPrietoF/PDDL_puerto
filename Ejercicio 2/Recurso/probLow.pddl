(define (problem puerto)
	(:domain puerto)
	(:objects
		m1 m2 - muelle
		ct1 ct2 - cinta
		g1 g2 - grua
		p11 p12 p13 p21 p22 p23 - pila
		c1 c2 c3 c4 c5 - contenedor
)
	(:init
		(= (gasolina g1) 30)
		(= (gasolina g2) 30)
		(= (total-gas-used) 0)
		;Definimos el peso de las cajas
		(= (peso c1) 1)(= (peso c2) 1)
		(= (peso c3) 1)(= (peso c4) 1)
		(= (peso c5) 1)
		
		(not_cargando g1)
		(not_cargando g2)
		
		;Definimos la altura de los muelles
		(=(maxaltura m1) 3)
		(=(maxaltura m2) 3)
		
		;Definimos la distancia y velocidad de las cintas
		(=(distancia  ct1) 10 )
		(=(velocidad ct1) 5)
		(not_ocupada ct1)
		(=(distancia  ct2) 10 )
		(=(velocidad ct2) 5)
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
		
		; muelle 2
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
		(at c4 p11)
		; ______
		(on c1 p11)
		(on c4 c1)
		(top c4 p11)
		(=(altura p11) 2) 
		; ______ PILA 2 ______
		(at c2 p12)
		(at c5 p12)
		; ______
		(on c2 p12)
		(on c5 c2)
		(top c5 p12)
		(=(altura p12) 2) 
		; ______ PILA 3 ______
		(at c3 p13)
		; ______
		(on c3 p13)
		(top c3 p13)
		(=(altura p13) 1)
		
		; ------ MUELLE 2
		; ______ PILA 21 ______
		(top p21 p21)
		(=(altura p21) 0) 
		
		; ______ PILA 22 ______
		(top p22 p22)
		(=(altura p22) 0) 
		
		; ______ PILA 23 ______
		(top p23 p23)
		(=(altura p23) 0) 
		
		

		; Goals		
		(isgoal c1)
		(isgoal c2)	
		(isgoal c3)
	)
	
	(:goal 
		(and 
			(top c1 p11)
			(top c2 p12)
			(top c3 p11)
		)
	)
	;(:metric minimize (total-time))
	(:metric minimize (total-gas-used))
)
