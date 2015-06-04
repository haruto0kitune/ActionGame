(in-package :game)

(defclass stage ()
  ((stage-map 
    :documentation "two dimensions array."
    :initform (load-csv "map2.csv"))
   (stage-row
    :reader stage-row
    :initform 0)
   (stage-column
    :reader stage-column
    :initform 0)
   (block-instance-array
    :reader block-instance-array
    :initform nil)
   (the-number-of-row-in-window
    :documentation "window width is 800 and block width is 40. 800 / 40 = 20"
    :reader the-number-of-row-in-window
    :initform 20)
   (the-number-of-column-in-window
    :documentation "window width is 600 and block width is 40. 600 / 40 = 15"
    :reader the-number-of-column-in-window
    :initform 15)
   (scroll
    :reader scroll
    :initform (make-instance 'scroll))))

(defmethod draw-sprite ((stage stage) x y)
  (with-slots (block-instance-array scroll the-number-of-row-in-window the-number-of-column-in-window stage-row stage-column) stage
    (loop for y from 0 to (- the-number-of-column-in-window 1) by 1 collect
	 (loop for x from (- (scroll-array-counter scroll) 1) to (+ the-number-of-row-in-window (scroll-array-counter scroll)) by 1 collect
	      (progn
		(when (>= (draw-flag (flag (aref block-instance-array y x))) 0)
		  (draw-sprite (draw (aref block-instance-array y x))
			       (x (image (aref block-instance-array y x)))
			       (y (image (aref block-instance-array y x))))
;;;;; debug ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		  (when (eq (debug-flag *system-flag*) t)
		    (draw-image-box (aref block-instance-array y x))
		    (draw-collision-box (aref block-instance-array y x)))))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod generate-block-instance ((stage stage))
  (with-slots (block-instance-array stage-column stage-row stage-map) stage
    (let ((block-width 40) (block-height 40))
      (loop for y from 0 to (- stage-column 1) by 1 collect
	   (loop for x from 0 to (- stage-row 1) by 1 collect
		(progn
		  (setf (aref block-instance-array y x) (make-instance 'blocks))
		  (setf (x (image (aref block-instance-array y x))) (* x block-width))
		  (setf (y (image (aref block-instance-array y x))) (* y block-height))
		  (setf (draw-flag (flag (aref block-instance-array y x))) (aref stage-map y x))
		  (setf (id (sprite-sheets (draw (aref block-instance-array y x)))) (aref stage-map y x))))))))

(defmethod initialize-slot ((stage stage))
  (with-slots (stage-row stage-column stage-map block-instance-array) stage
    (setf stage-row (array-dimension stage-map 1))
    (setf stage-column (array-dimension stage-map 0))
    (setf block-instance-array (make-array `(,stage-column ,stage-row)))
    (generate-block-instance stage)))

(defmethod initialize-instance :after ((stage stage) &rest initargs)
  (initialize-slot stage))
