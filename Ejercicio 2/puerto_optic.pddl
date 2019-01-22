(define (domain puerto)
	(:requirements :typing :fluents :durative-actions)
	(:types muelle contenedor grua pila cinta - object)
	
	(:predicates (in  ?p - (either pila grua cinta) ?m - muelle) ; control
				 (notCinta  ?ct - cinta ?m - muelle)
				 (at  ?c - contenedor ?x - (either pila cinta)) ; esta en
				 (top ?c - (either pila contenedor) ?m - muelle) ; esta arriba del todo
				 (on ?c - contenedor ?p - (either pila contenedor)) ; encima de
				 (ocupada ?ct - cinta)
				 (not_ocupada ?ct - cinta)
				 (vacia ?g - grua)
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
						(at start	(in ?p ?m)) ;Si las pilas estan en el mismo muelle
						(at start	(in ?g ?m)) ;Si la grua estan en el mismo muelle
						(at start	(top ?c ?m)) ;Si el  contenedor esta en el tope de la pila de origen
						(at start	(on ?c ?base)) ; seleccionamos lo que hay debajo para cambiar despues
						(at start	(vacia ?g)) ; grua esta libre
						(at start	(>= (maxaltura ?m) (altura ?p) ) ) ;comprobacion de la altura de la pila
						(at start   (>= (altura ?p) 1) )
					)
        :effect (and
				   (at start(not(vacia ?g)))
				   (at start(not(top ?c ?m)))
				   (at start(not(on ?c ?base)))
				   (at start(not (at ?c ?p)))
				   (at start(top ?base ?m))
				   (at start(holding ?g ?c))
				   (at end(decrease (altura ?p) 1 ))
				)
	)
	
	(:durative-action soltar
        :parameters (?base - (either pila contenedor) ?c - contenedor ?p - pila ?m - muelle ?g - grua)
		:duration (= ?duration (-(*(peso ?c) (maxaltura ?m)) (*(peso ?c) (altura?p)) ))
        :condition (and
						(at start(in ?p ?m)) ;Si las pilas estan en el mismo muelle
						(at start(in ?g ?m)) ;Si las pilas estan en el mismo muelle
						(at start(top ?base ?m)) ; escogemos el contenedr dell top
						(at start(holding ?g ?c)) ; grua tiene c
						(at start	(>= (maxaltura ?m) (altura ?p) ) ) ;comprobacion de la altura de la pila
						(at start   (>= (altura ?p) 1) )
					)
        :effect ( and
				   (at start(vacia ?g))
				   (at start(not (holding ?g ?c)))
				   (at start(at ?c ?p))
				   (at start(top ?c ?m))
				   (at start(on ?c ?base))
				   (at start(not (top ?base ?m)))
				   (at end(increase (altura ?p) 1))
				)
	)
	
	(:durative-action solta_especial
        :parameters (?base - (either pila contenedor) ?c - contenedor ?p - pila ?m - muelle ?g - grua)
		:duration (= ?duration (-(*(peso ?c) (maxaltura ?m)) (*(peso ?c) (altura?p)) ))
        :condition (and
						(at start(in ?p ?m)) ;Si las pilas estan en el mismo muelle
						(at start(in ?g ?m)) ;Si las pilas estan en el mismo muelle
						(at start(isgoal ?c)) ; si la base es goal
						(at start(top ?base ?m)) ; escogemos el contenedr dell top
						(at start(holding ?g ?c)) ; grua tiene c
						(at start	(>= (maxaltura ?m) (altura ?p) ) ) ;comprobacion de la altura de la pila
						(at start   (>= (altura ?p) 1) )
					)
        :effect (and
				   (at start(vacia ?g))
				   (at start(not (holding ?g ?c)))
				   (at start(at ?c ?p))
				   (at start(top ?c ?m))
				   (at start(on ?c ?base))
				   (at end(increase (altura ?p) 1))
				)
	)
	
	(:durative-action coger_desde_cinta
        :parameters (?c - contenedor ?ct - cinta ?m - muelle ?g - grua)
		:duration (= ?duration (+ (/ (distancia ?ct) (velocidad ?ct)) (peso ?c))); tiempo en recorrer la cinta + el tiempo de cogerla
        :condition (and
						(at start(in ?g ?m)) ; La grua esta en el mismo muelle
						(at start(at ?c ?ct)) ; el contenedor esta en la cinta
						(at start(notCinta ?ct ?m)) ; y no es la cinta de tu muelle
						(at start(ocupada ?ct))
						(at start(vacia ?g))
					)
        :effect ( and
					(at start(not(vacia ?g)))
					(at start(not_ocupada ?ct)) ; la cinta pasa a estar no ocupada
					(at start(not(ocupada ?ct)))
					(at start(holding ?g ?c))
					(at start(not(at ?c ?ct))) ; El contenedor ya no esta en la cinta
				)
	)
	
	(:durative-action mover_a_cinta
        :parameters (?c - contenedor ?ct - cinta ?m - muelle ?g - grua)
		:duration (= ?duration (+ (/ (distancia ?ct) (velocidad ?ct)) (peso ?c))) ; tiempo en recorrer la cinta + el tiempo de cogerla
        :condition (and
						(at start(in ?ct ?m)) ; Si el muelle y la cinta se corresponden
						(at start(in ?g ?m)) ; La grua esta en el mismo muelle
						(at start(not_ocupada ?ct)) ; la cinta no esta ocupada
						(at start(holding ?g ?c)) ; grua tiene c
					)
        :effect (and
					(at start(at ?c ?ct)) ; el contenedor pasa a estar en la cinta
					(at start(ocupada ?ct)) ; la cinta pasa a estar ocupada
					(at start(not(not_ocupada ?ct)))
					(at start(not(holding ?g ?c)))
					(at start(vacia ?g))
				)
	)
		
        
)
