; Parking lot 
(define (domain parkingLot)

    (:requirements
        :durative-actions
        :equality
        :negative-preconditions
        :numeric-fluents
        :object-fluents
        :typing
    )

    (:types
        car loc - object road spot - loc
    )

    (:constants
        
    )

    (:predicates
        clear ?loc -loc
        at ?car - object ?loc - loc
    )

    (:functions
        
    )

    (:action park
        :parameters (?car - car ?from - road ?to - spot)
        :precondition (and (clear ?to) 
                           (at ?car ?from)
                           (adjacent ?from ?to)
        )
        :effect (and (not (clear ?to)
                          (at ?car ?from)
                     ) 
                     (clear ?from)
                     (at ?car ?to)
        )
    )
    
    (:action unpark
        :parameters (?car - car ?from - spot ?to - road)
        :precondition (and (clear ?to) 
                           (at ?car ?from)
                           (adjacent ?from ?to)
        )
        :effect (and (not (clear ?to)
                          (at ?car ?from)
                     ) 
                     (clear ?from)
                     (at ?car ?to)
        )
    )
    
    (:action move
        :parameters (?car - car ?from - road ?to - road)
        :precondition (and (clear ?to) 
                           (at ?car ?from)
                           (adjacent ?from ?to)
        )
        :effect (and (not (clear ?to-loc)
                          (at ?car ?from)
                     ) 
                     (clear ?from-loc)
                     (at ?car ?to)
        )
    )
)