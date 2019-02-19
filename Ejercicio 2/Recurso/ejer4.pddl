(define (problem puerto)
	(:domain puerto)
	(:objects
		m1 m2 - muelle
		ct1 ct2 - cinta
		g1 g2 - grua
		p11 p12 p21 p22 - pila
		c1 c2 c3 c4 c5 - contenedor
)
	(:init
		(= (gasolina g1) 100)
		(= (gasolina g2) 100)
		(= (total-gas-used) 0)
		;Definimos el peso de las cajas
		(= (peso c1) 1)(= (peso c2) 1)
		(= (peso c3) 1)(= (peso c4) 1)
		(= (peso c5) 1)
		(not_cargando g1)
		(not_cargando g2)
		
		;Definimos la altura de los muelles
		(=(maxaltura m1) 3)
		(=(maxaltura m2) 2)
		
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
		(vacia g1)
		
		(in ct2 m2)
		(in g2 m2)
		(in p21 m2)
		(in p22 m2)
		(vacia g2)

		; contenedores en las pilas
		; ------ muelle 1

		; ______ pila 1
		(at c4 p11)
		(at c5 p11)
		
		(on c4 p11)
		(on c5 c4)
		(top c5 p11)
		(=(altura p11) 2) 
		
		; ______ pila 2
		
		(top p12 p12)
		(=(altura p12) 0) 
		
		; ------ muelle 2

		; ______ pila 1
		(at c1 p21)
		(on c1 p21)

		(top c1 p21)
		(=(altura p21) 1) 
		
		; ______ pila 2
		(at c2 p22)
		(at c3 p22)
	
		(on c3 p22)
		(on c2 c3)
		(top c2 p22)
		(=(altura p22) 2) 

		

		; Goals		
		(isgoal c3)
		(isgoal c4)	
		(isgoal c1)	
	)
	
	(:goal 
		(and 
			(top c4 p11)
			(top c1 p11)
			(top c3 p11)
		)
	)
	
	(:metric minimize (total-time))
	;(:metric minimize (total-gas-used))
)
