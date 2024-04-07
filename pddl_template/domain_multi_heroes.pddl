(define (domain MultiDangeon)

    (:requirements
        :typing
        :negative-preconditions
    )

    (:types
        swords cells heroes keys
    )

    (:predicates
        ;Hero's cell location
        (at-hero ?loc - cells ?h -heroes)
        
        ;Sword cell location
        (at-sword ?s - swords ?loc - cells)

        ;Key cell location
        (at-key ?k - keys ?loc - cells)
        
        ;Indicates if a cell location has a monster
        (has-monster ?loc - cells)
        
        ;Indicates if a cell location has a trap
        (has-trap ?loc - cells)
        
        ;Indicates if a cell, key or sword has been destroyed
        (is-destroyed ?obj)

        ;Indicates if a cell is locked
        (is-locked ?loc - cells)
        
        ;connects cells
        (connected ?from ?to - cells)
        
        ;Hero's hand is free
        (arm-free ?h -heroes)
        
        ;Hero's holding a sword
        (hold-sword ?s - swords ?h - heroes)

        ;Hero's holding a key
        (hold-key ?k - keys ?h - heroes)

        ;Hero already took their turn
        (turn-complete ?h - heroes)
        
    )

    ;Resets a turn
    (:action reset-turn
        :parameters (?from ?to - cells)
        :precondition (
            (forall (?hero - heroes) (turn-complete ?hero))      
        )
        :effect ( 
            (forall (?hero - heroes) (not (turn-complete ?hero)))      
                )
    )

    ;Hero can move if the
    ;    - hero is at current location
    ;    - cells are connected, 
    ;    - there is no trap in current loc, and 
    ;    - destination does not have a trap/monster/has-been-destroyed/locked
    ;    - hero's turn has not been taken
    ;Effects move the hero, and destroy the original cell. No need to destroy the sword.
    (:action move
        :parameters (?from ?to - cells ?hero - heroes)
        :precondition (and 
            (at-hero ?from ?hero)
            (connected ?from ?to)
            (not (has-trap ?from))
            (not (is-destroyed ?to))
            (not (has-trap ?to))
            (not (has-monster ?to))
            (not (is-locked ?to))
            (not (turn-complete ?hero))
        )
        :effect (and 
            (not (at-hero ?from ?hero))
            (at-hero ?to ?hero)
            (is-destroyed ?from)
            (turn-complete ?hero)
                )
    )
    
    ;When this action is executed, the hero gets into a location with a trap
    (:action move-to-trap
        :parameters (?from ?to - cells ?hero - heroes)
        :precondition (and 
            (at-hero ?from ?hero)
            (connected ?from ?to)
            (arm-free ?hero)
            (not (has-trap ?from))
            (not (is-destroyed ?to))
            (has-trap ?to)
            (not (turn-complete ?hero))       
        )
        :effect (and 
            (not (at-hero ?from ?hero))
            (at-hero ?to ?hero)
            (is-destroyed ?from)
            (turn-complete ?hero)
                )
    )

    ;When this action is executed, the hero gets into a location with a monster
    (:action move-to-monster
        :parameters (?from ?to - cells ?s - swords ?hero - heroes)
        :precondition (and 
            (at-hero ?from ?hero)
            (connected ?from ?to)
            (hold-sword ?s ?hero)
            (not (has-trap ?from))
            (not (is-destroyed ?to))
            (has-monster ?to)
            (not (turn-complete ?hero))
        )
        :effect (and 
            (not (at-hero ?from ?hero))
            (at-hero ?to ?hero)
            (is-destroyed ?from)                    
                )
    )

    ;When this action is executed, the hero gets into a location with a lock
    (:action move-to-lock
        :parameters (?from ?to - cells ?k - keys ?hero - heroes)
        :precondition (and 
            (at-hero ?from ?hero)
            (connected ?from ?to)
            (hold-key ?k ?hero)
            (not (has-trap ?from))
            (not (is-destroyed ?to))
            (is-locked ?to)
            (not (turn-complete ?hero))
        )
        :effect (and 
            (not (at-hero ?from ?hero))
            (at-hero ?to ?hero)
            (is-destroyed ?from)
            (turn-complete ?hero)
      )
    )
    
    ;Hero picks a sword if he's in the same location
    (:action pick-sword
        :parameters (?loc - cells ?s - swords ?hero - heroes)
        :precondition (and 
            (at-hero ?loc ?hero)
            (at-sword ?s ?loc)
            (arm-free ?hero)
            (not (turn-complete ?hero))
                      )
        :effect (and
            (not (at-sword ?s ?loc))
            (not (arm-free ?hero))
            (hold-sword ?s ?hero)
            (turn-complete ?hero)
                )
    )

    ;Hero picks a key if he's in the same location
    (:action pick-key
        :parameters (?loc - cells ?k - keys ?hero - heroes)
        :precondition (and 
            (at-hero ?loc ?hero)
            (at-key ?k ?loc)
            (arm-free ?hero)
            (not (turn-complete ?hero))
                      )
        :effect (and
            (not (at-key ?k ?loc))
            (not (arm-free ?hero))
            (hold-key ?k ?hero)
            (turn-complete ?hero)
                )
    )
    
    ;Hero destroys his sword. 
    (:action destroy-sword
        :parameters (?loc - cells ?s - swords ?hero - heroes)
        :precondition (and 
            (hold-sword ?s ?hero)
            (at-hero ?loc ?hero)
            (not (has-trap ?loc))
            (not (has-monster ?loc))      
            (not (turn-complete ?hero))
                      )
        :effect (and
            (not (hold-sword ?s))
            (arm-free)
            (turn-complete ?hero)
                )
    )

    ;Hero destroys his key. 
    (:action destroy-key
        :parameters (?loc - cells ?k - keys ?hero - heroes)
        :precondition (and 
            (hold-key ?k ?hero)
            (at-hero ?loc ?hero)
            (not (has-trap ?loc))
            (not (has-monster ?loc))    
            (not (turn-complete ?hero))  
                      )
        :effect (and
            (not (hold-key ?k))
            (arm-free)
            (turn-complete ?hero)
                )
    )
    
    ;Hero disarms the trap with his free arm
    (:action disarm-trap
        :parameters (?loc - cells ?hero -heroes)
        :precondition (and 
            (arm-free ?hero)
            (at-hero ?loc ?hero)
            (has-trap ?loc)
            (not (turn-complete ?hero))
                      )
        :effect (and
            (trap-disarmed ?loc)
            (not (has-trap ?loc))     
            (turn-complete ?hero)
                )
    )

    ;Hero gives sword to friend
    (:action give-sword
        :parameters (?loc - cells ?h1 ?h2 - heroes ?s - sword)
        :precondition (and
            (at-loc ?loc ?h1)
            (at-loc ?loc ?h2)
            (arm-free ?h2)
            (hold-sword ?s ?h1)
            (not (turn-complete ?hero))
                      )
        :effect (and
            (hold-sword ?s ?h2)
            (not (arm-free ?h2))
            (arm-free ?h1)
            (turn-complete ?hero)
                )
    )

    ;Hero gives key to friend
    (:action give-key
        :parameters (?loc - cells ?h1 ?h2 - heroes ?k - key)
        :precondition (and
            (at-loc ?loc ?h1)
            (at-loc ?loc ?h2)
            (arm-free ?h2)
            (hold-key ?k ?h1)
            (not (turn-complete ?hero))
                      )
        :effect (and
            (hold-key ?k ?h2)
            (not (arm-free ?h2))
            (arm-free ?h1)
            (turn-complete ?hero)
                )
    )
    (:action do-Nothing
        :parameters (?hero- heroes)
        :precondition (and
            (not (turn-complete ?hero))
                      )
        :effect (and
            (turn-complete ?hero)
                )
    )
    
    )
