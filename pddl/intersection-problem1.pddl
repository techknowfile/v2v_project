; problem problem
(define (problem intersection-problem1)
    (:domain intersection)
    (:objects rd-0-3 rd-0-4 rd-1-3 rd-1-4 rd-2-3 rd-2-4 rd-3-0 rd-3-1 rd-3-2 rd-3-3 rd-3-4 rd-3-5 rd-3-6 rd-3-7 rd-4-0 rd-4-1 rd-4-2 rd-4-3 rd-4-4 rd-4-5 rd-4-6 rd-4-7 rd-5-3 rd-5-4 rd-6-3 rd-6-4 rd-7-3 rd-7-4 - road
              car-1 car-2 car-3 car-4 - car
              q-0 q-1 q-2 q-3 q-4 - num)
    (:init
    
           ; queues
           (adjacent q-0 q-1)
           (adjacent q-1 q-2)
           (adjacent q-2 q-3)
           (adjacent q-3 q-4)
           (adjacent q-4 q-0)
           
           (qstatus q-0)
           (qnext q-0)
           
           ; south side
           (adjacent rd-3-2 rd-3-1)
           (adjacent rd-3-1 rd-3-0)
           (adjacent rd-4-0 rd-4-1)
           (adjacent rd-4-1 rd-4-2)
           
           ; west side
           (adjacent rd-0-3 rd-1-3)
           (adjacent rd-1-3 rd-2-3)
           (adjacent rd-2-4 rd-1-4)
           (adjacent rd-1-4 rd-0-4)
           
           ; east side
           (adjacent rd-5-3 rd-6-3)
           (adjacent rd-6-3 rd-7-3)
           (adjacent rd-7-4 rd-6-4)
           (adjacent rd-6-4 rd-5-4)
           
           ; north side
           (adjacent rd-4-5 rd-4-6)
           (adjacent rd-4-6 rd-4-7)
           (adjacent rd-3-7 rd-3-6)
           (adjacent rd-3-6 rd-3-5)
           
           
           ; intersection
           (left_turnable rd-3-5 rd-3-4 rd-3-3 rd-4-3 rd-5-3)
           (left_turnable rd-4-2 rd-4-3 rd-4-4 rd-3-4 rd-2-4)
           (left_turnable rd-2-3 rd-3-3 rd-4-3 rd-4-4 rd-4-5)
           (left_turnable rd-5-4 rd-4-4 rd-3-4 rd-3-3 rd-3-2)
           (right_turnable rd-2-3 rd-3-3 rd-3-2)
           (right_turnable rd-4-2 rd-4-3 rd-5-3)
           (right_turnable rd-3-5 rd-3-4 rd-2-4)
           (right_turnable rd-5-4 rd-4-4 rd-4-5)
		   (straight_turnable rd-4-2 rd-4-3 rd-4-4 rd-4-5)
           
           ; Stop signs
           (stopsign rd-3-5)
           (stopsign rd-2-3)
           (stopsign rd-4-2)
           (stopsign rd-4-4)
           
           (clear rd-0-3)
           (clear rd-0-4)
           (clear rd-1-3)
           (clear rd-1-4)
           (clear rd-2-3)
           (clear rd-2-4)
           (clear rd-3-0)
           (clear rd-3-1)
           (clear rd-3-2)
           (clear rd-3-3)
           (clear rd-3-4)
           (clear rd-3-5)
           (clear rd-3-6)
           (clear rd-3-7)
           (clear rd-4-0)
           ;(clear rd-4-1)
		   ;(clear rd-4-2)
           (clear rd-4-3)
           (clear rd-4-4)
           (clear rd-4-5)
           (clear rd-4-6)
           (clear rd-4-7)
           (clear rd-5-3)
           (clear rd-5-4)
           (clear rd-6-3)
           (clear rd-6-4)
           (clear rd-7-3)
           (clear rd-7-4)
           
           ; initialize cars
           (at car-1 rd-4-2)
           (at car-2 rd-4-1)
           (at car-3 rd-3-5)
           (at car-4 rd-4-2)
           )
		   
    (:goal (and (at car-1 rd-0-4)
				(at car-2 rd-1-4)
				(at car-3 rd-7-3)
				(at car-4 rd-4-7)
		   )
	)
)
