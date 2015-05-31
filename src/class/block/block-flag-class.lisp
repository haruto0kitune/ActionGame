(in-package :game)

(defclass blocks-flag ()
  ((draw-flag
    :accessor draw-flag
    :initform nil
    :initarg :draw-flag)
   (top-collision-flag
    :accessor top-collision-flag
    :initform nil)
   (bottom-collision-flag
    :accessor bottom-collision-flag
    :initform nil)
   (left-collision-flag
    :accessor left-collision-flag
    :initform nil)
   (right-collision-flag
    :accessor right-collision-flag
    :initform nil)))

(defparameter *blocks-flag* (make-instance 'blocks-flag))
