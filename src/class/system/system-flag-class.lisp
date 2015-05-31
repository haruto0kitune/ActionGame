(in-package :game)

(defclass system-flag ()
  ((gameover-flag
    :accessor gameover-flag
    :initarg :gameover-flag)
   (debug-flag
    :accessor debug-flag
    :initarg :debug-flag)
   (full-screen-flag
    :accessor full-screen-flag
    :initarg :full-screen-flag))
  (:default-initargs
   :gameover-flag nil
   :debug-flag t
   :full-screen-flag nil))

(defparameter system-flag (make-instance 'system-flag))



   
   
   
