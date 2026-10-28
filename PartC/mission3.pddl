(define (problem lunar-mission-3)
    (:domain lunar-extended)

    (:objects
        lander1 lander2 - lander
        rover1 rover2 - rover
        wp1 wp2 wp3 wp4 wp5 wp6 - waypoint
        image1 image2 scan1 scan2 - data
        sample1 sample2 - sample
    )

    (:init
        ; connections between waypoints describing routes available
        (connected wp1 wp2)
        (connected wp2 wp1)
        (connected wp2 wp4)
        (connected wp4 wp2)
        (connected wp2 wp3)
        (connected wp3 wp5)
        (connected wp5 wp3)
        (connected wp5 wp6)
        (connected wp6 wp4)
    )

    (:goal
        (and
            
        )
    )
)