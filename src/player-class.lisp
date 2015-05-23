;;;;
;;;; player class
;;;;

(in-package :game)

;(load "sprite-sheet-class.lisp" :external-format :utf-8)

(defclass player ()
  ((hp
    :documentation "hit point"
    :accessor image-object-hp
    :initform 1
    :initarg :hp)
   (filename
    :documentation "hash table"
    :accessor image-object-filename
    :initform (make-hash-table :test #'equal))
   (collision-x
    :accessor image-object-collision-x
    :initform 43)
   (collision-y
    :accessor image-object-collision-y
    :initform 15)
   (collision-width
    :accessor image-object-collision-width
    :initform 39)
   (collision-height
    :accessor image-object-collision-height
    :initform 113)
   (damage-collision-x
    :accessor image-object-damage-collision-x
    :initform 0)
   (damage-collision-y
    :accessor image-object-damage-collision-y
    :initform 0)
   (damage-collision-width
    :accessor image-object-damage-collision-width
    :initform 39)
   (damage-collision-height
    :accessor image-object-damage-collision-height
    :initform 113)
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
    :initform 10)
   (velocity-y
    :accessor image-object-velocity-y
    :initform 10)
   (width
    :accessor image-object-width
    :initform 128)
   (height
    :accessor image-object-height
    :initform 128)
   (x-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-x-cell-count
    :initform (make-hash-table :test #'equal)
    :initarg :x-cell-count)
   (y-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-y-cell-count
    :initform 0
    :initarg :y-cell-count)
   (total-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-total-cell-count
    :initform (make-hash-table :test #'equal)
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
    :initform (make-hash-table :test #'equal))
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
    :initform nil)
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

(defmethod set-filename ((player player))
  (with-slots (filename) player
    (setf (gethash "standing-left" filename)
	  "../pixel_animation/player_standing_left.png")
    (setf (gethash "standing-right" filename)
	  "../pixel_animation/player_standing_right.png")
    (setf (gethash "running-left" filename)
	  "../pixel_animation/player_running_left.png")
    (setf (gethash "running-right" filename)
	  "../pixel_animation/player_running_right.png")
    (setf (gethash "jumping-left" filename)
	  "../pixel_animation/player_jumping_left.png")
    (setf (gethash "jumping-right" filename)
	  "../pixel_animation/player_jumping_right.png")
    (setf (gethash "fox-girl-damage-motion1-left" filename)
	  "../pixel_animation/fox_girl_damage_motion1_left.png")
    (setf (gethash "fox-girl-damage-motion1-right" filename)
	  "../pixel_animation/fox_girl_damage_motion1_right.png")
    (setf (gethash "fox-girl-down-motion-left" filename)
	  "../pixel_animation/fox_girl_down_motion_left2.png")
    (setf (gethash "fox-girl-down-motion-right" filename)
	  "../pixel_animation/fox_girl_down_motion_right2.png")))

(defmethod update ((player player))
  (with-slots (collision-x
	       collision-y
;	       attack-collision-x
;	       attack-collision-y
	       damage-collision-x
      	       damage-collision-y)
      player
;   (setf attack-collision-x collision-x)
;   (setf attack-collision-y collision-y)
    (setf damage-collision-x collision-x)
    (setf damage-collision-y collision-y)))

(defmethod initialize-instance :after ((player player) &rest initargs)
  (with-slots (position-x
	       position-y
	       collision-x
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
	       damage-collision-height
	       direction
	       action-name)
      player
    (cond ((string= direction "left")
	   (setf action-name "standing-left"))
	  ((string= direction "right")
	   (setf action-name "standing-right")))
    (set-filename player)
    (set-x-cell-count player)
    (set-total-cell-count player)
    (setf collision-x (+ position-x collision-x))
    (setf collision-y (+ position-y collision-y))
    (setf damage-collision-x collision-x)
    (setf damage-collision-y collision-y)
    (setf damage-collision-width collision-width)
    (setf damage-collision-height collision-height)
    (initialize-player player)))

(defmethod set-x-cell-count ((player player))
  (with-slots (x-cell-count) player
    (setf (gethash "standing-left" x-cell-count) 11)
    (setf (gethash "standing-right" x-cell-count) 11)
    (setf (gethash "running-left" x-cell-count) 7)
    (setf (gethash "running-right" x-cell-count) 7)
    (setf (gethash "jumping-left" x-cell-count) 3)
    (setf (gethash "jumping-right" x-cell-count) 3)
    (setf (gethash "fox-girl-damage-motion1-left" x-cell-count) 2)
    (setf (gethash "fox-girl-damage-motion1-right" x-cell-count) 2)
    (setf (gethash "fox-girl-down-motion-left" x-cell-count) 8)
    (setf (gethash "fox-girl-down-motion-right" x-cell-count) 8)))

(defmethod set-total-cell-count ((player player))
  (with-slots (total-cell-count) player
    (setf (gethash "standing-left" total-cell-count) 11)
    (setf (gethash "standing-right" total-cell-count) 11)
    (setf (gethash "running-left" total-cell-count) 7)
    (setf (gethash "running-right" total-cell-count) 7)
    (setf (gethash "jumping-left" total-cell-count) 3)
    (setf (gethash "jumping-right" total-cell-count) 3)
    (setf (gethash "fox-girl-damage-motion1-left" total-cell-count) 2)
    (setf (gethash "fox-girl-damage-motion1-right" total-cell-count) 2)
    (setf (gethash "fox-girl-down-motion-left" total-cell-count) 8)
    (setf (gethash "fox-girl-down-motion-right" total-cell-count) 8)))

(defmethod set-duration ((player player))
  (with-slots (duration) player
    (setf (gethash "standing-left" duration) 7)
    (setf (gethash "standing-right" duration) 7)
    (setf (gethash "running-left" duration) 4)
    (setf (gethash "running-right" duration) 4)
    (setf (gethash "jumping-left" duration) 4)
    (setf (gethash "jumping-right" duration) 4)
    (setf (gethash "fox-girl-damage-motion1-left" duration) 4)
    (setf (gethash "fox-girl-damage-motion1-right" duration) 4)
    (setf (gethash "fox-girl-down-motion-left" duration) 4)
    (setf (gethash "fox-girl-down-motion-right" duration) 4)))

(defmethod initialize-player ((player player))  
  (with-slots (position-x
	       position-y
	       collision-x
	       collision-y
	       cx-minus-px
	       cy-minus-py
	       var-jump)
      player
    (set-duration player)
    (generate-sprite-sheet player)
    (setf var-jump (generate-jump player))
    (setf cx-minus-px (- collision-x position-x))
    (setf cy-minus-py (- collision-y position-y))))

(defmethod hp ((player player) &optional (value nil))
  (with-slots (hp) player
    (if (eq value nil)
	(return-from hp hp)
	(return-from hp (+= hp value)))))

(defmethod move ((player player) direction-string)
  (cond ((string= direction-string "left")
	 (move-left player))
	((string= direction-string "right")
	 (move-right player))))

(defmethod move-left ((player player))
  (with-slots (position-x
	       collision-x
	       velocity-x
	       direction
	       air-flag
	       action-name)
      player
    (setf direction "left")
    (-= position-x velocity-x)
    (-= collision-x velocity-x)
    (if (eq air-flag nil)
	(setf action-name "running-left")
	(setf action-name "jumping-left"))))

(defmethod move-right ((player player))
  (with-slots (position-x
	       collision-x
	       velocity-x
	       direction
	       air-flag
	       action-name)
      player
    (setf direction "right")
    (+= position-x velocity-x)
    (+= collision-x velocity-x)
    (if (eq air-flag nil)
	(setf action-name "running-right")
	(setf action-name "jumping-right"))))
  
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
  (with-slots (var-jump
	       ground-flag
	       jump-flag
	       direction
	       action-name)
      player
    (when (eq ground-flag t)
      (setf jump-flag t)
      (if (string= direction "left") (setf action-name "jumping-left"))
      (if (string= direction "right") (setf action-name "jumping-right")))
    (funcall var-jump)))

(defmethod set-standing-left ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       standing-left)
      player
    (let ((sprite-cells nil))
      (setf standing-left (sdl:load-image (gethash "standing-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "standing-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells standing-left) sprite-cells))))

(defmethod set-standing-right ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       standing-right)
      player
    (let ((sprite-cells nil))
      (setf standing-right (sdl:load-image (gethash "standing-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "standing-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells standing-right) sprite-cells))))

(defmethod set-running-left ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       running-left)
      player
    (let ((sprite-cells nil))
      (setf running-left (sdl:load-image (gethash "running-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "running-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells running-left) sprite-cells))))

(defmethod set-running-right ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       running-right)
      player
    (let ((sprite-cells nil))
      (setf running-right (sdl:load-image (gethash "running-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "running-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells running-right) sprite-cells))))

(defmethod set-jumping-left ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       jumping-left)
      player
    (let ((sprite-cells nil))
      (setf jumping-left (sdl:load-image (gethash "jumping-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "jumping-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells jumping-left) sprite-cells))))

(defmethod set-jumping-right ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       jumping-right)
      player
    (let ((sprite-cells nil))
      (setf jumping-right (sdl:load-image (gethash "jumping-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "jumping-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells jumping-right) sprite-cells))))

(defmethod set-fox-girl-damage-motion1-left ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       fox-girl-damage-motion1-left)
      player
    (let ((sprite-cells nil))
      (setf fox-girl-damage-motion1-left (sdl:load-image (gethash "fox-girl-damage-motion1-left" filename)
							 :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "fox-girl-damage-motion1-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells fox-girl-damage-motion1-left) sprite-cells))))

(defmethod set-fox-girl-damage-motion1-right ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       fox-girl-damage-motion1-right)
      player
    (let ((sprite-cells nil))
      (setf fox-girl-damage-motion1-right (sdl:load-image (gethash "fox-girl-damage-motion1-right" filename)
							  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "fox-girl-damage-motion1-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells fox-girl-damage-motion1-right) sprite-cells))))

(defmethod set-fox-girl-down-motion-left ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       fox-girl-down-motion-left)
      player
    (let ((sprite-cells nil))
      (setf fox-girl-down-motion-left (sdl:load-image (gethash "fox-girl-down-motion-left" filename)
						      :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "fox-girl-down-motion-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells fox-girl-down-motion-left) sprite-cells))))

(defmethod set-fox-girl-down-motion-right ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       fox-girl-down-motion-right)
      player
    (let ((sprite-cells nil))
      (setf fox-girl-down-motion-right (sdl:load-image (gethash "fox-girl-down-motion-right" filename)
						       :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "fox-girl-down-motion-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells fox-girl-down-motion-right) sprite-cells))))

(defmethod generate-sprite-sheet ((player player))
  (set-standing-left player)
  (set-standing-right player)
  (set-running-left player)
  (set-running-right player)
  (set-jumping-left player)
  (set-jumping-right player)
  (set-fox-girl-damage-motion1-left player)
  (set-fox-girl-damage-motion1-right player)
  (set-fox-girl-down-motion-left player)
  (set-fox-girl-down-motion-right player))

(defmethod standing-left ((player player))
  (with-slots
	(position-x
	 position-y
	 standing-left
	 standing-left-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player
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
	  (setf standing-left-current-cell 0)))))

(defmethod standing-right ((player player))
  (with-slots
	(position-x
	 position-y
	 standing-right
	 standing-right-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player
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
	  (setf standing-right-current-cell 0)))))

(defmethod running-left ((player player))
  (with-slots
	(position-x
	 position-y
	 running-left
	 running-left-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player
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
	  (setf running-left-current-cell 0)))))

(defmethod running-right ((player player))
  (with-slots
	(position-x
	 position-y
	 running-right
	 running-right-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player
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
	  (setf running-right-current-cell 0)))))

(defmethod jumping-left ((player player))
  (with-slots
	(position-x
	 position-y
	 jumping-left
	 jumping-left-current-cell
	 total-cell-count
	 frame-counter
	 duration
	 ground-flag)
      player
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
						   total-cell-count))))))

(defmethod jumping-right ((player player))
  (with-slots
	(position-x
	 position-y
	 jumping-right
	 jumping-right-current-cell
	 total-cell-count
	 frame-counter
	 duration
	 ground-flag)
      player
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
						   total-cell-count))))))

(defmethod fox-girl-damage-motion1-left ((player player))
  (with-slots
	(position-x
	 position-y
	 fox-girl-damage-motion1-left
	 fox-girl-damage-motion1-left-current-cell
	 total-cell-count
	 frame-counter
	 duration
	 hp
	 action-name)
      player
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
	  (setf fox-girl-damage-motion1-left-current-cell 0)))))

(defmethod fox-girl-damage-motion1-right ((player player))
  (with-slots
	(position-x
	 position-y
	 fox-girl-damage-motion1-right
	 fox-girl-damage-motion1-right-current-cell
	 total-cell-count
	 frame-counter
	 duration
	 hp
	 action-name)
      player
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
	  (setf fox-girl-damage-motion1-right-current-cell 0)))))

(defmethod fox-girl-down-motion-left ((player player))
  (with-slots
	(position-x
	 position-y
	 fox-girl-down-motion-left
	 fox-girl-down-motion-left-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player
    (sdl:draw-surface-at-* fox-girl-down-motion-left
			   position-x
			   position-y
			   :cell fox-girl-down-motion-left-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "fox-girl-down-motion-left" duration))
      (setf frame-counter 0)
      (if (not (= fox-girl-down-motion-left-current-cell
		  (gethash "fox-girl-down-motion-left" total-cell-count)))
	  (incf fox-girl-down-motion-left-current-cell)))))

(defmethod fox-girl-down-motion-right ((player player))
  (with-slots
	(position-x
	 position-y
	 fox-girl-down-motion-right
	 fox-girl-down-motion-right-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player
    (sdl:draw-surface-at-* fox-girl-down-motion-right
			   position-x
			   position-y
			   :cell fox-girl-down-motion-right-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "fox-girl-down-motion-right" duration))
      (setf frame-counter 0)
      (if (not (= fox-girl-down-motion-right-current-cell
		  (gethash "fox-girl-down-motion-right" total-cell-count)))
	  (incf fox-girl-down-motion-right-current-cell)))))
    
(defmethod draw-sprite ((player player))
  (with-slots (action-name) player
    (cond ((string= action-name "standing-left") (standing-left player))
	  ((string= action-name "standing-right") (standing-right player))
	  ((string= action-name "running-left") (running-left player))
	  ((string= action-name "running-right") (running-right player))
	  ((string= action-name "jumping-left") (jumping-left player))
	  ((string= action-name "jumping-right") (jumping-right player))
	  ((string= action-name "fox-girl-damage-motion1-left") (fox-girl-damage-motion1-left player))
	  ((string= action-name "fox-girl-damage-motion1-right") (fox-girl-damage-motion1-right player))
	  ((string= action-name "fox-girl-down-motion-left") (fox-girl-down-motion-left player))
	  ((string= action-name "fox-girl-down-motion-right") (fox-girl-down-motion-right player)))))

;(defmethod reset ((player player))
  
