(load "collision.lisp" :external-format :utf-8)

(defun collision-of-rect-and-rect-test ()
  (format t "test1~%")
  (let ((rect1 (make-rect :x 0 :y 0 :w 50 :h 50))
	(rect2 (make-rect :x 100 :y 100 :w 50 :h 50)))
    (format t
	    "rect1:~a ~a ~a ~a~%"
	    (rect-x rect1)
	    (rect-y rect1)
	    (rect-w rect1)
	    (rect-h rect1))
    (format t
	    "rect2:~a ~a ~a ~a~%"
	    (rect-x rect2)
	    (rect-y rect2)
	    (rect-w rect2)
	    (rect-h rect2))
    (format t "collision:~a~%" (collision-of-rect-and-rect rect1 rect2)))
  (format t "test2~%")
  (let ((rect1 (make-rect :x 100 :y 100 :w 50 :h 50))
	(rect2 (make-rect :x 100 :y 100 :w 50 :h 50)))
    (format t
	    "rect1:~a ~a ~a ~a~%"
	    (rect-x rect1)
	    (rect-y rect1)
	    (rect-w rect1)
	    (rect-h rect1))
    (format t
	    "rect2:~a ~a ~a ~a~%"
	    (rect-x rect2)
	    (rect-y rect2)
	    (rect-w rect2)
	    (rect-h rect2))
    (format t "collision:~a~%" (collision-of-rect-and-rect rect1 rect2)))
  (format t "test3~%")
  (let ((rect1 (make-rect :x 110 :y 110 :w 50 :h 50))
	(rect2 (make-rect :x 100 :y 100 :w 50 :h 50)))
    (format t
	    "rect1:~a ~a ~a ~a~%"
	    (rect-x rect1)
	    (rect-y rect1)
	    (rect-w rect1)
	    (rect-h rect1))
    (format t
	    "rect2:~a ~a ~a ~a~%"
	    (rect-x rect2)
	    (rect-y rect2)
	    (rect-w rect2)
	    (rect-h rect2))
    (format t "collision:~a~%" (collision-of-rect-and-rect rect1 rect2)))
  (format t "test4~%")
  (let ((rect1 (make-rect :x 150 :y 110 :w 50 :h 50))
	(rect2 (make-rect :x 100 :y 100 :w 50 :h 50)))
    (format t
	    "rect1:~a ~a ~a ~a~%"
	    (rect-x rect1)
	    (rect-y rect1)
	    (rect-w rect1)
	    (rect-h rect1))
    (format t
	    "rect2:~a ~a ~a ~a~%"
	    (rect-x rect2)
	    (rect-y rect2)
	    (rect-w rect2)
	    (rect-h rect2))
    (format t "collision:~a~%" (collision-of-rect-and-rect rect1 rect2)))
  (format t "test5~%")
  (let ((rect1 (make-rect :x 151 :y 110 :w 50 :h 50))
	(rect2 (make-rect :x 100 :y 100 :w 50 :h 50)))
    (format t
	    "rect1:~a ~a ~a ~a~%"
	    (rect-x rect1)
	    (rect-y rect1)
	    (rect-w rect1)
	    (rect-h rect1))
    (format t
	    "rect2:~a ~a ~a ~a~%"
	    (rect-x rect2)
	    (rect-y rect2)
	    (rect-w rect2)
	    (rect-h rect2))
    (format t "collision:~a~%" (collision-of-rect-and-rect rect1 rect2)))
  (format t "test6~%")
  (let ((rect1 (make-rect :x 100 :y 100 :w 40 :h 40))
	(rect2 (make-rect :x 100 :y 100 :w 50 :h 50)))
    (format t
	    "rect1:~a ~a ~a ~a~%"
	    (rect-x rect1)
	    (rect-y rect1)
	    (rect-w rect1)
	    (rect-h rect1))
    (format t
	    "rect2:~a ~a ~a ~a~%"
	    (rect-x rect2)
	    (rect-y rect2)
	    (rect-w rect2)
	    (rect-h rect2))
    (format t "collision:~a~%" (collision-of-rect-and-rect rect1 rect2))))

