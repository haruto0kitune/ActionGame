(defun closure-jump (force init-y)
  (let ((F force))
    (lambda (y &optional string)
      (if (string= string "reset")
	  (setf F force))
      (block exit 
	(setf y (- y F))
	(decf F)
	(if (= y init-y)
	    (setf F force))
	(return-from exit y)))))

(defun generate-jump (force init-y)
  (closure-jump force init-y))

(defun jump (closure y)
  (funcall closure y))

	  

		    
