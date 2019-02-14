(define (domain puerto)
	(:requirements :typing)
	(:types muelle contenedor grua pila cinta altura -object)
	
	(:predicates (in  ?p - (either pila grua cinta) ?m - muelle) ; control
				 (notCinta  ?ct - cinta ?m - muelle)
				 (at  ?c - contenedor ?x - (either pila cinta)) ; esta en
				 (top ?c - (either pila contenedor) ?m - pila) ; esta arriba del todo
				 (on ?c - contenedor ?p - (either pila contenedor)) ; encima de
				 (ocupada ?ct - cinta)
				 (not_ocupada ?ct - cinta)
				 (vacia ?g - grua)
				 (holding ?g - grua ?c - contenedor)
				 (isgoal ?c - contenedor)
				 (altura_pila ?p - pila ?n - altura)
				 (next ?alt -altura ?sigalt - altura)
	)
				 
	(:action coger
        :parameters (?base - (either pila contenedor) ?c - contenedor ?p1 - pila ?m - muelle ?g - grua  ?antalt - altura ?alt - altura )
        :precondition (and 
						(in ?p1 ?m) ;Si las pilas estan en el mismo muelle
						(in ?g ?m) ;Si la grua estan en el mismo muelle
						(top ?c ?p1) ;Si el  contenedor esta en el tope de la pila de origen
						(on ?c ?base) ; seleccionamos lo que hay debajo para cambiar despues
						(vacia ?g) ; grua esta libre
						(altura_pila ?p1 ?alt) ;comprobamos la altura
						(next ?antalt ?alt)  ; comprobamos el maximo de la pila
					)
        :effect ( and   
					   (not(vacia ?g))
					   (not(top ?c ?p1))
					   (not(on ?c ?base))
					   (not (at ?c ?p1))
					   (top ?base ?p1)
					   (holding ?g ?c)
					   (altura_pila ?p1 ?antalt)
					   (not (altura_pila ?p1 ?alt))
				)
	)
	
	(:action soltar
        :parameters (?base - (either pila contenedor) ?c - contenedor ?p1 - pila ?m - muelle ?g - grua ?alt - altura ?sigalt - altura)
        :precondition (and 
						(in ?p1 ?m) ;Si las pilas estan en el mismo muelle
						(in ?g ?m) ;Si las pilas estan en el mismo muelle
						(top ?base ?p1) ; escogemos el contenedr dell top
						(holding ?g ?c) ; grua tiene c
						(altura_pila ?p1 ?alt) ;comprobamos la altura
						(next ?alt ?sigalt)  ; comprobamos el maximo de la pila
					)
        :effect ( and   
					   (vacia ?g)
					   (not (holding ?g ?c))
					   (at ?c ?p1)
					   (top ?c ?p1)
					   (on ?c ?base)
					   (not (top ?base ?p1))
					   (not (altura_pila ?p1 ?alt))
					   (altura_pila ?p1 ?sigalt)
				)
	)
	
	(:action solta_especial
        :parameters (?base - contenedor ?c - contenedor ?p1 - pila ?m - muelle ?g - grua ?alt - altura ?sigalt - altura)
        :precondition (and 
						(in ?p1 ?m) ;Si las pilas estan en el mismo muelle
						(in ?g ?m) ;Si las pilas estan en el mismo muelle
						(isgoal ?c) ; si la base es goal
						(isgoal ?base) ; si la base es goal
						(top ?base ?p1) ; escogemos el contenedr dell top
						(holding ?g ?c) ; grua tiene c
						(altura_pila ?p1 ?alt) ;comprobamos la altura
						(next ?alt ?sigalt)  ; comprobamos el maximo de la pila
					)
        :effect ( and   
					   (vacia ?g)
					   (not (holding ?g ?c))
					   (at ?c ?p1)
					   (top ?c ?p1)
					   (on ?c ?base)
					   (not (altura_pila ?p1 ?alt))
					   (altura_pila ?p1 ?sigalt)
				)
	)
	
	(:action coger_desde_cinta
        :parameters (?c - contenedor ?ct - cinta ?m - muelle ?g - grua)
        :precondition (and
						(in ?g ?m) ; La grua esta en el mismo muelle
						(at ?c ?ct) ; el contenedor esta en la cinta
						(notCinta ?ct ?m) ; y no es la cinta de tu muelle
						(vacia ?g)
					)
        :effect ( and  
						(not(vacia ?g))
						(not_ocupada ?ct) ; la cinta pasa a estar no ocupada
						(holding ?g ?c)
						(not(at ?c ?ct)) ; El contenedor ya no esta en la cinta
				)
	)
	
	(:action mover_a_cinta
        :parameters (?c - contenedor ?ct - cinta ?m - muelle ?g - grua)
        :precondition (and 
						(in ?ct ?m) ; Si el muelle y la cinta se corresponden
						(in ?g ?m) ; La grua esta en el mismo muelle
						(not_ocupada ?ct) ; la cinta no esta ocupada
						(holding ?g ?c) ; grua tiene c
					)
        :effect (and
					(at ?c ?ct) ; el contenedor pasa a estar en la cinta
					(ocupada ?ct) ; la cinta pasa a estar ocupada
					(not(holding ?g ?c))
					(vacia ?g)
				)
	)
		
        
)
