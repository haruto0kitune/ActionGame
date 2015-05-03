;;;;
;;;; piyo class
;;;;

(load "sprite-sheet-class.lisp" :external-format :utf-8)

;;;; generate clojure
(defgeneric generate-jump (piyo))

;;;; sprite
(defgeneric initialize-piyo (piyo))
(defgeneric generate-piyo-sprite-sheet (piyo))
(defgeneric draw-sprite-piyo (piyo sprite-name))

;;;; moving volume
(defgeneric move-left (piyo))
(defgeneric move-right (piyo))

;;;; animation
(defgeneric stand (piyo))
(defgeneric walk (piyo))
(defgeneric attack1 (piyo))


(defclass piyo ()
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
    :initform "piyo-standing-left"
    :initarg :action-name)
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
   (jumping-left
    :documentation "sprite-sheet"
    :accessor image-object-jumping-left
    :initform nil
    :initarg :jumping-left)
   (jumping-right
    :documentation "sprite-sheet"
    :accessor image-object-jumping-right
    :initform nil
    :initarg :jumping-right)w
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

(defmethod initialize-instance :after ((piyo piyo) &rest initargs)
  (initialize-piyo piyo))

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
  
(defmethod move-left ((piyo piyo))
  (with-slots (position-x
	       collision-x
	       velocity-x
	       action-name)
      piyo
;    (setf action-name "piyo-walk-left")
    (-= position-x velocity-x)
    (-= collision-x velocity-x)))

(defmethod move-right ((piyo piyo))
  (with-slots (position-x
	       collision-x
	       velocity-x
	       action-name)
      piyo
 ;   (setf action-name "piyo-walk-right")
    (+= position-x velocity-x)
    (+= collision-x velocity-x)))

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
	  
(defmethod generate-sprite-sheet ((piyo piyo))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       standing-left
	       standing-right
	       walking-left
	       walking-right
	       jumping-left
	       jumping-right
	       attack1-left
	       attack1-right)
      piyo
    (let ((sprite-cells nil))
      ;; standing-left
      (setf standing-left (sdl:load-image (gethash "piyo-standing-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "piyo-standing-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells standing-left) sprite-cells)
      ;; standing-right
      (setf standing-right (sdl:load-image (gethash "piyo-standing-right" filename)
					   :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "piyo-standing-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells standing-right) sprite-cells)
      ;; walking-left
      (setf walking-left (sdl:load-image (gethash "piyo-walking-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "piyo-walking-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells walking-left) sprite-cells)
      ;; walking-right
      (setf walking-right (sdl:load-image (gethash "piyo-walking-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "piyo-walking-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells walking-right) sprite-cells)

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
      (setf (sdl:cells jumping-right) sprite-cells))))
  
(defmethod draw-sprite-piyo ((piyo piyo) sprite-name)
  (with-slots
	(position-x
	 position-y
	 total-cell-count
	 sprite-sheet
	 air-flag
	 ground-flag
	 current-cell
	 duration
	 frame-counter
	 frames
	 standing-left
	 standing-right
	 walking-left
	 walking-right
	 standing-left-current-cell
	 standing-right-current-cell)
      piyo
    (cond ((string= sprite-name "piyo-standing-left")
	   ;;piyo-standing-left
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
		 (setf standing-left-current-cell 0))))
	  ((string= sprite-name "piyo-standing-right")
	   ;;piyo-standing-right
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
		 (setf standing-right-current-cell 0))))
	  ((string= sprite-name "piyo-walking-left")
	   ;;piyo-walking-left
	   (sdl:draw-surface-at-* walking-left
				  position-x
				  position-y
				  :cell standing-left-current-cell)
	   (incf frame-counter)
	   (when (> frame-counter (gethash "piyo-walking-left" duration))
	     (incf standing-left-current-cell)
	     (setf frame-counter 0)
	     (if (> standing-left-current-cell (gethash "piyo-walking-left"
							total-cell-count))
		 (setf standing-left-current-cell 0))))
	  ((string= sprite-name "piyo-walking-right")
	   ;;piyo-walking-right
	   (sdl:draw-surface-at-* walking-right
				  position-x
				  position-y
				  :cell standing-right-current-cell)
	   (incf frame-counter)
	   (when (> frame-counter (gethash "piyo-walking-right" duration))
	     (incf standing-right-current-cell)
	     (setf frame-counter 0)
	     (if (> standing-right-current-cell (gethash "piyo-walking-right"
							 total-cell-count))
		 (setf standing-right-current-cell 0)))))))
	  
