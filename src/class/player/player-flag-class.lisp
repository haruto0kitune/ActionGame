(in-package :game)

(defclass player-flag ()
  ((direction
    :documentation "right or left"
    :accessor direction
    :initform nil
    :initarg :direction)
   (action-flag
    :accessor action-flag
    :initform nil)
   (draw-flag
    :accessor draw-flag
    :initform t)
   (jump-flag
    :accessor jump-flag
    :initform nil)
   (ground-flag
    :accessor ground-flag
    :initform nil)
   (air-flag
    :accessor air-flag
    :initform nil)
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
    :initform nil)
   (life
    :accessor life
    :initform nil)
   (g-flag
    :accessor g-flag
    :initform t)))

(defparameter *player-flag* (make-instance 'player-flag))
