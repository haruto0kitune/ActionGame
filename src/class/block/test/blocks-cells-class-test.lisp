(in-package :game)

(defun blocks-cells-class-test ()
  (sdl:with-init ()
    (sdl:window 300 300)
    (setf (sdl:frame-rate) 60)
    (let ((ins (make-instance 'blocks-cells)))
      (print (sprite-cells2 40 40 "blocks1" ins))
      (print (gethash "blocks1" (x-cells ins)))
      (print (gethash "blocks1" (total-cells ins)))
      (sdl:with-events (:poll)
	(:quit-event () t)
	(:key-down-event  (:key key)
			  (when (sdl:key= key :sdl-key-escape)
			    (sdl:push-quit-event)))
	(:idle ())))))

  
(blocks-cells-class-test)
