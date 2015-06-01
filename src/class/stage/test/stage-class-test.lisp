(in-package :game)

(defun stage-class-test ()
  (sdl:with-init ()
    (sdl:window 800 600)
    (let ((ins (make-instance 'stage)))
      (print ins)
      (sdl:with-events (:poll)
	(:quit-event () t)
	(:key-down-event (:key key)
			 (when (sdl:key= key :sdl-key-escape)
			   (sdl:push-quit-event)))
	(:idle ()
	       (sdl:clear-display sdl:*black*)
	       (draw-sprite ins 0 0)
	       (sdl:update-display))))))

(stage-class-test)
	     
