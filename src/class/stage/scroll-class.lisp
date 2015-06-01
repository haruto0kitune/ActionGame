(in-package :game)

(defclass scroll ()
  ((scroll-vx
    :accessor scroll-vx
    :initform 10)
   (scroll-array-counter
    :accessor scroll-array-counter
    :initform 0)
   (scroll-left-border
    :accessor scroll-left-border
    :initform 200)
   (scroll-right-border
    :accessor scroll-right-border
    :initform 600)))

(defmethod add-scroll-vx-blocks ((scroll scroll) stage)
  (with-slots (scroll-vx) scroll
    (loop for y from 0 to (- (stage-column stage) 1) by 1 collect
	 (loop for x from 0 to (- (stage-row stage) 1) by 1 collect
	      (progn
		(+= (x (image (aref (block-instance-array stage) y x))) scroll-vx)
		(+= (x (collision (aref (block-instance-array stage) y x))) scroll-vx))))))

(defmethod sub-scroll-vx-blocks ((scroll scroll) stage)
  (with-slots (scroll-vx) scroll
    (loop for y from 0 to (- (stage-column stage) 1) by 1 collect
	 (loop for x from 0 to (- (stage-row stage) 1) by 1 collect
	      (progn
		(-= (x (image (aref (block-instance-array stage) y x))) scroll-vx)
		(-= (x (collision (aref (block-instance-array stage) y x))) scroll-vx))))))

(defmethod add-scroll-vx-character ((scroll scroll) instance)
  (with-slots (scroll-vx) scroll
    (+= (x (image instance)) scroll-vx)
    (+= (x (collision instance)) scroll-vx)
    (+= (x (damage-collision instance)) scroll-vx)))

(defmethod sub-scroll-vx-character ((scroll scroll) instance)
  (with-slots (scroll-vx) scroll
    (-= (x (image instance)) scroll-vx)
    (-= (x (collision instance)) scroll-vx)
    (-= (x (damage-collision instance)) scroll-vx)))

(defmethod left-scroll ((scroll scroll) player stage)
  (with-slots (scroll-array-counter scroll-left-border) scroll
    (when (< (x (collision player)) scroll-left-border)
      (add-scroll-vx-blocks scroll stage)
      (add-scroll-vx-character scroll player)
      (when (>= (x (collision (aref (block-instance-array stage) 0 (+ scroll-array-counter (the-number-of-row-in-window stage))))) 800)
	(if (not (= scroll-array-counter 0)) (-= scroll-array-counter 1))))))
  
(defmethod right-scroll ((scroll scroll) player stage)
  (with-slots (scroll-array-counter scroll-right-border) scroll
    (when (> (x (collision player)) scroll-right-border)
      (sub-scroll-vx-blocks scroll stage)
      (sub-scroll-vx-character scroll player)
      (when (<= (x (collision (aref (block-instance-array stage) 0 scroll-array-counter))) 600)
;	(if (not (= (+ scroll-array-counter (the-number-of-row-in-window stage)) (stage-row stage))) (+= scroll-array-counter 1))))))
	(if (not (= (+ scroll-array-counter (the-number-of-row-in-window stage)) (- (stage-row stage) 1))) (+= scroll-array-counter 1))))))
    
(defmethod do-scroll ((scroll scroll) player stage)
  (left-scroll scroll player stage)
  (right-scroll scroll player stage))
