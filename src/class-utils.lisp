(in-package :game)

(defclass line-segment ()
  ((a
    :accessor a
    :initarg :a)
   (b
    :accessor b
    :initarg :b)))

(defmethod translate ((line-segment line-segment) x y)
  (with-slots (a b) line-segment
    (+= (svref a 0) x)
    (+= (svref a 1) y)
    (+= (svref b 0) x)
    (+= (svref b 1) y)))

(defclass velocity ()
  ((vx
    :accessor vx
    :initform 0
    :initarg :vx)
   (vy
    :accessor vy
    :initform 0
    :initarg :vy)))

(defclass rect ()
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
    :initform 0
    :initarg :w)
   (h
    :accessor h
    :initform 0
    :initarg :h)))

(defclass image ()
  ((filename
    :accessor filename
    :initform nil
    :initarg :filename)
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
    :initform 0
    :initarg :w)
   (h
    :accessor h
    :initform 0
    :initarg :h)))
