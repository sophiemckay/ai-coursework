(define (domain lunar-extended)
    (:requirements :strips :typing)

    ; -------------------------------
    ; Types
    ; -------------------------------

    (:types
        rover
        lander
        waypoint
        data
        sample
        astronaut 
        area
    
    )

    ; -------------------------------
    ; Predicates
    ; -------------------------------

    (:predicates    

        (at ?r - rover ?w - waypoint)                          ; whether the rover is at the waypoint
        (acquired ?r - rover ?d - data)               ; whether the rover has acquired the data
        (collected_sample ?r - rover ?s - sample)            ; whether the rover has collected the sample
        (carrying ?r - rover ?s - sample)             ; whether the rover is carrying the sample
        (associated ?r - rover ?l - lander)                 ; whether the rover and lander are associated 
        (deployed_rover ?r - rover)                      ; whether the rover has been deployed
        (is_memory_free ?r - rover)                   ; whether the rover has space for data
        (space_for_sample ?r - rover)                 ; whether the rover has memory space for a sample
        
        (feature_at ?w - waypoint)                          ; whether the geological feature is at the waypoint
        (sample_at ?s - sample ?w - waypoint)               ; whether the sample is at the given waypoint
        (connected ?w1 - waypoint ?w2 - waypoint)           ; whether the two given waypoints are connected
        
        (transmitted ?l - lander ?r - rover ?d - data)       ; whether the lander has transmitted the data to the rover
        (stored_sample ?l - lander ?s - sample)              ; whether the lander has a sample stored
        (lander_location ?l - lander ?w - waypoint)         ; whether the lander is at the waypoint  
        (free_lander_storage ?l - lander)                ; whether the lander has space for a sample

        (at_scan_site ?w - waypoint)                           ; whether the given waypoint is the location for scanning
        (image_data ?d - data)                              ; whether the data is an image
        (scan_data ?d - data)                               ; whether the data is a scan
        
        (associated_astronaut ?a - astronaut ?l - lander)   ; whether the astronaut and lander are associated
        (astronaut_at ?a - astronaut ?l - lander ?z - area)    ; whether the astronaut is at a given area in the lander
        (area_in ?z - area ?l - lander)                     ; whether the area is in the lander
        (connected_area ?z1 - area ?z2 - area)              ; whether the two areas are connected in the lander
        (docking_bay ?b - area)                                 ; whether the given area is a docking bay
        (control_room ?c - area)                                ; whether the given area is a control room
    )

    ; -------------------------------
    ; Actions
    ; -------------------------------

    (:action navigate_waypoints
        :parameters (?r - rover ?w1 - waypoint ?w2 - waypoint )
        :precondition (and 
        (deployed_rover ?r)
        (at ?r ?w1)
        (connected ?w1 ?w2))
        :effect (and
            (not(at ?r ?w1))
            (at ?r ?w2))

    )

    (:action capture_images
        :parameters (?r - rover ?d - data ?w - waypoint)
        :precondition (and 
            (deployed_rover ?r)
            (at ?r ?w)
            (is_memory_free ?r)
            (feature_at ?w)
            (image_data ?d))
        :effect (and
            (acquired ?r ?d)
            (not(is_memory_free ?r))
             )
    )

    (:action perform_scan
        :parameters (?r - rover ?d - data ?w - waypoint)
        :precondition (and
            (deployed_rover ?r)
            (at ?r ?w) 
            (is_memory_free ?r)
            (at_scan_site ?w)
            (scan_data ?d))
        :effect (and 
            (acquired ?r ?d)
            (not(is_memory_free ?r))
            )
    )
    

     (:action collect_sample
        :parameters (?r - rover ?s - sample ?w - waypoint)
        :precondition (and
            (deployed_rover ?r)
            (at ?r ?w)
            (sample_at ?s ?w)
            (space_for_sample ?r))
        :effect (and 
            (collected_sample ?r ?s)
            (carrying ?r ?s)
            (not(space_for_sample ?r))
        )
     )
    
    (:action deploy_rover
        :parameters (?l - lander ?w - waypoint ?r - rover ?a - astronaut ?z - area)
        :precondition (and
            (associated ?r ?l) 
            (lander_location ?l ?w) )
            (associated_astronaut ?a ?l)
            (area_in ?z ?l)
            (docking_bay ?z)
        :effect (and
            (deployed_rover ?r) 
            (at ?r ?w))
    )

    (:action transmit_data
        :parameters (?r - rover ?d - data ?l - lander)
        :precondition (and 
            (deployed_rover ?r)
            (acquired ?r ?d)
            (associated ?r ?l)
            (associated_astronaut ?a ?l)
            (astronaut at ?a ?l ?z)
            (area_in ?z ?l)
            (control_room ?z)
            )
        :effect (and
        (transmitted ?l ?r ?d)
        (not(acquired ?r ?d))
        (is_memory_free ?r)
       ))
    
    (:action store_sample
        :parameters (?r - rover ?l - lander ?s - sample ?w - waypoint ?a - astronaut ?z - area)
        :precondition (and
        (deployed_rover ?r)
        (carrying ?r ?s)
        (associated ?r ?l) 
        (at ?r ?w)
        (lander_location ?l ?w)
        (free_lander_storage ?l))
        (associated_astronaut ?a ?l ?z)
        (area_in ?z ?l)
        (docking_bay ?z)
        :effect (and 
        (stored_sample ?l ?s)
        (space_for_sample ?r)
        (not (carrying ?r ?s))
        (not(free_lander_storage ?l))
    )   
    )
    (:action astronaut_lander_movement
        :parameters(?a - astronaut ?l - lander ?z1 - area ?z2 - area)
        :precondition (and
            (associated_astronaut ?a ?l)
            (astronaut_at ?a ?l ?z1)
            (area_in ?z1 ?l)
            (area_in ?z2 ?l)
            (connected_area ?z1 ?z2)
        ) 
        :effect (and
        (not(astronaut_at ?a ?l ?z1) )
        (astronaut_at ?a ?l ?z2))
    ))
    
