(in-package :game)

(defclass velocity ()
  ((vx
    :accessor vx
    :initarg :vx)
   (vy
    :accessor vy
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
