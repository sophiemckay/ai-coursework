(define (problem lunar-mission-1)
    (:domain lunar)

    (:objects
        rover1 - rover
        lander1 - lander
        wp1 wp2 wp3 wp4 wp5 - waypoint
        image1 scan1 - data
        soil1 - geological_feature
        sample1 - sample
        
    )

    (:init
        (associated rover1 lander1)
        
        (lander_location lander1 wp1)

        (is_memory_free rover1)

        (space_for_sample rover1)
        (image_data image1)
        (scan_data scan1)
        (free_lander_storage lander1)
        (at_scan_site wp3)

        (feature_at soil1 wp5)
        (sample_at sample1 wp1)
        (connected wp1 wp2)
        (connected wp2 wp3)
        (connected wp3 wp5)
        (connected wp4 wp3)
        (connected wp5 wp1)
        (connected wp1 wp4)

    )

    (:goal
        (and
            (transmitted lander1 rover1 image1)
            (transmitted lander1 rover1 scan1)
            (stored_sample lander1 sample1)
        )
    )
)