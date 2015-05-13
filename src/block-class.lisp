(defclass blocks ()
  ((filename
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
   (duration
    :accessor image-object-duration
    :initform 0
    :initarg :duration)
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
  (generate-sprite-sheet blocks))

(defmethod generate-sprite-sheet ((blocks blocks))
  (with-slots (filename width height x-cell-count y-cell-count sprite-sheet)
      blocks
    (let ((sprite-cells nil))
      (setf sprite-sheet (sdl:load-image filename :color-key sdl:*black*))      
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
		 append (loop for x from 0 to (* width x-cell-count) by width
			   collect (list x y width height))))
      (setf (sdl:cells sprite-sheet) sprite-cells))))
  
(defmethod draw-sprite ((blocks blocks))
  (with-slots
	(position-x
	 position-y
	 total-cell-count
	 sprite-sheet
	 current-cell
	 duration
	 frame-counter
	 draw-flag
	 id)
      blocks
    (cond ((= id 0)
	   (sdl:draw-surface-at-* sprite-sheet
				  position-x
				  position-y
				  :cell id))
	  ((= id 1)
	   (sdl:draw-surface-at-* sprite-sheet
				  position-x
				  position-y
				  :cell id)))
    (incf frame-counter)
    (when (> frame-counter duration)
      (incf current-cell)
      (setf frame-counter 0)
      (if (> current-cell total-cell-count)
	  (setf current-cell 0)))))
