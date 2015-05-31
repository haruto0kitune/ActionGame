(in-package :game)
	    
(defclass blocks ()
  ((x
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
    :initform (make-instance 'rect :x 0 :y 0 :w 40 :h 40))))

(defmethod initialize-instance :after ((blocks blocks) &rest initargs)
  (with-slots (x y collision) blocks
    (setf (x (collision blocks)) x)
    (setf (y (collision blocks)) y)))
