(in-package :game)

(defclass stage ()
  ((stage-map 
    :documentation "two dimensions array."
    :initform (load-csv "map2.csv"))
   (stage-row
    :initform 0)
   (stage-column
    :initform 0)    
   (scroll-vx
    :initform 10)
   (block-instance-array
    :initform nil)
   (the-number-of-row-in-window
    :documentation "window width is 800 and block width is 40. 800 / 40 = 20"
    :initform 20)
   (scroll-array-counter
    :initform 0)
   (scroll-left-border
    :initform 300)
   (scroll-right-border
    :initform 600)))    

(defmethod initialize-slot ((stage stage))
  (with-slots (stage-row stage-column stage-map) stage
    (setf stage-row (array-dimension stage-map 1))
    (setf stage-column (array-dimension stage-map 0))    
    (generate-block-instance stage)))

(defmethod generate-block-instance ((stage stage))
  (with-slots (block-instance-array stage-column stage-row stage-map) stage
    (let ((block-width 40) (block-height 40))
      (loop for y from 0 to (- block-column 1) by 1 collect
	   (loop for x from 0 to (- block-row 1) by 1 collect
		(setf (aref block-instance-array y x)
		      (make-instance 'blocks
				     :x (* x block-width) 
				     :y (* y block-height) 
				     :draw-flag (aref stage-map y x)
				     :id (aref stage-map y x))))))))

(defmethod add-scroll-vx-blocks ((stage stage))
  (with-slots (scroll-vx block-instance-array stage-column stage-row) stage
    (loop for y from 0 to (- stage-column 1) by 1 collect
	 (loop for x from 0 to (- stage-row 1) by 1 collect
	      (x (aref block-instance-array y x) scroll-vx)))))

(defmethod sub-scroll-vx-blocks ((stage stage))
  (with-slots (scroll-vx block-instance-array stage-column stage-row) stage
    (loop for y from 0 to (- stage-column 1) by 1 collect
	 (loop for x from 0 to (- stage-row 1) by 1 collect
	      (x (aref block-instance-array y x) (- scroll-vx))))))

(defmethod add-scroll-vx-character ((stage stage) instance)
  (with-slots (scroll-vx) stage
    (x instance scroll-vx)))

(defmethod sub-scroll-vx-character ((stage stage) instance)
  (with-slots (scroll-vx) stage
    (x instance (- scroll-vx))))

(defmethod left-scroll ((stage stage) player)
  (with-slots (block-instance-array scroll-array-counter the-number-of-row-in-window scroll-left-border) stage
    (when (< (x (collision player)) scroll-line-left)
      (sub-scroll-vx stage)
      (when (>= (x (aref block-instance-array 0 (+ scroll-array-counter the-number-of-row-in-window))) 800)
	(if (not (= scroll-array-counter 0)) (-= scroll-array-counter 1))))))
  
(defmethod right-scroll ((stage stage) player)
  (with-slots (block-instance-array scroll-array-counter the-number-of-row-in-window scroll-right-border stage-row) stage
    (when (> (x (collision player)) scroll-right-border)
      (add-scroll-vx stage)
      (when (<= (x (aref block-instance-array 0 scroll-array-counter)) -40)
	(if (not (= (+ scroll-array-counter the-number-of-row-in-window) (- stage-row 1))) (+= scroll-array-counter 1))))))
    
(defmethod scroll ((stage stage))
  (left-scroll stage)
  (right-scroll stage))

(defmethod initialize-instance :after ((stage stage) &rest initargs)
  (initialize-slot stage))
