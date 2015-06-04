(in-package :game)

(defun generate-free-fall ()
  (let ((g 0) (temp-g 0))
    (lambda (flag)
      (if (eq flag t)
	  (progn
	    (+= g 0.6)
	    (if (>= g 12) (setf g 12))
	    (setf temp-g (floor g)))
	  (setf g 0)))))


	

