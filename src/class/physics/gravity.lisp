(in-package :game)

(defun generate-free-fall ()
  (let ((g 0) (temp-g 0))
    (lambda (image-object flag)
      (if (eq flag t)
	  (progn
	    (+= (y (image image-object)) (setf temp-g (floor g)))
	    (+= (y (collision image-object)) (setf temp-g (floor g)))
	    (+= g 2.8)
	    (if (>= g 25) (setf g 25)))
	  (setf g 0)))))
	

