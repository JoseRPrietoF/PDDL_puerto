(define (domain transporte)
	(:requirements :durative-actions :typing :fluents)
	(:types paquete camion driver ciudad -object)
	(:predicates
		(at ?x - (either paquete camion driver) ?c - ciudad)
		(in ?p - (either paquete driver) ?c - camion))
	(:functions
		(distance ?c1-ciudad ?c2-ciudad)
		(coste ?p-ciudad ?c2-ciudad)
		(coste-total))

	(:durative-action cargar
        :parameters (?p - paquete ?c - camion ?ciu - ciudad )
        :duration  (= ?duration 1)
        :condition (and (at start (at ?p ?ciu))
                    (over all (at ?c ?ciu)))
        :effect (and (at start (not(at ?p ?ciu)))
                (at end (in ?p ?c))
                (at end (increase (coste-total) 1))
                )
		)
        
    (:durative-action descargar
        :parameters (?p - paquete ?c - camion ?ciu - ciudad )
        :duration  (= ?duration 1)
        :condition (and (at start (in ?p ?c))
                    (over all(at ?c ?ciu)))
        :effect (and (at start (not(in ?p ?c)))
                (at end (at ?p ?ciu))
                (at end (increase (coste-total) 1))
                )
		)
        
    (:durative-action viajar
        :parameters (?d - driver ?c1 - ciudad ?c2 - ciudad)
        :duration  (= ?duration 10)
        :condition (at start (at ?d ?c1))
        :effect (and (at start (not(at ?d ?c1)))
                (at end (at ?d ?c2))
                (at end (increase (coste-total) 3))
                )
		)    
    
    (:durative-action coducir
        :parameters (?c - camion ?d - driver ?c1 - ciudad ?c2 - ciudad)
        :duration  (= ?duration (distance ?c1 ?c2))
        :condition (and (at start (at ?c ?c1)) (at start (in ?d ?c)))
        :effect (and (at start (not(at ?c ?c1)))
                (at end (at ?c ?c2))
                (at end (increase (coste-total) (coste ?c1 ?c2)))
                )
		) 
    
    (:durative-action subir
        :parameters (?c - camion ?d - driver ?ciu - ciudad)
        :duration  (= ?duration 1)
        :condition (and (at start (at ?c ?ciu))
					(at start (at ?d ?ciu)) )
        :effect (and (at start (not (at ?d ?ciu)))
                (at end (in ?d ?c))
                (at end (increase (coste-total) 1))
                )
		)
        
    (:durative-action bajar
        :parameters (?c -camion ?d -driver ?ciu - ciudad)
        :duration  (= ?duration 1)
        :condition (and (at start (in ?d ?c))
					(at start (at ?c ?ciu)) )
        :effect (and (at start (not(in ?d ?c)))
                (at end (at ?d ?ciu))
                (at end(increase (coste-total) 1))
                )
        )
)