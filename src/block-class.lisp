(in-package :game)
	    
(defclass blocks ()
  ((filename
    :accessor image-object-filename
    :initform "../pixel_animation/test1.png")
   (x
    :accessor x
    :initform 0
    :initarg :x)
   (y
    :accessor y
    :initform 0
    :initarg :y)
   (w
    :accessor w
    :initform 40)
   (h
    :accessor h
    :initform 40)
   (vx
    :accessor vx
    :initform 0)
   (vy
    :accessor vy
    :initform 0)
   (collision
    :accessor collision
    :initform (make-instance 'rect :x 0 :y 0 :w 40 :h 40))
   (x-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-x-cell-count
    :initform 2)
   (y-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-y-cell-count
    :initform 0
    :initarg :y-cell-count)
   (total-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-total-cell-count
    :initform 2)
   (sprite-sheet
    :accessor image-object-sprite-sheet
    :initform nil
    :initarg :sprite-sheet)
   (current-cell
    :accessor image-object-current-cell
    :initform 0
    :initarg :current-cell)
   (duration
    :accessor image-object-duration
    :initform 0)
   (frame-counter
    :initform 0)
   (draw-flag
    :accessor image-object-draw-flag
    :initform nil
    :initarg :draw-flag)
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
   (id
    :accessor image-object-id
    :initform nil
    :initarg :id)))

(defmethod initialize-instance :after ((blocks blocks) &rest initargs)
  (with-slots (x y collision) blocks
    (setf (x (collision blocks)) x)
    (setf (y (collision blocks)) y)
    (generate-sprite-sheet blocks)))

(defmethod generate-sprite-sheet ((blocks blocks))
  (with-slots (filename w h x-cell-count y-cell-count sprite-sheet) blocks
    (let ((sprite-cells nil))
      (setf sprite-sheet (sdl:load-image filename :color-key sdl:*black*))      
      (setf sprite-cells
	    (loop for y from 0 to (* h y-cell-count) by h
		 append (loop for x from 0 to (* w x-cell-count) by w
			   collect (list x y w h))))
      (setf (sdl:cells sprite-sheet) sprite-cells))))
  
(defmethod draw-sprite ((blocks blocks))
  (with-slots
	(x
	 y
	 total-cell-count
	 sprite-sheet
	 current-cell
	 duration
	 frame-counter
	 draw-flag
	 id)
      blocks
    (cond ((= id 0) (sdl:draw-surface-at-* sprite-sheet x y :cell id))
	  ((= id 1) (sdl:draw-surface-at-* sprite-sheet x y :cell id)))
    (incf frame-counter)
    (when (> frame-counter duration)
      (incf current-cell)
      (setf frame-counter 0)
      (if (> current-cell total-cell-count)
	  (setf current-cell 0)))))
