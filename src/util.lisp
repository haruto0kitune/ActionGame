(in-package util)

(defmacro -= (n1 n2)
  `(setf ,n1 (- ,n1 ,n2)))

(defmacro += (n1 n2)
  `(setf ,n1 (+ ,n1 ,n2)))

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
