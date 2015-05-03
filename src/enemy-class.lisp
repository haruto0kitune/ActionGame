;;;;
;;;; enemy class
;;;;

(load "sprite-sheet-class.lisp" :external-format :utf-8)

;;;; generate clojure
(defgeneric generate-jump (enemy))

;;;; sprite
(defgeneric initialize-enemy (enemy))
(defgeneric generate-enemy-sprite-sheet (enemy))
(defgeneric draw-sprite-enemy (enemy sprite-name))

;;;; moving volume
(defgeneric move-left (enemy))
(defgeneric move-right (enemy))

;;;; animation
(defgeneric stand (enemy))
(defgeneric walk (enemy))
(defgeneric run (enemy))
(defgeneric crouch (enemy))
(defgeneric jump (enemy))
(defgeneric do-atemi1 (enemy))

(defclass enemy ()
  ((hp
    :documentation "hit point"
    :accessor image-object-hp
    :initform 1
    :initarg :hp)
   (frames
    :accessor image-object-frames
    :initfrom nil
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
   (duration
    :accessor image-object-duration
    :initform 0
    :initarg :duration)
   (frame-counter
    :initform 0)
   (px-minus-cx
    :documentation "position-x minus collision-x"
    :accessor image-object-px-minus-cx
    :initform 0)
   (py-minus-cy
    :documentation "position-y minus collision-y"
    :accessor image-object-py-minus-cy
    :initform 0)
   (direction
    :documentation "right or left"
    :accessor image-object-direction
    :initform nil)
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
    :initarg :atemi1-right)))

(defmethod initialize-instance :after ((enemy enemy) &rest initargs)
  (initialize-enemy enemy))

(defmethod initialize-enemy ((enemy enemy))  
  (with-slots (position-x
	       position-y
	       collision-x
	       collision-y
	       px-minus-cx
	       py-minus-cy
	       var-jump)
      enemy
    (generate-sprite-sheet enemy)
    (setf var-jump (generate-jump enemy))
    (setf px-minus-cx collision-x)
    (setf py-minus-cy collision-y)))
  
(defmethod move-left ((enemy enemy))
  (with-slots (position-x
	       collision-x
	       velocity-x)
      enemy
    (-= position-x velocity-x)
    (-= collision-x velocity-x)))

(defmethod move-right ((enemy enemy))
  (with-slots (position-x
	       collision-x
	       velocity-x)
      enemy
    (+= position-x velocity-x)
    (+= collision-x velocity-x)))

(defmethod generate-jump ((enemy enemy))
  (with-slots (jump-power jump-flag) enemy
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
		(-= (image-object-position-y enemy) (floor force))
		(-= (image-object-collision-y enemy) (floor force))		
		(if (not (<= (floor force) 0))
		    (-= force 1.5)
		    (progn
		      (setf jump-flag nil)
		      (setf force start-jump-power))))))))))

(defmethod jump ((enemy enemy))
  (with-slots (var-jump) enemy
      (funcall var-jump)))
	  
(defmethod generate-sprite-sheet ((enemy enemy))
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
	       )
      enemy
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
      (setf (sdl:cells jumping-right) sprite-cells))))      
  
(defmethod draw-sprite-enemy ((enemy enemy) sprite-name)
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
	 frames)
      enemy
    (sdl:draw-surface-at-* sprite
