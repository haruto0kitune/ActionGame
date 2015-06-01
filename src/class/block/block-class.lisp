(in-package :game)
	    
(defclass blocks ()
  ((image
    :accessor image
    :initform (make-instance 'rect :x 0 :y 0 :w 40 :h 40))
   (velocity
    :accessor velocity
    :initform (make-instance 'velocity :vx 0 :vy 0))
   (collision
    :accessor collision
    :initform (make-instance 'rect :x 0 :y 0 :w 40 :h 40))
   (draw
    :reader draw
    :initform (make-instance 'blocks-draw))
   (flag
    :reader flag
    :initform (make-instance 'blocks-flag))))

(defmethod initialize-instance :after ((blocks blocks) &rest initargs)
  (with-slots (image collision) blocks
    (setf (x collision) (x image))
    (setf (y collision) (y image))))
