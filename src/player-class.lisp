;;;;
;;;; player class
;;;;

(load "sprite-sheet-class.lisp" :external-format :utf-8)

;;;; generate clojure
(defgeneric generate-jump (player))

;;;; sprite
(defgeneric initialize-player (player))
(defgeneric generate-player-sprite-sheet (player))
(defgeneric draw-sprite-player (player sprite-name))

;;;; moving volume
(defgeneric move-left (player))
(defgeneric move-right (player))

;;;; animation
(defgeneric stand (player))
(defgeneric walk (player))
(defgeneric run (player))
(defgeneric crouch (player))
(defgeneric jump (player))
(defgeneric do-atemi1 (player))

(defclass player ()
  ((hp
    :documentation "hit point"
    :accessor image-object-hp
    :initform 1
    :initarg :hp)
   (frames
    :accessor image-object-frames
    :initform nil
    :initarg :frames)
   (filename
    :documentation "hash table"
    :accessor image-object-filename
    :initform nil
    :initarg :filename)
   (collision-x
    :accessor image-object-collision-x
    :initform 0
    :initarg :collision-x)
   (collision-y
    :accessor image-object-collision-y
    :initform 0
    :initarg :collision-y)
   (collision-width
    :accessor image-object-collision-width
    :initform 0
    :initarg :collision-width)
   (collision-height
    :accessor image-object-collision-height
    :initform 0
    :initarg :collision-height)
   (damage-collision-x
    :accessor image-object-damage-collision-x
    :initform 0
    :initarg :damage-collision-x)
   (damage-collision-y
    :accessor image-object-damage-collision-y
    :initform 0
    :initarg :damage-collision-y)
   (damage-collision-width
    :accessor image-object-damage-collision-width
    :initform 0
    :initarg :damage-collision-width)
   (damage-collision-height
    :accessor image-object-damage-collision-height
    :initform 0
    :initarg :damage-collision-height)
   (position-x
    :accessor image-object-position-x
    :initform 0
    :initarg :position-x)
   (position-y
    :accessor image-object-position-y
    :initform 0
    :initarg :position-y)
   (velocity-x
    :accessor image-object-velocity-x
    :initform 0
    :initarg :velocity-x)
   (velocity-y
    :accessor image-object-velocity-y
    :initform 0
    :initarg :velocity-y)
   (width
    :accessor image-object-width
    :initform 0
    :initarg :width)
   (height
    :accessor image-object-height
    :initform 0
    :initarg :height)
   (x-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-x-cell-count
    :initform 0
    :initarg :x-cell-count)
   (y-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-y-cell-count
    :initform 0
    :initarg :y-cell-count)
   (total-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-total-cell-count
    :initform 0
    :initarg :total-cell-count)
   (sprite-sheet
    :accessor image-object-sprite-sheet
    :initform nil
    :initarg :sprite-sheet)
   (current-cell
    :accessor image-object-current-cell
    :initform 0
    :initarg :current-cell)
   (standing-left-current-cell
    :accessor image-object-standing-left-current-cell
    :initform 0
    :initarg :standing-left-current-cell)
   (standing-right-current-cell
    :accessor image-object-standing-right-current-cell
    :initform 0
    :initarg :standing-right-current-cell)
   (running-left-current-cell
    :accessor image-object-running-left-current-cell
    :initform 0
    :initarg :running-left-current-cell)
   (running-right-current-cell
    :accessor image-object-running-right-current-cell
    :initform 0
    :initarg :running-right-current-cell)
   (jumping-left-current-cell
    :accessor image-object-jumping-left-current-cell
    :initform 0
    :initarg :jumping-left-current-cell)
   (jumping-right-current-cell
    :accessor image-object-jumping-right-current-cell
    :initform 0
    :initarg :jumping-right-current-cell)
   (fox-girl-damage-motion1-left-current-cell
    :accessor image-object-fox-girl-damage-motion1-left-current-cell
    :initform 0
    :initarg :fox-girl-damage-motion1-left-current-cell)
   (fox-girl-damage-motion1-right-current-cell
    :accessor image-object-fox-girl-damage-motion1-right-current-cell
    :initform 0
    :initarg :fox-girl-damage-motion1-right-current-cell)
   (fox-girl-down-motion-left-current-cell
    :accessor image-object-fox-girl-down-motion-left-current-cell
    :initform 0
    :initarg :fox-girl-down-motion-left-current-cell)
   (fox-girl-down-motion-right-current-cell
    :accessor image-object-fox-girl-down-motion-right-current-cell
    :initform 0
    :initarg :fox-girl-down-motion-right-current-cell)
   (duration
    :accessor image-object-duration
    :initform 0
    :initarg :duration)
   (frame-counter
    :initform 0)
   (cx-minus-px
    :documentation "position-x minus collision-x"
    :accessor image-object-cx-minus-px
    :initform 0)
   (cy-minus-py
    :documentation "position-y minus collision-y"
    :accessor image-object-cy-minus-py
    :initform 0)
   (direction
    :documentation "right or left"
    :accessor image-object-direction
    :initform nil
    :initarg :direction)
   (jump-power
    :accessor image-object-jump-power
    :initform 20
    :initarg :jump-power)
   (action-name
    :documentation "action flag"
    :accessor image-object-action-name
    :initform "standing-left")
   (var-jump
    :accessor image-object-var-jump
    :initform nil)
   (draw-flag
    :accessor image-object-draw-flag
    :initform nil
    :initarg :draw-flag)
   (jump-flag
    :accessor image-object-jump-flag
    :initform nil)
   (ground-flag
    :accessor image-object-ground-flag
    :initform nil)
   (air-flag
    :accessor image-object-air-flag
    :initform nil)
   (top-collision-flag
    :accessor image-object-top-collision-flag
    :initform nil)
   (bottom-collision-flag
    :accessor image-object-bottom-collision-flag
    :initform nil)
   (left-collision-flag
    :accessor image-object-left-collision-flag
    :initform nil)
   (right-collision-flag
    :accessor image-object-right-collision-flag
    :initform nil)
   (standing-left
    :documentation "sprite-sheet"
    :accessor image-object-standing-left
    :initform nil
    :initarg :standing-left)
   (standing-right
    :documentation "sprite-sheet"
    :accessor image-object-standing-right
    :initform nil
    :initarg :standing-right)
   (walking-left
    :documentation "sprite-sheet"
    :accessor image-object-walking-left
    :initform nil
    :initarg :walking-left)
   (walking-right
    :documentation "sprite-sheet"
    :accessor image-object-walking-right
    :initform nil
    :initarg :walking-right)
   (running-left
    :documentation "sprite-sheet"
    :accessor image-object-running-left
    :initform nil
    :initarg :running-left)
   (running-right
    :documentation "sprite-sheet"
    :accessor image-object-running-right
    :initform nil
    :initarg :running-right)
   (jumping-left
    :documentation "sprite-sheet"
    :accessor image-object-jumping-left
    :initform nil
    :initarg :jumping-left)
   (jumping-right
    :documentation "sprite-sheet"
    :accessor image-object-jumping-right
    :initform nil
    :initarg :jumping-right)
   (crouching-left
    :documentation "sprite-sheet"
    :accessor image-object-crouching-left
    :initform nil
    :initarg :crouching-left)
   (crouching-right
    :documentation "sprite-sheet"
    :accessor image-object-crouching-right
    :initform nil
    :initarg :crouching-right)
   (atemi1-left
    :documentation "sprite-sheet"
    :accessor image-object-atemi1-left
    :initform nil
    :initarg :atemi1-left)
   (atemi1-right
    :documentation "sprite-sheet"
    :accessor image-object-atemi1-right
    :initform nil
    :initarg :atemi1-right)
   (fox-girl-damage-motion1-left
    :documentation "sprite-sheet"
    :accessor image-object-fox-girl-damage-motion1-left
    :initform nil
    :initarg :fox-girl-damage-motion1-left)
   (fox-girl-damage-motion1-right
    :documentation "sprite-sheet"
    :accessor image-object-fox-girl-damage-motion1-right
    :initform nil
    :initarg :fox-girl-damage-motion1-right)
   (fox-girl-down-motion-left
    :documentation "sprite-sheet"
    :accessor image-object-fox-girl-down-motion-left
    :initform nil
    :initarg :fox-girl-down-motion-left)
   (fox-girl-down-motion-right
    :documentation "sprite-sheet"
    :accessor image-object-fox-girl-down-motion-right
    :initform nil
    :initarg :fox-girl-down-motion-right)))

;(defmethod player-damage-detect ((player player) enemy)
 ; (

(defmethod update-player ((player player))
  (with-slots (collision-x
	       collision-y
;	       attack-collision-x
;	       attack-collision-y
	       damage-collision-x
      	       damage-collision-y)
      player
;    (setf attack-collision-x collision-x)
 ;   (setf attack-collision-y collision-y)
    (setf damage-collision-x collision-x)
    (setf damage-collision-y collision-y)))

(defmethod initialize-instance :after ((player player) &rest initargs)
  (with-slots (collision-x
	       collision-y
	       collision-width
	       collision-height
;	       attack-collision-x
;	       attack-collision-y
;	       attack-collision-width
					;	       attack-collision-height)
	       damage-collision-x
	       damage-collision-y
	       damage-collision-width
	       damage-collision-height)
      player
    (setf damage-collision-x collision-x)
    (setf damage-collision-y collision-y)
    (setf damage-collision-width collision-width)
    (setf damage-collision-height collision-height)
    (initialize-player player)))

(defmethod initialize-player ((player player))  
  (with-slots (position-x
	       position-y
	       collision-x
	       collision-y
	       cx-minus-px
	       cy-minus-py
	       var-jump)
      player
    (generate-sprite-sheet player)
    (setf var-jump (generate-jump player))
    (setf cx-minus-px (- collision-x position-x))
    (setf cy-minus-py (- collision-y position-y))))
;    (setf px-minus-cx (- position-x collision-x))
;    (setf py-minus-cy (- position-y collision-y))))
;    (setf px-minus-cx collision-x)
 ;   (setf py-minus-cy collision-y)))
  
(defmethod move-left ((player player))
  (with-slots (position-x
	       collision-x
	       velocity-x
	       direction)
      player
    (setf (image-object-direction player) "left")
    (-= position-x velocity-x)
    (-= collision-x velocity-x)))

(defmethod move-right ((player player))
  (with-slots (position-x
	       collision-x
	       velocity-x
	       direction)
      player
    (setf (image-object-direction player) "right")
    (+= position-x velocity-x)
    (+= collision-x velocity-x)))

(defmethod generate-jump ((player player))
  (with-slots (jump-power jump-flag) player
    (let* ((start-jump-power jump-power)
	   (force jump-power)
	   (prev-y 0)
	   (temp-y 0)) 
      (lambda (&optional reset)
	(progn
	  (if (eq reset t)
	      (setf force start-jump-power))
	  (if (eq jump-flag t)
	      (progn		
		(setf prev-y temp-y)
		(-= temp-y (floor force))
		(-= (image-object-position-y player) (floor force))
		(-= (image-object-collision-y player) (floor force))		
		(if (not (<= (floor force) 0))
		    (-= force 1.5)
		    (progn
		      (setf jump-flag nil)
		      (setf force start-jump-power))))))))))

(defmethod jump ((player player))
  (with-slots (var-jump) player
      (funcall var-jump)))
	  
(defmethod generate-sprite-sheet ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       standing-left
	       standing-right
;	       walking-left
;	       walking-right
	       running-left
	       running-right
	       jumping-left
	       jumping-right
;	       crouching-left
;	       crouching-right
;	       atemi1-left
;	       atemi1-right
	       fox-girl-damage-motion1-left
	       fox-girl-damage-motion1-right
	       fox-girl-down-motion-left
	       fox-girl-down-motion-right
	       )
      player
    (let ((sprite-cells nil))
      ;; standing-left
      (setf standing-left (sdl:load-image (gethash "standing-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "standing-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells standing-left) sprite-cells)
      ;; standing-right
      (setf standing-right (sdl:load-image (gethash "standing-right" filename)
					   :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "standing-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells standing-right) sprite-cells)
      ;; running-left
      (setf running-left (sdl:load-image (gethash "running-left" filename)
					 :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "running-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells running-left) sprite-cells)
      ;; running-right
      (setf running-right (sdl:load-image (gethash "running-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "running-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells running-right) sprite-cells)
      ;; jumping-left
      (setf jumping-left (sdl:load-image (gethash "jumping-left" filename)
					 :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "jumping-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells jumping-left) sprite-cells)
      ;; jumping-right
      (setf jumping-right (sdl:load-image (gethash "jumping-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "jumping-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells jumping-right) sprite-cells)
      ;; fox-girl-damage-motion1-left
      (setf fox-girl-damage-motion1-left (sdl:load-image (gethash "fox-girl-damage-motion1-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "fox-girl-damage-motion1-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells fox-girl-damage-motion1-left) sprite-cells)
      ;; fox-girl-damage-motion1-right
      (setf fox-girl-damage-motion1-right (sdl:load-image (gethash "fox-girl-damage-motion1-right" filename)
					   :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "fox-girl-damage-motion1-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells fox-girl-damage-motion1-right) sprite-cells)
      ;; fox-girl-down-motion-left
      (setf fox-girl-down-motion-left (sdl:load-image (gethash "fox-girl-down-motion-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "fox-girl-down-motion-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells fox-girl-down-motion-left) sprite-cells)
      ;; fox-girl-down-motion-right
      (setf fox-girl-down-motion-right (sdl:load-image (gethash "fox-girl-down-motion-right" filename)
					   :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "fox-girl-down-motion-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells fox-girl-down-motion-right) sprite-cells))))
  
(defmethod draw-sprite-player ((player player) sprite-name)
  (with-slots
	(position-x
	 position-y
	 total-cell-count
	 air-flag
	 ground-flag
	 standing-left
	 standing-right
					;	       walking-left
					;	       walking-right
	 running-left
	 running-right
	 jumping-left
	 jumping-right
	 fox-girl-damage-motion1-left
	 fox-girl-damage-motion1-right
	 fox-girl-down-motion-left
	 fox-girl-down-motion-right
					;	       crouching-left
					;	       crouching-right
					;	       atemi1-left
					;	       atemi1-right
	 standing-left-current-cell
	 standing-right-current-cell
					;	       walking-left-current-cell
					;	       walking-right-current-cell
	 running-left-current-cell
	 running-right-current-cell
	 jumping-left-current-cell
	 jumping-right-current-cell
	 fox-girl-damage-motion1-left-current-cell
	 fox-girl-damage-motion1-right-current-cell
	 fox-girl-down-motion-left-current-cell
	 fox-girl-down-motion-right-current-cell
					;	       crouching-left-current-cell
					;	       crouching-right-current-cell
					;	       atemi1-left-current-cell
					;	       atemi1-right-current-cell
	 current-cell
	 duration
	 frame-counter
	 action-name
	 hp)
      player
    (cond ((string= sprite-name "standing-left")
	   ;;standing-left	   
	   (sdl:draw-surface-at-* standing-left
				  position-x
				  position-y
				  :cell standing-left-current-cell)
	   (incf frame-counter)
	   (when (> frame-counter (gethash "standing-left" duration))
	     (incf standing-left-current-cell)
	     (setf frame-counter 0)
	     (if (> standing-left-current-cell (gethash "standing-left"
							total-cell-count))
		 (setf standing-left-current-cell 0))))
	  ((string= sprite-name "standing-right")
	   ;;standing-right
	   (sdl:draw-surface-at-* standing-right
				  position-x
				  position-y
				  :cell standing-right-current-cell)
	   (incf frame-counter)
	   (when (> frame-counter (gethash "standing-right" duration))
	     (incf standing-right-current-cell)
	     (setf frame-counter 0)
	     (if (> standing-right-current-cell (gethash "standing-right"
							total-cell-count))
		 (setf standing-right-current-cell 0))))
	  ((string= sprite-name "running-left")
	   ;;running-left
	   (sdl:draw-surface-at-* running-left
				  position-x
				  position-y
				  :cell running-left-current-cell)
	   (incf frame-counter)
	   (when (> frame-counter (gethash "running-left" duration))
	     (incf running-left-current-cell)
	     (setf frame-counter 0)
	     (if (> running-left-current-cell (gethash "running-left"
							total-cell-count))
		 (setf running-left-current-cell 0))))
	  ((string= sprite-name "running-right")
	   ;;running-right
	   (sdl:draw-surface-at-* running-right
				  position-x
				  position-y
				  :cell running-right-current-cell)
	   (incf frame-counter)
	   (when (> frame-counter (gethash "running-right" duration))
	     (incf running-right-current-cell)
	     (setf frame-counter 0)
	     (if (> running-right-current-cell (gethash "running-right"
							total-cell-count))
		 (setf running-right-current-cell 0))))
	  ((string= sprite-name "jumping-left")
	   ;;jumping-left
	   (if (eq ground-flag t)
	       (setf jumping-left-current-cell 0))
	   (sdl:draw-surface-at-* jumping-left
				  position-x
				  position-y
				  :cell jumping-left-current-cell)
	   (incf frame-counter)	   
	   (when (> frame-counter (gethash "jumping-left" duration))
	     (incf jumping-left-current-cell)
	     (setf frame-counter 0)
	     (if (> jumping-left-current-cell (gethash "jumping-left"
							total-cell-count))
		 (setf jumping-left-current-cell (gethash "jumping-left"
							total-cell-count)))))
	  ((string= sprite-name "jumping-right")
	   ;;jumping-right
	   (if (eq ground-flag t)
	       (setf jumping-right-current-cell 0))
	   (sdl:draw-surface-at-* jumping-right
				  position-x
				  position-y
				  :cell jumping-right-current-cell)
	   (incf frame-counter)
	   (when (> frame-counter (gethash "jumping-right" duration))
	     (incf jumping-right-current-cell)
	     (setf frame-counter 0)
	     (if (> jumping-right-current-cell (gethash "jumping-right"
							total-cell-count))
		 (setf jumping-right-current-cell (gethash "jumping-right"
							   total-cell-count)))))
	  ((string= sprite-name "fox-girl-damage-motion1-left")
	   ;;fox-girl-damage-motion1-left
	   (when (and (<= hp 0)
		      (> fox-girl-damage-motion1-left-current-cell
			 (gethash "fox-girl-damage-motion1-left" total-cell-count)))
	     (format t "down~%")
	     (setf action-name "fox-girl-down-motion-left"))
									  
	   (sdl:draw-surface-at-* fox-girl-damage-motion1-left
				  position-x
				  position-y
				  :cell fox-girl-damage-motion1-left-current-cell)
	   (incf frame-counter)
	   (when (> frame-counter (gethash "fox-girl-damage-motion1-left" duration))
	     (incf fox-girl-damage-motion1-left-current-cell)
	     (setf frame-counter 0)
	     (if (> fox-girl-damage-motion1-left-current-cell (gethash "fox-girl-damage-motion1-left"
							total-cell-count))
		 (setf fox-girl-damage-motion1-left-current-cell 0))))
	  ((string= sprite-name "fox-girl-damage-motion1-right")
	   ;;fox-girl-damage-motion1-right
	   (when (and (<= hp 0)
		      (> fox-girl-damage-motion1-right-current-cell
			 (gethash "fox-girl-damage-motion1-right" total-cell-count)))
	     (format t "down~%")
	     (setf action-name "fox-girl-down-motion-right"))
	   (sdl:draw-surface-at-* fox-girl-damage-motion1-right
				  position-x
				  position-y
				  :cell fox-girl-damage-motion1-right-current-cell)
	   (incf frame-counter)
	   (when (> frame-counter (gethash "fox-girl-damage-motion1-right" duration))
	     (incf fox-girl-damage-motion1-right-current-cell)
	     (setf frame-counter 0)
	     (if (> fox-girl-damage-motion1-right-current-cell (gethash "fox-girl-damage-motion1-right"
							total-cell-count))
	       (setf fox-girl-damage-motion1-right-current-cell 0))))
	  ((string= sprite-name "fox-girl-down-motion-left")
	   ;;fox-girl-down-motion-left	   
	   (sdl:draw-surface-at-* fox-girl-down-motion-left
				  position-x
				  position-y
				  :cell fox-girl-down-motion-left-current-cell)
	   (incf frame-counter)
	   (when (> frame-counter (gethash "fox-girl-down-motion-left" duration))
	     (setf frame-counter 0)
	     (if (not (= fox-girl-down-motion-left-current-cell
			 (gethash "fox-girl-down-motion-left" total-cell-count)))
	       (incf fox-girl-down-motion-left-current-cell))))
	  ((string= sprite-name "fox-girl-down-motion-right")
	   ;;fox-girl-down-motion-right
	   (sdl:draw-surface-at-* fox-girl-down-motion-right
				  position-x
				  position-y
				  :cell fox-girl-down-motion-right-current-cell)
	   (incf frame-counter)
	   (when (> frame-counter (gethash "fox-girl-down-motion-right" duration))
	     (setf frame-counter 0)
	     (if (not (= fox-girl-down-motion-right-current-cell
			 (gethash "fox-girl-down-motion-right" total-cell-count)))
	       (incf fox-girl-down-motion-right-current-cell)))))))

