(in-package :game)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; collision-x = position-x + 9  ;;
;; collision-y = position-y + 13 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass piyo ()
  ((hp
    :initform 1
    :initarg :hp)
   (image
    :accessor image
    :initform (make-instance 'rect :x 0 :y 0 :w 40 :h 40))
   (collision
    :accessor collision
    :initform (make-instance 'rect :x 9 :y 13 :w 40 :h 40))
   (attack-collision
    :accessor attack-collision
    :initform (make-instance 'rect :x 9 :y 13 :w 40 :h 40))
   (damage-collision
    :accessor damage-collision
    :initform (make-instance 'rect :x 9 :y 13 :w 40 :h 40))
   (velocity
    :accessor velocity
    :initform (make-instance 'velocity :vx 5 :vy 5))
   (cx-minus-px
    :documentation "position-x minus collision-x"
    :accessor cx-minus-px
    :initform 0)
   (cy-minus-py
    :documentation "position-y minus collision-y"
    :accessor cy-minus-py
    :initform 0)
   (jump-power
    :accessor jump-power
    :initform 20
    :initarg :jump-power)
   (jump
    :accessor jump
    :initform nil)
   (draw
    :reader draw
    :initform (make-instance 'piyo-draw))
   (free-fall
    :reader free-fall
    :initform (generate-free-fall))))

(defmethod initialize-instance :after ((piyo piyo) &rest initargs)
  (with-slots (x y collision attack-collision jump cx-minus-px cy-minus-py) piyo
    (setf (x (collision piyo)) (+ x (x (collision piyo))))
    (setf (y (collision piyo)) (+ y (y (collision piyo))))
    (setf (x (attack-collision piyo)) (x (collision piyo)))
    (setf (y (attack-collision piyo)) (y (collision piyo)))
    (setf (w (attack-collision piyo)) (w (collision piyo)))
    (setf (h (attack-collision piyo)) (h (collision piyo)))
    (setf jump (generate-jump piyo))
    (setf cx-minus-px (- (x (collision piyo)) x))
    (setf cy-minus-py (- (y (collision piyo)) y))))

(defmethod update ((piyo piyo))
  (with-slots (collision attack-collision damage-collision) piyo
    (setf (x (attack-collision piyo)) (x (collision piyo)))
    (setf (y (attack-collision piyo)) (y (collision piyo)))
    (setf (x (damage-collision piyo)) (x (collision piyo)))
    (setf (y (damage-collision piyo)) (y (collision piyo)))))

(defmethod move ((piyo piyo) direction-string)
  (cond ((string= direction-string "left") (move-left piyo))
	((string= direction-string "right") (move-right piyo))))

(defmethod move-left ((piyo piyo))
  (with-slots (x vx collision damage-collision direction) piyo
    (setf direction "left")
    (-= x vx)
    (-= (x (collision piyo)) vx)
    (-= (x (damage-collision piyo)) vx)))

(defmethod move-right ((piyo piyo))
  (with-slots (x vx collision damage-collision direction) piyo
    (setf direction "right")
    (+= x vx)
    (+= (x (collision piyo)) vx)
    (+= (x (damage-collision piyo)) vx)))
	   
(defmethod generate-jump ((piyo piyo))
  (with-slots (jump-power jump-flag collision y) piyo
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
		(-= y (floor force))
		(-= (y (collision piyo)) (floor force))
		(if (not (<= (floor force) 0))
		    (-= force 1.5)
		    (progn
		      (setf jump-flag nil)
		      (setf force start-jump-power))))))))))

(defmethod jump ((piyo piyo))
  (with-slots (jump) piyo
      (funcall jump)))	  
