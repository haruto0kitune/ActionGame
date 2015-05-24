;;;;
;;;; piyo class
;;;;

(in-package :game)

;(load "sprite-sheet-class.lisp" :external-format :utf-8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; collision-x = position-x + 9  ;;
;; collision-y = position-y + 13 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass piyo ()
  ((hp
    :accessor image-object-hp
    :initform 1
    :initarg :hp)
   (filename
    :documentation "hash table"
    :accessor image-object-filename
    :initform (make-hash-table :test #'equal))
   (collision-x
    :accessor image-object-collision-x
    :initform 9)
   (collision-y
    :accessor image-object-collision-y
    :initform 13)
   (collision-width
    :accessor image-object-collision-width
    :initform 40)
   (collision-height
    :accessor image-object-collision-height
    :initform 40)
   (attack-collision-x
    :accessor image-object-attack-collision-x
    :initform 0)
   (attack-collision-y
    :accessor image-object-attack-collision-y
    :initform 0)
   (attack-collision-width
    :accessor image-object-attack-collision-width
    :initform 0)
   (attack-collision-height
    :accessor image-object-attack-collision-height
    :initform 0)
   (damage-collision-x
    :accessor image-object-damage-collision-x
    :initform 9)
   (damage-collision-y
    :accessor image-object-damage-collision-y
    :initform 13)
   (damage-collision-width
    :accessor image-object-damage-collision-width
    :initform 40)
   (damage-collision-height
    :accessor image-object-damage-collision-height
    :initform 40)
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
    :initform 5)
   (velocity-y
    :accessor image-object-velocity-y
    :initform 5)
   (width
    :accessor image-object-width
    :initform 64)
   (height
    :accessor image-object-height
    :initform 64)
   (x-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-x-cell-count
    :initform (make-hash-table :test #'equal))
   (y-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-y-cell-count
    :initform 0)
   (total-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-total-cell-count
    :initform (make-hash-table :test #'equal))
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
   (walking-left-current-cell
    :accessor image-object-walking-left-current-cell
    :initform 0
    :initarg :walking-left-current-cell)
   (walking-right-current-cell
    :accessor image-object-walking-right-current-cell
    :initform 0
    :initarg :walking-right-current-cell)
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
    :initform t)
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
   (attack1-left
    :documentation "sprite-sheet"
    :accessor image-object-attack1-left
    :initform nil
    :initarg :attack1-left)
   (attack1-right
    :documentation "sprite-sheet"
    :accessor image-object-attack1-right
    :initform nil
    :initarg :attack1-right)))

(defmethod set-filename ((piyo piyo))
  (with-slots (filename) piyo
    (setf (gethash "piyo-standing-left" filename)
	  "../pixel_animation/enemy/enemy1_standing1_left.png")
    (setf (gethash "piyo-standing-right" filename)
	  "../pixel_animation/enemy/enemy1_standing1_right.png")
    (setf (gethash "piyo-walking-left" filename)
	  "../pixel_animation/enemy/enemy1_walk_left.png")
    (setf (gethash "piyo-walking-right" filename)
	  "../pixel_animation/enemy/enemy1_walk_right.png")))

(defmethod set-duration ((piyo piyo))
  (with-slots (duration) piyo
    (setf (gethash "piyo-standing-left" duration) 1)
    (setf (gethash "piyo-standing-right" duration) 1)
    (setf (gethash "piyo-walking-left" duration) 3)
    (setf (gethash "piyo-walking-right" duration) 3)))

(defmethod set-x-cell-count ((piyo piyo))
  (with-slots (x-cell-count) piyo
    (setf (gethash "piyo-standing-left" x-cell-count) 0)
    (setf (gethash "piyo-standing-right" x-cell-count) 0)
    (setf (gethash "piyo-walking-left" x-cell-count) 1)
    (setf (gethash "piyo-walking-right" x-cell-count) 1)))

(defmethod set-total-cell-count ((piyo piyo))
  (with-slots (total-cell-count) piyo
    (setf (gethash "piyo-standing-left" total-cell-count) 0)
    (setf (gethash "piyo-standing-right" total-cell-count) 0)
    (setf (gethash "piyo-walking-left" total-cell-count) 1)
    (setf (gethash "piyo-walking-right" total-cell-count) 1)))

(defmethod initialize-instance :after ((piyo piyo) &rest initargs)
  (with-slots (position-x
	       position-y
	       collision-x
	       collision-y
	       collision-width
	       collision-height
	       attack-collision-x
	       attack-collision-y
	       attack-collision-width
	       attack-collision-height
	       direction
	       action-name)
      piyo
    (cond ((string= direction "left")
	   (setf action-name "piyo-standing-left"))
	  ((string= direction "right")
	   (setf action-name "piyo-standing-right")))
    (set-filename piyo)
    (set-duration piyo)
    (setf collision-x (+ position-x collision-x))
    (setf collision-y (+ position-y collision-y))
    (set-x-cell-count piyo)
    (set-total-cell-count piyo)
    (setf attack-collision-x collision-x)
    (setf attack-collision-y collision-y)
    (setf attack-collision-width collision-width)
    (setf attack-collision-height collision-height)
    (initialize-piyo piyo)))

(defmethod initialize-piyo ((piyo piyo))  
  (with-slots (position-x
	       position-y
	       collision-x
	       collision-y
	       cx-minus-px
	       cy-minus-py
	       var-jump)
      piyo
    (generate-sprite-sheet piyo)
    (setf var-jump (generate-jump piyo))
    (setf cx-minus-px (- collision-x position-x))
    (setf cy-minus-py (- collision-y position-y))))

(defmethod update ((piyo piyo))
  (with-slots (collision-x
	       collision-y
	       attack-collision-x
	       attack-collision-y
	       damage-collision-x
      	       damage-collision-y)
      piyo
    (setf attack-collision-x collision-x)
    (setf attack-collision-y collision-y)
    (setf damage-collision-x collision-x)
    (setf damage-collision-y collision-y)))

(defmethod move ((piyo piyo) direction-string)
  (cond ((string= direction-string "left")
	 (move-left piyo))
	((string= direction-string "right")
	 (move-right piyo))))

(defmethod move-left ((piyo piyo))
  (with-slots (position-x
	       collision-x
	       damage-collision-x
	       velocity-x
	       direction)
      piyo
    (setf direction "left")
    (-= position-x velocity-x)
    (-= collision-x velocity-x)
    (-= damage-collision-x velocity-x)))

(defmethod move-right ((piyo piyo))
  (with-slots (position-x
	       collision-x
	       damage-collision-x
	       velocity-x
	       direction)
      piyo
    (setf direction "right")
    (+= position-x velocity-x)
    (+= collision-x velocity-x)
    (+= damage-collision-x velocity-x)))
	   
(defmethod generate-jump ((piyo piyo))
  (with-slots (jump-power jump-flag) piyo
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
		(-= (image-object-position-y piyo) (floor force))
		(-= (image-object-collision-y piyo) (floor force))		
		(if (not (<= (floor force) 0))
		    (-= force 1.5)
		    (progn
		      (setf jump-flag nil)
		      (setf force start-jump-power))))))))))

(defmethod jump ((piyo piyo))
  (with-slots (var-jump) piyo
      (funcall var-jump)))

(defmethod set-standing-left ((piyo piyo))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       standing-left)
      piyo
    (let ((sprite-cells nil))
      (setf standing-left (sdl:load-image (gethash "piyo-standing-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "piyo-standing-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells standing-left) sprite-cells))))

(defmethod set-standing-right ((piyo piyo))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       standing-right)
      piyo
    (let ((sprite-cells nil))
      (setf standing-right (sdl:load-image (gethash "piyo-standing-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "piyo-standing-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells standing-right) sprite-cells))))

(defmethod set-walking-left ((piyo piyo))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       walking-left)
      piyo
    (let ((sprite-cells nil))
      (setf walking-left (sdl:load-image (gethash "piyo-walking-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "piyo-walking-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells walking-left) sprite-cells))))

(defmethod set-walking-right ((piyo piyo))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       walking-right)
      piyo
    (let ((sprite-cells nil))
      (setf walking-right (sdl:load-image (gethash "piyo-walking-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "piyo-walking-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells walking-right) sprite-cells))))

(defmethod generate-sprite-sheet ((piyo piyo))
  (set-standing-left piyo)
  (set-standing-right piyo)
  (set-walking-left piyo)
  (set-walking-right piyo))

(defmethod piyo-standing-left ((piyo piyo))
  (with-slots
	(position-x
	 position-y
	 standing-left
	 standing-left-current-cell
	 total-cell-count
	 duration
	 frame-counter)
      piyo
    (sdl:draw-surface-at-* standing-left
			   position-x
			   position-y
			   :cell standing-left-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "piyo-standing-left" duration))
      (incf standing-left-current-cell)
      (setf frame-counter 0)
      (if (> standing-left-current-cell (gethash "piyo-standing-left"
						 total-cell-count))
	  (setf standing-left-current-cell 0)))))

(defmethod piyo-standing-right ((piyo piyo))
  (with-slots
	(position-x
	 position-y
	 standing-right
	 standing-right-current-cell
	 total-cell-count
	 duration
	 frame-counter)
      piyo
    (sdl:draw-surface-at-* standing-right
			   position-x
			   position-y
			   :cell standing-right-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "piyo-standing-right" duration))
      (incf standing-right-current-cell)
      (setf frame-counter 0)
      (if (> standing-right-current-cell (gethash "piyo-standing-right"
						  total-cell-count))
	  (setf standing-right-current-cell 0)))))

(defmethod piyo-walking-left ((piyo piyo))
  (with-slots
	(position-x
	 position-y
	 walking-left
	 walking-left-current-cell
	 total-cell-count
	 duration
	 frame-counter)
      piyo
    (sdl:draw-surface-at-* walking-left
			   position-x
			   position-y
			   :cell walking-left-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "piyo-walking-left" duration))
      (incf walking-left-current-cell)
      (setf frame-counter 0)
      (if (> walking-left-current-cell (gethash "piyo-walking-left"
						 total-cell-count))
	  (setf walking-left-current-cell 0)))))

(defmethod piyo-walking-right ((piyo piyo))
  (with-slots
	(position-x
	 position-y
	 walking-right
	 walking-right-current-cell
	 total-cell-count
	 duration
	 frame-counter)
      piyo
    (sdl:draw-surface-at-* walking-right
			   position-x
			   position-y
			   :cell walking-right-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "piyo-walking-right" duration))
      (incf walking-right-current-cell)
      (setf frame-counter 0)
      (if (> walking-right-current-cell (gethash "piyo-walking-right"
						total-cell-count))
	  (setf walking-right-current-cell 0)))))

(defmethod draw-sprite ((piyo piyo))
  (with-slots (action-name) piyo
    (cond ((string= action-name "piyo-standing-left") (piyo-standing-left piyo))
	  ((string= action-name "piyo-standing-right") (piyo-standing-right piyo))
	  ((string= action-name "piyo-walking-left") (piyo-walking-left piyo))
	  ((string= action-name "piyo-walking-right") (piyo-walking-right piyo)))))
	  
