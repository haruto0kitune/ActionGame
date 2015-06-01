(in-package :game)

(defun test ()
  (sdl:with-init ()
    (sdl:window 300 300)
    (setf (sdl:frame-rate) 60)
    (let ((ins (make-instance 'player-sprite-sheet)) (x 0))
      (print ins)
      (print (gethash "running-left" (sprite-sheet ins)))
      (print (sdl:cells (gethash "running-left" (sprite-sheet ins))))
      (sdl:with-events (:poll)
	(:quit-event () t)
	(:key-down-event  (:key key)
			  (when (sdl:key= key :sdl-key-escape)
			    (sdl:push-quit-event)))
	(:idle ()
	       (sdl:clear-display sdl:*black*)
	       (sdl:draw-surface-at-* (gethash "running-left" (sprite-sheet ins)) 0 0 :cell x)
	       (sdl:update-display))))))
  
(test)



	     
       
      