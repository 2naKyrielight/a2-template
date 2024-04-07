;It's recommended to install the misc-pddl-generators plugin 
;and then use Network generator to create the graph
(define (problem p3-dangeon)
  (:domain Dangeon)
  (:objects
            cell11 cell12 cell13 cell14 cell15 cell21 cell22 cell23 cell24 cell25 cell31 cell32 cell33 cell34 cell35 cell41 cell42 cell43 cell44 cell45 - cells
            sword1 sword2 - swords
            key1 key2 - keys
            h1 h2 - heroes
  )
  (:init

    ;Initial Hero Location
        (at-hero cell45 h1)  
        (at-hero cell41 h2)    
    
    ;He starts with a free arm
        (arm-free)
    
    ;Initial location of the swords
        (at-sword sword1 cell23)
        (at-sword sword2 cell34)

    ;Initial location of the keys
        (at-key key1 cell21)
        (at-key key2 cell44)
       
    ;Initial location of Monsters
        (has-monster cell13)
        (has-monster cell22)
        (has-monster cell24)
    
    ;Initial location of Traps
        (has-trap cell23)
        (has-trap cell32)
        (has-trap cell43)

    ;Initial locked rooms
        (is-locked cell12)
        (is-locked cell31)
        (is-locked cell33)
        (is-locked cell35)

    ;Graph Connectivity
        (connected cell11 cell12)
        (connected cell12 cell11)

        (connected cell12 cell13)
        (connected cell13 cell12)

        (connected cell13 cell14)
        (connected cell14 cell13)

        (connected cell14 cell15)
        (connected cell15 cell14)

        (connected cell21 cell22)
        (connected cell22 cell21)

        (connected cell22 cell23)
        (connected cell23 cell22)

        (connected cell23 cell24)
        (connected cell24 cell23)

        (connected cell24 cell25)
        (connected cell25 cell24)

        (connected cell31 cell32)
        (connected cell32 cell31)

        (connected cell32 cell33)
        (connected cell33 cell32)

        (connected cell33 cell34)
        (connected cell34 cell33)

        (connected cell34 cell35)
        (connected cell35 cell34)   

        (connected cell41 cell42)
        (connected cell42 cell41)

        (connected cell42 cell43)
        (connected cell43 cell42)

        (connected cell43 cell44)
        (connected cell44 cell43)

        (connected cell44 cell45)
        (connected cell45 cell44)
        
        (connected cell11 cell21)
        (connected cell21 cell11)

        (connected cell21 cell31)
        (connected cell31 cell21)

        (connected cell31 cell41)
        (connected cell41 cell31)

        (connected cell12 cell22)
        (connected cell22 cell12)

        (connected cell22 cell32)
        (connected cell32 cell22)

        (connected cell32 cell42)
        (connected cell42 cell32)

        (connected cell13 cell23)
        (connected cell23 cell13)

        (connected cell23 cell33)
        (connected cell33 cell23)

        (connected cell33 cell43)
        (connected cell43 cell33)

        (connected cell14 cell24)
        (connected cell24 cell14)

        (connected cell24 cell34)
        (connected cell34 cell24)

        (connected cell34 cell44)
        (connected cell44 cell34)

        (connected cell15 cell25)
        (connected cell25 cell15)

        (connected cell25 cell35)
        (connected cell35 cell25)

        (connected cell35 cell45)
        (connected cell45 cell35)
    
  )
  (:goal (and
        (at-hero cell11 h1)
        (at-hero cell11 h2)
            ;Hero's Goal Location
            
  ))
  
)
