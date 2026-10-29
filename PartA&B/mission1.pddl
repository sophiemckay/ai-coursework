(define (problem lunar-mission-1)
    (:domain lunar)
 
    (:objects ; define all the objeccts that exist 
        rover1 - rover ; the rover used in the mission
        lander1 - lander ; the lander used in the mission
        wp1 wp2 wp3 wp4 wp5 - waypoint ; these are the 5 waypoints the rover can navigate between 
        image1 scan1 - data ; the image and scan data to be collected
        soil1 - geological_feature ; a geological feature found 
        sample1 - sample ; a sample collected 
        
    )

    (:init ;initial state 
        (associated rover1 lander1) ;the rover is associated with the lander
        
        (lander_location lander1 wp1) ;the lander is initially loacted at wp1

        (is_memory_free rover1) ;the rovers memory should be free 

        (space_for_sample rover1) ;the rover has space for a sample 

        (image_data image1) ;image1 is the image data

        (scan_data scan1) ;scan1 is the scan data

        (free_lander_storage lander1) ;the lander has free storage available 
    
        (at_scan_site wp3) ;wp3 is the location of the scan site

        (feature_at wp5) ;the geological feature is located at wp5
    

        (sample_at sample1 wp1) ;the sample is located at wp1

        (connected wp1 wp2) ; these are the connections between waypoints describing the routes avaiable for the rover to navigate 
        (connected wp2 wp3) 
        (connected wp3 wp5)
        (connected wp4 wp3)
        (connected wp5 wp1)
        (connected wp1 wp4)

    )

    (:goal ;conditions to achieve goal
        (and
            (transmitted lander1 rover1 image1) ;image data must be transmitted fromr rover to lander successfully 

            (transmitted lander1 rover1 scan1) ;scan data must be transmitted from rover to lander

            (stored_sample lander1 sample1) ;the sample must be stored in the lander
        )
    )
)
