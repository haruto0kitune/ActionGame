(in-package :game)

(defclass player-draw ()
  ((x
    :initarg :x)
   (y
    :initarg :y)
   (sprite-sheets    
    :initform (make-instance 'player-sprite-sheet))
   (draw
    :initform (make-hash-table :test #'equal))))

(defmethod standing-left ((player-draw player-draw))
  (with-slots (sprite-sheets) player-draw
    (let ((current-cell 0) (frame-counter 0))
      (lambda (x y)
	(sdl:draw-surface-at-* standing-left x y :cell standing-left-current-cell)
	(incf frame-counter)
	(when (> frame-counter (gethash "standing-left" duration))
	  (incf standing-left-current-cell)
	  (setf frame-counter 0)
	  (if (> standing-left-current-cell (gethash "standing-left"
						     total-cell-count))
	      (setf standing-left-current-cell 0)))))

(defmethod standing-right ((player-draw player-draw))
  (with-slots
	(x
	 y
	 standing-right
	 standing-right-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player-draw
    (sdl:draw-surface-at-* standing-right
			   x
			   y
			   :cell standing-right-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "standing-right" duration))
      (incf standing-right-current-cell)
      (setf frame-counter 0)
      (if (> standing-right-current-cell (gethash "standing-right"
						 total-cell-count))
	  (setf standing-right-current-cell 0)))))

(defmethod running-left ((player-draw player-draw))
  (with-slots
	(x
	 y
	 running-left
	 running-left-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player-draw
    (sdl:draw-surface-at-* running-left
			   x
			   y
			   :cell running-left-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "running-left" duration))
      (incf running-left-current-cell)
      (setf frame-counter 0)
      (if (> running-left-current-cell (gethash "running-left"
						 total-cell-count))
	  (setf running-left-current-cell 0)))))

(defmethod running-right ((player-draw player-draw))
  (with-slots
	(x
	 y
	 running-right
	 running-right-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player-draw
    (sdl:draw-surface-at-* running-right
			   x
			   y
			   :cell running-right-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "running-right" duration))
      (incf running-right-current-cell)
      (setf frame-counter 0)
      (if (> running-right-current-cell (gethash "running-right"
						 total-cell-count))
	  (setf running-right-current-cell 0)))))

(defmethod jumping-left ((player-draw player-draw))
  (with-slots
	(x
	 y
	 jumping-left
	 jumping-left-current-cell
	 total-cell-count
	 frame-counter
	 duration
	 ground-flag)
      player-draw
    (if (eq ground-flag t)
	(setf jumping-left-current-cell 0))
    (sdl:draw-surface-at-* jumping-left
			   x
			   y
			   :cell jumping-left-current-cell)
    (incf frame-counter)	   
    (when (> frame-counter (gethash "jumping-left" duration))
      (incf jumping-left-current-cell)
      (setf frame-counter 0)
      (if (> jumping-left-current-cell (gethash "jumping-left"
						total-cell-count))
	  (setf jumping-left-current-cell (gethash "jumping-left"
						   total-cell-count))))))

(defmethod jumping-right ((player-draw player-draw))
  (with-slots
	(x
	 y
	 jumping-right
	 jumping-right-current-cell
	 total-cell-count
	 frame-counter
	 duration
	 ground-flag)
      player-draw
    (if (eq ground-flag t)
	(setf jumping-right-current-cell 0))
    (sdl:draw-surface-at-* jumping-right
			   x
			   y
			   :cell jumping-right-current-cell)
    (incf frame-counter)	   
    (when (> frame-counter (gethash "jumping-right" duration))
      (incf jumping-right-current-cell)
      (setf frame-counter 0)
      (if (> jumping-right-current-cell (gethash "jumping-right"
						total-cell-count))
	  (setf jumping-right-current-cell (gethash "jumping-right"
						   total-cell-count))))))

(defmethod damage-motion1-left ((player-draw player-draw))
  (with-slots
	(x
	 y
	 damage-motion1-left
	 damage-motion1-left-current-cell
	 total-cell-count
	 frame-counter
	 duration
	 hp
	 action-name)
      player-draw
    (when (and (<= hp 0)
	       (> damage-motion1-left-current-cell
		  (gethash "damage-motion1-left" total-cell-count)))
      (format t "down~%")
      (setf action-name "down-motion-left"))
    
    (sdl:draw-surface-at-* damage-motion1-left
			   x
			   y
			   :cell damage-motion1-left-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "damage-motion1-left" duration))
      (incf damage-motion1-left-current-cell)
      (setf frame-counter 0)
      (if (> damage-motion1-left-current-cell (gethash "damage-motion1-left"
								total-cell-count))
	  (setf damage-motion1-left-current-cell 0)))))

(defmethod damage-motion1-right ((player-draw player-draw))
  (with-slots
	(x
	 y
	 damage-motion1-right
	 damage-motion1-right-current-cell
	 total-cell-count
	 frame-counter
	 duration
	 hp
	 action-name)
      player-draw
    (when (and (<= hp 0)
	       (> damage-motion1-right-current-cell
		  (gethash "damage-motion1-right" total-cell-count)))
      (format t "down~%")
      (setf action-name "down-motion-right"))
    
    (sdl:draw-surface-at-* damage-motion1-right
			   x
			   y
			   :cell damage-motion1-right-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "damage-motion1-right" duration))
      (incf damage-motion1-right-current-cell)
      (setf frame-counter 0)
      (if (> damage-motion1-right-current-cell (gethash "damage-motion1-right"
								total-cell-count))
	  (setf damage-motion1-right-current-cell 0)))))

(defmethod down-motion-left ((player-draw player-draw))
  (with-slots
	(x
	 y
	 down-motion-left
	 down-motion-left-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player-draw
    (sdl:draw-surface-at-* down-motion-left
			   x
			   y
			   :cell down-motion-left-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "down-motion-left" duration))
      (setf frame-counter 0)
      (if (not (= down-motion-left-current-cell
		  (gethash "down-motion-left" total-cell-count)))
	  (incf down-motion-left-current-cell)))))

(defmethod down-motion-right ((player-draw player-draw))
  (with-slots
	(x
	 y
	 down-motion-right
	 down-motion-right-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player-draw
    (sdl:draw-surface-at-* down-motion-right
			   x
			   y
			   :cell down-motion-right-current-cell)    
    (incf frame-counter)
    (when (> frame-counter (gethash "down-motion-right" duration))
      (setf frame-counter 0)
      (if (not (= down-motion-right-current-cell
		  (gethash "down-motion-right" total-cell-count)))
	  (incf down-motion-right-current-cell)))))

(defmethod generate-jump ((player-draw player-draw))
  (with-slots (jump-power jump-flag collision) player-draw
    (let* ((start-jump-power jump-power)
	   (force jump-power)
	   (prev-y 0)
	   (temp-y 0)) 
      (lambda (&optional reset)
	(progn
	  (if (eq reset t) (setf force start-jump-power))
	  (if (eq jump-flag t)
	      (progn		
		(setf prev-y temp-y)
		(-= temp-y (floor force))
		(-= (y (position player-draw)) (floor force))
		(-= (y (collision player-draw)) (floor force))		
		(if (not (<= (floor force) 0))
		    (-= force 1.5)
		    (progn
		      (setf jump-flag nil)
		      (setf force start-jump-power))))))))))

(defmethod jump ((player-draw player-draw))
  (with-slots (var-jump
	       ground-flag
	       jump-flag
	       direction
	       action-name)
      player-draw
    (when (eq ground-flag t)
      (setf jump-flag t)
      (if (string= direction "left") (setf action-name "jumping-left"))
      (if (string= direction "right") (setf action-name "jumping-right")))
    (funcall var-jump)))

(defmethod draw-sprite ((player-draw player-draw))
  (with-slots (action-name) player-draw
    (cond ((string= action-name "standing-left") (standing-left player-draw))
	  ((string= action-name "standing-right") (standing-right player-draw))
	  ((string= action-name "running-left") (running-left player-draw))
	  ((string= action-name "running-right") (running-right player-draw))
	  ((string= action-name "jumping-left") (jumping-left player-draw))
	  ((string= action-name "jumping-right") (jumping-right player-draw))
	  ((string= action-name "damage-motion-left") (damage-motion-left player-draw))
	  ((string= action-name "damage-motion-right") (damage-motion-right player-draw))	  
	  ((string= action-name "down-motion-left") (down-motion-left player-draw))
	  ((string= action-name "down-motion-right") (down-motion-right player-draw)))))
