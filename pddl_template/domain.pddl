(define (domain Dangeon)

    (:requirements
        :typing
        :negative-preconditions
    )

    (:types
        swords cells
    )

    (:predicates
        ;Hero's cell location
        (at-hero ?loc - cells)
        
        ;Sword cell location
        (at-sword ?s - swords ?loc - cells)
        
        ;Indicates if a cell location has a monster
        (has-monster ?loc - cells)
        
        ;Indicates if a cell location has a trap
        (has-trap ?loc - cells)
        
        ;Indicates if a cell or sword has been destroyed
        (is-destroyed ?obj)
        
        ;connects cells
        (connected ?from ?to - cells)
        
        ;Hero's hand is free
        (arm-free)
        
        ;Hero's holding a sword
        (holding ?s - swords)
    )

    ;Hero can move if the
    ;    - hero is at current location
    ;    - cells are connected, 
    ;    - there is no trap in current loc, and 
    ;    - destination does not have a trap/monster/has-been-destroyed
    ;Effects move the hero, and destroy the original cell. No need to destroy the sword.
    (:action move
        :parameters (?from ?to - cells)
        :precondition (and 
            (at-hero ?from)
            (connected ?from ?to)
            (not (has-trap ?from))
            (not (is-destroyed ?to))
            (not (has-trap ?to))
            (not (has-monster ?to))
        )
        :effect (and 
            (not (at-hero ?from))
            (at-hero ?to)
            (is-destroyed ?from)
                )
    )
    
    ;When this action is executed, the hero gets into a location with a trap
    (:action move-to-trap
        :parameters (?from ?to - cells)
        :precondition (and 
            (at-hero ?from)
            (connected ?from ?to)
            (arm-free)
            (not (has-trap ?from))
            (not (is-destroyed ?to))
            (has-trap ?to)       
        )
        :effect (and 
            (not (at-hero ?from))
            (at-hero ?to)
            (is-destroyed ?from)        
                )
    )

    ;When this action is executed, the hero gets into a location with a monster
    (:action move-to-monster
        :parameters (?from ?to - cells ?s - swords)
        :precondition (and 
            (at-hero ?from)
            (connected ?from ?to)
            (holding ?s)
            (not (has-trap ?from))
            (not (is-destroyed ?to))
            (has-monster ?to)
        )
        :effect (and 
            (not (at-hero ?from))
            (at-hero ?to)
            (is-destroyed ?from)                            
                )
    )
    
    ;Hero picks a sword if he's in the same location
    (:action pick-sword
        :parameters (?loc - cells ?s - swords)
        :precondition (and 
            (at-hero ?loc)
            (at-sword ?s ?loc)
            (arm-free)     
                      )
        :effect (and
            (not (at-sword ?s ?loc))
            (not (arm-free))
            (holding ?s)
                )
    )
    
    ;Hero destroys his sword. 
    (:action destroy-sword
        :parameters (?loc - cells ?s - swords)
        :precondition (and 
            (holding ?s)
            (at-hero ?loc)
            (not (has-monster ?loc))      
                      )
        :effect (and
            (not (holding ?s))
            (arm-free)
                )
    )
    
    ;Hero disarms the trap with his free arm
    (:action disarm-trap
        :parameters (?loc - cells)
        :precondition (and 
            (arm-free)
            (at-hero ?loc)
                      )
        :effect (and
            (not (has-trap ?loc))     
                )
    )
    
)