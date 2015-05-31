(in-package :game)

(defun test ()
  (sdl:with-init ()
    (sdl:window 300 300)
    (sdl:with-events (:poll)
      (:quit-event () t)
      (:key-down-event  (:key key)
			(when (sdl:key= key :sdl-key-escape)
			  (sdl:push-quit-event)))
      (:idle ()))))
	     


(test)



	     
       
      
