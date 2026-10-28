(define (domain lunar)
    (:requirements :strips :typing)

    ; -------------------------------
    ; Types
    ; -------------------------------

    ; EXAMPLE

    ; (:types
    ;     parent_type
    ;     child_type - parent_type

    ; )
    (:types
        rover
        lander
        waypoint
        data
        sample
        geological_feature
        site
    
    )

    ; -------------------------------
    ; Predicates
    ; -------------------------------

    ; EXAMPLE

    ; (:predicates
    ;     (no_arity_predicate)
    ;     (one_arity_predicate ?p - parameter_type)
    ; )

    (:predicates
        (at ?r - rover ?w - waypoint)                       ; whether the rover is at the waypoint
        (feature_at ?g - geological_feature ?w - waypoint)  ; whether the geological feature is at the waypoint
        (sample_at ?s - sample ?w - waypoint)               ; whether the sample is at the given waypoint
        (connected ?w1 - waypoint ?w2 - waypoint)           ; whether the two given waypoints are connected
        (acquired ?r - rover ?d - data)                     ; whether the rover has acquired the data
        (collected_sample ?r - rover ?s - sample)           ; whether the rover has collected the sample
        (transmitted ?l - lander ?r - rover ?d - data)      ; whether the lander has transmitted the data to the rover
        (carrying ?r - rover ?s - sample)                   ; whether the rover is carrying the sample
        (associated ?r - rover ?l - lander)                 ; whether the rover and lander are associated 
        (deployed_rover ?r - rover)                         ; whether the rover has been deployed
        (stored_sample ?l - lander ?s - sample)             ; whether the lander has a sample stored
        (lander_location ?l - lander ?w - waypoint)         ; whether the lander is at the waypoint
        (is_memory_free ?r - rover)                         ; whether the rover has space for data
        (space_for_sample ?r - rover)                       ; whether the rover has memory space for a sample
        (free_lander_storage ?l - lander)                   ; whether the lander has space for a sample
        (at_scan_site ?w - waypoint)                        ; whether the given waypoint is the location for scanning
        (image_data ?d - data)                              ; whether the data is an image
        (scan_data ?d - data)                               ; whether the data is a scan
    )

    ; -------------------------------
    ; Actions
    ; -------------------------------

    ; EXAMPLE

    ; (:action action-template
    ;     :parameters (?p - parameter_type)
    ;     :precondition (and
    ;         (one_arity_predicate ?p)
    ;     )
    ;     :effect 
    ;     (and 
    ;         (no_arity_predicate)
    ;         (not (one_arity_predicate ?p))
    ;     )
    ; )

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
        :parameters (?r - rover ?d - data ?g - geological_feature ?w - waypoint)
        :precondition (and 
            (deployed_rover ?r)
            (at ?r ?w)
            (is_memory_free ?r)
            (feature_at ?g ?w)
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
    );hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
    

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
        :parameters (?l - lander ?w - waypoint ?r - rover)
        :precondition (and
            (associated ?r ?l) 
            (lander_location ?l ?w) )
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
            )
        :effect (and
        (transmitted ?l ?r ?d)
        (not(acquired ?r ?d))
        (is_memory_free ?r)
       ))
    
    (:action store_sample
        :parameters (?r - rover ?l - lander ?s - sample ?w - waypoint)
        :precondition (and
        (deployed_rover ?r)
        (carrying ?r ?s)
        (associated ?r ?l) 
        (at ?r ?w)
        (lander_location ?l ?w)
        (free_lander_storage ?l))
        :effect (and 
        (stored_sample ?l ?s)
        (space_for_sample ?r)
        (not (carrying ?r ?s))
        (not(free_lander_storage ?l))
    )
)
)

