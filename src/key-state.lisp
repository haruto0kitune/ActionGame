(in-package :game)

;; generic function
(defgeneric update-key-state (key key-press key-state)
  (:documentation "Updates state of key"))

;; input key class macro
(defmacro defkeystate (name &rest key-maps)
  `(progn
     (defclass ,name ()
       ,(loop for k in key-maps collect `(,(car k) :initform nil)))
     ,(let ((key (gensym)) (key-press (gensym)) (key-state (gensym)))
	   `(defmethod update-key-state (,key ,key-press (,key-state ,name))
	      (with-slots ,(mapcar #'car key-maps) ,key-state
		(cond ,@(loop for k in key-maps
			   collect `((sdl:key= ,key ,(cadr k))
				     (setf ,(car k) ,key-press)))))))))

;; input key class
(defkeystate key-state
  (right :sdl-key-right)
  (left :sdl-key-left)
  (up :sdl-key-up)
  (x :sdl-key-x))
