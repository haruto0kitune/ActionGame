(in-package :game)

(defclass system-data ()
  ((window-width
    :reader window-width
    :initform 800)
   (window-height
    :reader window-height
    :initform 600)
   (window-center-x
    :reader window-center-x
    :initform 400)))

(defparameter *system-data* (make-instance 'system-data))
