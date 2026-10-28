(define (problem lunar-mission-2)
    (:domain lunar)

    (:objects
        lander1 lander2 - lander
        rover1 rover2 - rover
        wp1 wp2 wp3 wp4 wp5 wp6 - waypoint
        image1 image2 scan1 scan2 - data
        sample1 sample2 - sample
    )

    (:init
        ; associate the rovers with their landers
        (associate rover1 lander1)
        (associate rover2 lander2)

        ; lander is located at waypoint 2 and then rover is already deployed, so rover is set to waypoint 2
        (lander_location lander1 wp2)
        (at rover1 wp2)

        ; lander is initially located at waypoint 1
        (lander_location lander2 wp1)

        ; both rovers memory should be free
        (is_memory_free rover1)
        (is_memory_free rover2)

        ; both rovers have space for a sample
        (space_for_sample rover1)
        (space_for_sample rover2)

        ; specify what kinds of data each are (image or scan)
        (image_data image1)
        (image_data image2)
        (scan_data scan1)
        (scan_data scan2)

        ; both landers have free storage available
        (free_lander_storage lander1)
        (free_lander_storage lander2)

        ; the waypoints of the scan sites
        (at_scan_site scan1 wp4)
        (at_scan_site scan2 wp6)

        ; the waypoints of the geological features for images
        (feature_at soil1 wp3)
        (feature_at rock1 wp2)

        ; the waypoints of the samples
        (sample_at sample1 wp5)
        (sample_at sample2 wp1)

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
            ; deploy rover2
            (deployed_rover rover2)

            ; image data must be transmitted from rover1 to lander1 successfully
            (transmitted lander1 rover1 image1)

            ; scan data must be transmitted from rover2 to lander2 successfully
            (transmitted lander2 rover2 scan1)

            ; image data must be transmitted from rover2 to lander2 successfully
            (transmitted lander2 rover2 image2)

            ; scan data must be transmitted from rover1 to lander1 successfully
            (transmitted lander1 rover1 scan2)

            ; sample data must be stored in lander2 successfully
            (stored_sample lander1 sample1)

            ; sample data must be stored in lander2 successfully
            (stored_sample lander2 sample2)
        )
    )
)