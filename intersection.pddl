(define (domain intersection)
   (:requirements
        :equality
        :negative-preconditions
        :typing
    )

    (:types
        car loc num - object
        road spot - loc
    )

    (:constants
        
    )

    (:predicates
        (clear ?loc - loc)
        (at ?car - object ?loc - loc)
        (adjacent ?obj1 ?obj2 - object)
        (qpos ?car - object ?num - num) ; car's spot in queue to go through intersection
        (qstatus ?num) ; car that can/is going through the intersection
        (qnext ?num - num) ; next number to be assigned to a car that stops
        (left_turnable ?from ?rd0 ?rd1 ?rd2 ?exit - road)
        (turning_left ?car - car ?from ?rd0 ?rd1 ?rd2 ?exit - road)
        (turning_right ?car - car ?from ?rd1 ?exit - road)
		(turning_straight ?car - car ?from ?rd1 ?rd2 ?exit)
        (right_turnable ?from ?rd0 ?exit - road)
		(straight_turnable ?from ?rd1 ?rd2 ?exit)
        (stopped ?car - car)
        (stopsign ?loc - loc)
        (locked ?loc - loc)
    )
    
    (:action move
        :parameters (?car - car ?from - road ?to - road)
        :precondition (and (clear ?to) 
                           (at ?car ?from)
                           (adjacent ?from ?to)
        )
        :effect (and (not (clear ?to))
                     (not (at ?car ?from))
                     (clear ?from)
                     (at ?car ?to)
        )
    )
    
    (:action stop
        :parameters (?car - car ?loc - loc ?assign-q ?next-q - num)
        :precondition (and (not (stopped ?car))
                            (stopsign ?loc)
                            (at ?car ?loc)
                            (adjacent ?assign-q ?next-q)
                            (qnext ?assign-q)
                        )
        :effect (and (stopped ?car)
                     (qpos ?car ?assign-q)
                     (not (qnext ?assign-q))
                     (qnext ?next-q)
                )
    )
    
    (:action turn_left_0
        :parameters (?car - car ?from ?rd1 ?rd2 ?rd3 ?exit - road ?num - num)
        :precondition  (and 
                            (stopped ?car)
                            (at ?car ?from)
                            (left_turnable ?from ?rd1 ?rd2 ?rd3 ?exit)
                            (not 
                                (or 
                                    (locked ?rd1)
                                    (locked ?rd2)
                                    (locked ?rd3)
                                    (locked ?exit)
                                )
                            )
                            (clear ?rd1)
                            (clear ?rd2)
                            (clear ?rd3)
                            (clear ?exit)
                            (qstatus ?num)
                            (qpos ?car ?num)
                        )
        :effect (and
					(turning_left ?car ?from ?rd1 ?rd2 ?rd3 ?exit)
                    (not (stopped ?car))
                    (not (at ?car ?from))
                    (at ?car ?rd1)
                    (locked ?rd1)
                    (locked ?rd2)
                    (locked ?rd3)
                    (clear ?from)
                    (not (clear ?rd1))
                )
    )
    (:action turn_left_1
        :parameters (?car - car ?from ?rd1 ?rd2 ?rd3 ?exit - road ?num - num)
        :precondition  (and 
							(turning_left ?car ?from ?rd1 ?rd2 ?rd3 ?exit)
                            (at ?car ?rd1)
                            (left_turnable ?from ?rd1 ?rd2 ?rd3 ?exit)
                            (clear ?rd2)
                            (clear ?rd3)
                            (clear ?exit)
                            (qstatus ?num)
                            (qpos ?car ?num)
                        )
        :effect (and
                    (not (at ?car ?rd1))
                    (at ?car ?rd2)
                    (clear ?rd1)
                    (not (clear ?rd2))
                )
    )
    (:action turn_left_2
        :parameters (?car - car ?from ?rd1 ?rd2 ?rd3 ?exit - road ?num - num)
        :precondition  (and 
							(turning_left ?car ?from ?rd1 ?rd2 ?rd3 ?exit)
                            (at ?car ?rd2)
                            (left_turnable ?from ?rd1 ?rd2 ?rd3 ?exit)
                            (clear ?rd3)
                            (clear ?exit)
                            (qstatus ?num)
                            (qpos ?car ?num)
                        )
        :effect (and
                    (not (at ?car ?rd2))
                    (at ?car ?rd3)
                    (clear ?rd2)
                    (not (clear ?rd3))
                )
    )
    (:action turn_left_3
        :parameters (?car - car ?from ?rd1 ?rd2 ?rd3 ?exit - road ?qstate - num ?qinc - num)
        :precondition  (and 
							(turning_left ?car ?from ?rd1 ?rd2 ?rd3 ?exit)
                            (at ?car ?rd3)
                            (left_turnable ?from ?rd1 ?rd2 ?rd3 ?exit)
                            (clear ?exit)
                            (qstatus ?qstate)
                            (qpos ?car ?qstate)
							(adjacent ?qstate ?qinc)
                        )
        :effect (and
					(not (turning_left ?car ?from ?rd1 ?rd2 ?rd3 ?exit))
                    (not (at ?car ?rd3))
                    (at ?car ?exit)
                    (clear ?rd3)
                    (not (clear ?exit))
                    (not (locked ?rd1))
                    (not (locked ?rd2))
                    (not (locked ?rd3))
                    (not (qpos ?car ?qstate))
                    (not (qstatus ?qstate))
                    (qstatus ?qinc)
                )
    )
    (:action turn_right_0
            :parameters (?car - car ?from ?rd1 ?exit - road ?num - num)
            :precondition  (and 
                                (stopped ?car)
                                (at ?car ?from)
                                (right_turnable ?from ?rd1 ?exit)
                                (not 
                                    (or 
                                        (locked ?rd1)
                                        (locked ?exit)
                                    )
                                )
                                (clear ?rd1)
                                (clear ?exit)
                                (qstatus ?num)
                                (qpos ?car ?num)
                            )
            :effect (and
						(turning_right ?car ?from ?rd1 ?exit)
                        (not (stopped ?car))
                        (not (at ?car ?from))
                        (at ?car ?rd1)
                        (locked ?rd1)
                        (locked ?exit)
                        (clear ?from)
                        (not (clear ?rd1))
                    )
    )
    (:action turn_right_1
        :parameters (?car - car ?from ?rd1 ?exit - road ?qstate - num ?qinc - num)
        :precondition  (and 
							(turning_right ?car ?from ?rd1 ?exit)
                            (at ?car ?rd1)
                            (right_turnable ?from ?rd1 ?exit)
                            (clear ?exit)
                            (qpos ?car ?qstate)
                            (adjacent ?qstate ?qinc)
                        )
        :effect (and
					(not (turning_right ?car ?from ?rd1 ?exit))
                    (not (at ?car ?rd1))
                    (at ?car ?exit)
                    (clear ?rd1)
                    (not (clear ?exit))
                    (not (locked ?rd1))
                    (not (qpos ?car ?qstate))
                    (not (qstatus ?qstate))
                    (qstatus ?qinc)
                )
    )
(:action turn_straight_0
        :parameters (?car - car ?from ?rd1 ?rd2 ?exit - road ?num - num)
        :precondition  (and 
                            (stopped ?car)
                            (at ?car ?from)
                            (straight_turnable ?from ?rd1 ?rd2 ?exit)
                            (not 
                                (or 
                                    (locked ?rd1)
                                    (locked ?rd2)
                                    (locked ?exit)
                                )
                            )
                            (clear ?rd1)
                            (clear ?rd2)
                            (clear ?exit)
                            (qstatus ?num)
                            (qpos ?car ?num)
                        )
        :effect (and
					(turning_straight ?car ?from ?rd1 ?rd2 ?exit)
                    (not (stopped ?car))
                    (not (at ?car ?from))
                    (at ?car ?rd1)
                    (locked ?rd1)
                    (locked ?rd2)
                    (clear ?from)
                    (not (clear ?rd1))
                )
    )
    (:action turn_straight_1
        :parameters (?car - car ?from ?rd1 ?rd2 ?exit - road ?num - num)
        :precondition  (and 
							(turning_straight ?car ?from ?rd1 ?rd2 ?exit)
                            (at ?car ?rd1)
                            (straight_turnable ?from ?rd1 ?rd2 ?exit)
                            (clear ?rd2)
                            (clear ?exit)
                            (qstatus ?num)
                            (qpos ?car ?num)
                        )
        :effect (and
                    (not (at ?car ?rd1))
                    (at ?car ?rd2)
                    (clear ?rd1)
                    (not (clear ?rd2))
                )
    )
    (:action turn_straight_2
        :parameters (?car - car ?from ?rd1 ?rd2 ?exit - road ?qstate - num ?qinc - num)
        :precondition  (and 
							(turning_straight ?car ?from ?rd1 ?rd2 ?exit)
                            (at ?car ?rd2)
                            (straight_turnable ?from ?rd1 ?rd2 ?exit)
                            (clear ?exit)
                            (qstatus ?qstate)
                            (qpos ?car ?qstate)
							(adjacent ?qstate ?qinc)
                        )
        :effect (and
					(not (turning_straight ?car ?from ?rd1 ?rd2 ?exit))
                    (not (at ?car ?rd2))
                    (at ?car ?exit)
                    (clear ?rd2)
                    (not (clear ?exit))
                    (not (locked ?rd1))
                    (not (locked ?rd2))
                    (not (qpos ?car ?qstate))
                    (not (qstatus ?qstate))
                    (qstatus ?qinc)
                )
    )
)
