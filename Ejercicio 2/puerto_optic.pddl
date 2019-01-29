(define (domain puerto)
	(:requirements :typing :fluents :durative-actions)
	(:types muelle contenedor grua pila cinta - object)
	
	(:predicates (in  ?p - (either pila grua cinta) ?m - muelle) ; control
				 (notCinta  ?ct - cinta ?m - muelle)
				 (at  ?c - contenedor ?x - (either pila cinta)) ; esta en
				 (top ?c - (either pila contenedor) ?m - pila) ; esta arriba del todo
				 (on ?c - contenedor ?p - (either pila contenedor)) ; encima de
				 (ocupada ?ct - cinta)
				 (not_ocupada ?ct - cinta)
				 (vacia ?g - grua)
				 (not_vacia ?g - grua)
				 (holding ?g - grua ?c - contenedor)
				 (disponible ?c - contenedor)
				 (isgoal ?c - contenedor)
	)
	
	(:functions (peso ?c - contenedor) ;Control del peso de la caja C
				(maxaltura ?m - muelle) ;Control de la altura maxima permitida de una muelle
				(altura ?p - pila) ;Control de altura en la pila
				(distancia  ?ct - cinta) ;Control de la distancia de la cinta
				(velocidad ?ct - cinta) ;Control de la velocidad de la cinta
	)

	
			 
	(:durative-action coger
        :parameters (?base - (either pila contenedor) ?c - contenedor ?p - pila ?m - muelle ?g - grua)
		:duration (= ?duration (-(*(peso ?c) (maxaltura ?m)) (*(peso ?c) (altura?p)) ))
        :condition (and
						(over all	(in ?p ?m)) ;Si las pilas estan en el mismo muelle
						(over all	(in ?g ?m)) ;Si la grua estan en el mismo muelle
						(over all	(top ?c ?p)) ;Si el  contenedor esta en el tope de la pila de origen
						(over all	(on ?c ?base)) ; seleccionamos lo que hay debajo para cambiar despues
						(at start	(vacia ?g)) ; grua esta libre
						(over all	(>= (maxaltura ?m) (altura ?p) ) ) ;comprobacion de la altura de la pila
						(over all   (>= (altura ?p) 1) )
					)
        :effect (and
				   (at end 		(not(vacia ?g)))
				   (at end 		(not_vacia ?g))
				   (at end 		(not(top ?c ?p)))
				   (at start 	(not(on ?c ?base)))
				   (at start 	(not (at ?c ?p)))
				   (at end 		(top ?base ?p))
				   (at start 	(holding ?g ?c))
				   (at start 	(not(vacia ?g)))
				   (at end   	(decrease (altura ?p) 1 ))
				)
	)
	
	(:durative-action soltar
        :parameters (?base - (either pila contenedor) ?c - contenedor ?p - pila ?m - muelle ?g - grua)
		:duration (= ?duration (-(*(peso ?c) (maxaltura ?m)) (*(peso ?c) (altura?p)) ))
        :condition (and 
						(over all	(in ?p ?m)) ;Si las pilas estan en el mismo muelle
						(over all	(in ?g ?m)) ;Si las pilas estan en el mismo muelle
						(over all	(top ?base ?p)) ; escogemos el contenedr dell top
						(over all	(holding ?g ?c)) ; grua tiene c
						(over all	(>= (maxaltura ?m) (altura ?p) ) ) ;comprobacion de la altura de la pila
						(over all   (>= (altura ?p) 1) )
						(at start 	(not_vacia ?g))
					)
        :effect ( and
				   (at end(vacia ?g))
				   (at end(not(not_vacia ?g)))
				   (at start(not (holding ?g ?c)))
				   (at start(at ?c ?p))
				   (at start(on ?c ?base))
				   (at end (top ?c ?p))
				   (at end (not (top ?base ?p)))
				   (at end (increase (altura ?p) 1))
				)
	)
	
	(:durative-action solta_especial
        :parameters (?base - (either pila contenedor) ?c - contenedor ?p - pila ?m - muelle ?g - grua)
		:duration (= ?duration (-(*(peso ?c) (maxaltura ?m)) (*(peso ?c) (altura?p)) ))
        :condition (and
						(over all(in ?p ?m)) ;Si las pilas estan en el mismo muelle
						(over all(in ?g ?m)) ;Si las pilas estan en el mismo muelle
						(over all(isgoal ?c)) ; si la base es goal
						(over all(top ?base ?p)) ; escogemos el contenedr dell top
						(over all(holding ?g ?c)) ; grua tiene c
						(over all	(>= (maxaltura ?m) (altura ?p) ) ) ;comprobacion de la altura de la pila
						(over all   (>= (altura ?p) 1) )
						(at start 	(not_vacia ?g))
					)
        :effect (and
				   (at end		(vacia ?g))
				   (at end		(not(not_vacia ?g)))
				   (at start	(not (holding ?g ?c)))
				   (at start	(at ?c ?p))
				   (at start	(top ?c ?p))
				   (at start	(on ?c ?base))
				   (at end		(increase (altura ?p) 1))
				)
	)
	
	(:durative-action coger_desde_cinta
        :parameters (?c - contenedor ?ct - cinta ?m - muelle ?g - grua)
		:duration (= ?duration (+ (/ (distancia ?ct) (velocidad ?ct)) (peso ?c))); tiempo en recorrer la cinta + el tiempo de cogerla
        :condition (and 
						(over all (in ?g ?m)) ; La grua esta en el mismo muelle
						(over all (at ?c ?ct)) ; el contenedor esta en la cinta
						(over all (notCinta ?ct ?m)) ; y no es la cinta de tu muelle
						(over all (ocupada ?ct))
						(at start (vacia ?g))
					)
        :effect ( and
					(at start   (not(vacia ?g)))
					(at end		(not_vacia ?g))
					(at start   (not_ocupada ?ct)) ; la cinta pasa a estar no ocupada
					(at start   (not(ocupada ?ct)))
					(at start   (holding ?g ?c))
					(at start   (not(vacia ?g)))
					(at start   (not(at ?c ?ct))) ; El contenedor ya no esta en la cinta
				)
	)
	
	(:durative-action mover_a_cinta
        :parameters (?c - contenedor ?ct - cinta ?m - muelle ?g - grua)
		:duration (= ?duration (+ (/ (distancia ?ct) (velocidad ?ct)) (peso ?c))) ; tiempo en recorrer la cinta + el tiempo de cogerla
        :condition (and 
						(over all (in ?ct ?m)) ; Si el muelle y la cinta se corresponden
						(over all (in ?g ?m)) ; La grua esta en el mismo muelle
						(at start (not_ocupada ?ct)) ; la cinta no esta ocupada
						(over all (holding ?g ?c)) ; grua tiene c
						(at start (not_vacia ?g))
					)
        :effect (and
					(at start	(at ?c ?ct)) ; el contenedor pasa a estar en la cinta
					(at end		(ocupada ?ct)) ; la cinta pasa a estar ocupada
					(at end		(not(not_ocupada ?ct)))
					(at end		(not(holding ?g ?c)))
					(at end		(vacia ?g))
					(at end		(not(not_vacia ?g)))
				)
	)
		
        
)
