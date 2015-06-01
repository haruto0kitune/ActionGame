(in-package :game)

(defun piyo-sprite-sheet-test ()
  (sdl:with-init ()
      (sdl:window 300 300)
      (setf (sdl:frame-rate) 60)
      (let ((ins (make-instance 'piyo-sprite-sheet)))
	(print ins)
	(print (sdl:cells (gethash "walking-left" (sprite-sheet ins))))
	(sdl:with-events (:poll)
	  (:quit-event () t)
	  (:key-down-event (:key key)
			   (when (sdl:key= key :sdl-key-escape)
			     (sdl:push-quit-event)))
	  (:idle ()
		 (sdl:clear-display sdl:*black*)
		 (sdl:draw-surface-at-* (gethash "walking-left" (sprite-sheet ins)) 0 0 :cell 0)
		 (sdl:update-display))))))

(piyo-sprite-sheet-test)
	     
		   
