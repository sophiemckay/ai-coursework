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
        (connected ?w1 - waypoint ?w2 - waypoint)
        (acquired ?r - rover ?d data)
        (transmitted ?r - rover ?d data)
        (carrying ?r - rover ?s sample)
        (associated ?r - rover ?l lander)
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
        :parameters (?r - rover ?w1 - waypoint ?w2 - waypoint)
        :precondition (and 
        (at ?r ?w1)
        (connected ?w1 ?w2))
        :effect (and
            (not(at ?r ?w1))
            (at ?r ?w2))

    )

)