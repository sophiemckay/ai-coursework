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
        (at ?r - rover ?w - waypoint)
        (feature_at ?g - geological_feature ?w - waypoint)
        (connected ?w1 - waypoint ?w2 - waypoint)
        (acquired ?r - rover ?d - data)
        (collected_sample ?r - rover ?s - sample)
        (transmitted ?l - lander ?r - rover ?d - data)
        (carrying ?r - rover ?s - sample)
        (associated ?r - rover ?l - lander)
        (deployed_rover ?r - rover)
        (stored_sample ?l - lander ?s - sample)
        (lander_location ?l - lander ?w - waypoint)
        (is_memory_free ?r - rover)
        (space_for_sample ?y - sample)
        (free_lander_storage ?f)
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
        :parameters (?r - rover ?w1 - waypoint ?w2 - waypoint ?w3 - waypoint ?w4 - waypoint ?w5 - waypoint)
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
            (feature_at ?g ?w))
        :effect (and
            (acquired ?r ?d)
             )
    )

    (:action perform_scan
        :parameters (?r - rover ?d - data ?w - waypoint)
        :precondition (and
            (deployed_rover ?r)
            (at ?r ?w) 
            (is_memory_free ?r)
            )
        :effect (and 
            (acquired ?r ?d)
            )
    )
    

     (:action collect_sample
        :parameters (?r - rover ?s - sample ?w - waypoint)
        :precondition (and
            (deployed_rover ?r)
            (at ?r ?w))
            (space_for_sample ?y)
        :effect (and 
            (collected_sample ?r ?s)
            (carrying ?r ?s)
            (not(space_for_sample ?y))
        )
     )
    
    (:action deploy_rover
        :parameters (?l - lander ?w - waypoint ?r - rover)
        :precondition (and
            (associated ?r ?l) )
            (lander_location ?l ?w)
        :effect (and
            (deployed_rover ?r) )
            (at ?r ?w)
    )

    (:action transmit_data
        :parameters (?r - rover ?d - data ?l - lander)
        :precondition (and 
            (deployed_rover ?r)
            (acquired ?r ?d)
            (associated ?r ?l)
            )
        :effect (and
        (transmitted ?l ?r ?d))
        (is_memory_free ?r)
       )
    
    (:action stored_sample
        :parameters (?r - rover ?l - lander ?s - sample ?w - waypoint)
        :precondition (and
        (deployed_rover ?r)
        (carrying ?r ?s)
        (associated ?r ?l) 
        (at ?r ?w)
        (lander_location ?l ?w))
        (free_lander_storage ?f)
        :effect (and 
        (store_sample ?l ?s)
        (space_for_sample ?y)
        (not (carrying ?r ?s)))
        (not(free_lander_storage ?f))
    )
)

    

