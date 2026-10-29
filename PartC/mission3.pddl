(define (problem lunar-mission-3)
    (:domain lunar-extended)

    (:objects
        lander1 lander2 - lander
        rover1 rover2 - rover
        wp1 wp2 wp3 wp4 wp5 wp6 - waypoint
        image1 image2 scan1 scan2 - data
        sample1 sample2 - sample
        alice bob - astronaut
        control_room1 docking_bay1 control_room2 docking_bay2 - area
        
    )

    (:init
        ; associate the rovers with their landers
        (associated rover1 lander1)
        (associated rover2 lander2)

        ; associate the astronauts with their landers
        (associated_astronaut alice lander1)
        (associated_astronaut bob lander2)

        ; associate the lander areas for each lander
        (area_in control_room1 lander1)
        (area_in control_room2 lander2)

        (area_in docking_bay1 lander1)
        (area_in docking_bay2 lander2)

        ; which room exists in each lander and what type of room each room is
        (control_room control_room1)
        (docking_bay docking_bay1)
        (control_room control_room2)
        (docking_bay docking_bay2)

        ; connect areas in lander
        (connected_area control_room1 docking_bay1)
        (connected_area docking_bay1 control_room1)

        (connected_area control_room2 docking_bay2)
        (connected_area docking_bay2 control_room2)

        ; initialise the astronauts in areas
        (astronaut_at alice lander1 docking_bay1)
        (astronaut_at bob lander2 control_room2)

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
        (at_scan_site wp4)
        (at_scan_site wp6)

        ; the waypoints of the geological features for images
        (feature_at wp3)
        (feature_at wp2)

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
