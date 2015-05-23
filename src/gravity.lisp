<<<<<<< HEAD
(in-package :cl-user)
(defpackage gravity
  (:use :cl
	:class
	:util)
  (:export :generate-free-fall))
(in-package :gravity)
=======
(in-package :game)
>>>>>>> hotfix

(defun generate-free-fall ()
  (let ((g 0) (temp-g 0))
    (lambda (image-object flag)
      (if (eq flag t)
	  (progn
	    (+= (image-object-position-y image-object) (setf temp-g (floor g)))
	    (+= (image-object-collision-y image-object) (setf temp-g (floor g)))
	    (+= g 2.8)
	    (if (>= g 25)
		(setf g 25)))	  
	  (setf g 0)))))
	

