;It's recommended to install the misc-pddl-generators plugin 
;and then use Network generator to create the graph
(define (problem multidangeon)
  (:domain MultiDangeon)
  (:objects
            cell1_1 cell1_2 cell1_3 cell1_4 cell1_5 cell2_1 cell2_2 cell2_3 cell2_4 cell2_5 cell3_1 cell3_2 cell3_3 cell3_4 cell3_5 cell4_1 cell4_2 cell4_3 cell4_4 cell4_5 - cells
            s1 s2 - swords
            k1 k2 - keys
            h1 h2 - heroes
  )
  (:init

    ;Initial Hero Location
        (at-hero cell4_5 h1)
        (at-hero cell4_1 h2)
    
    ;He starts with a free arm
        (arm-free h1)
        (arm-free h2)
    
    ;Initial location of the swords
        (at-sword s1 cell2_3)
        (at-sword s2 cell3_4)

    ;Initial location of the keys
        (at-key k1 cell2_1)
        (at-key k2 cell4_2)

    ;Initial location of Monsters
        (has-monster cell1_3)
        (has-monster cell2_2)
    
    ;Initial lcocation of Traps
        (has-trap cell1_4)
        (has-trap cell3_2)
        (has-trap cell3_5)
        (has-trap cell4_4)

    ;Locked rooms
        (is-locked cell1_2)
        (is-locked cell2_4)
        (is-locked cell3_1)
        (is-locked cell3_3)
        (is-locked cell4_3)
    
    ;Graph Connectivity
        (connected cell1_1 cell1_2)
        (connected cell1_2 cell1_1)

        (connected cell1_2 cell1_3)
        (connected cell1_3 cell1_2)

        (connected cell1_3 cell1_4)
        (connected cell1_4 cell1_3)

        (connected cell1_4 cell1_5)
        (connected cell1_5 cell1_4)

        (connected cell2_1 cell2_2)
        (connected cell2_2 cell2_1)

        (connected cell2_2 cell2_3)
        (connected cell2_3 cell2_2)

        (connected cell2_3 cell2_4)
        (connected cell2_4 cell2_3)

        (connected cell2_4 cell2_5)
        (connected cell2_5 cell2_4)

        (connected cell3_1 cell3_2)
        (connected cell3_2 cell3_1)

        (connected cell3_2 cell3_3)
        (connected cell3_3 cell3_2)

        (connected cell3_3 cell3_4)
        (connected cell3_4 cell3_3)

        (connected cell3_4 cell3_5)
        (connected cell3_5 cell3_4)   

        (connected cell4_1 cell4_2)
        (connected cell4_2 cell4_1)

        (connected cell4_2 cell4_3)
        (connected cell4_3 cell4_2)

        (connected cell4_3 cell4_4)
        (connected cell4_4 cell4_3)

        (connected cell4_4 cell4_5)
        (connected cell4_5 cell4_4)
        
        (connected cell1_1 cell2_1)
        (connected cell2_1 cell1_1)

        (connected cell2_1 cell3_1)
        (connected cell3_1 cell2_1)

        (connected cell3_1 cell4_1)
        (connected cell4_1 cell3_1)

        (connected cell1_2 cell2_2)
        (connected cell2_2 cell1_2)

        (connected cell2_2 cell3_2)
        (connected cell3_2 cell2_2)

        (connected cell3_2 cell4_2)
        (connected cell4_2 cell3_2)

        (connected cell1_3 cell2_3)
        (connected cell2_3 cell1_3)

        (connected cell2_3 cell3_3)
        (connected cell3_3 cell2_3)

        (connected cell3_3 cell4_3)
        (connected cell4_3 cell3_3)

        (connected cell1_4 cell2_4)
        (connected cell2_4 cell1_4)

        (connected cell2_4 cell3_4)
        (connected cell3_4 cell2_4)

        (connected cell3_4 cell4_4)
        (connected cell4_4 cell3_4)

        (connected cell1_5 cell2_5)
        (connected cell2_5 cell1_5)

        (connected cell2_5 cell3_5)
        (connected cell3_5 cell2_5)

        (connected cell3_5 cell4_5)
        (connected cell4_5 cell3_5)
    
  )
  (:goal (and
        (at-hero cell1_1 h1)
        (at-hero cell1_5 h2)
            ;Hero's Goal Location
            
        )
  )
  
)
