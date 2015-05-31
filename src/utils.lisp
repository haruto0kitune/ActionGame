(in-package :game)

(defmacro -= (n1 n2)
  `(setf ,n1 (- ,n1 ,n2)))

(defmacro += (n1 n2)
  `(setf ,n1 (+ ,n1 ,n2)))

(defmacro push-head (l additional)
  "add element to list"
  `(cons ,additional ,l))

(defmacro push-tail (l additional)
  "add element to list"
  (let ((a `'(,additional)))
  `(append ,l ,a)))

(defun draw-collision-box (instance)
  (when (eq (debug-flag system-flag) t)
    (let ((color (sdl:color :r 255)))
      (sdl:draw-rectangle-* (x (collision instance))
			    (y (collision instance))
			    (w (collision instance))
			    (h (collision instance))
			    :color color))))

(defun draw-damage-box (instance)
  (when (eq (debug-flag system-flag) t)
    (let ((color (sdl:color :b 255)))
      (sdl:draw-rectangle-* (x (damage-collision instance))
			    (y (damage-collision instance))
			    (w (damage-collision instance))
			    (h (damage-collision instance))
			    :color color))))

(defun load-csv (filename)
  "input csv filename, return array"
  (labels ((load-csv-file (filename)
	     "input csv filename, return list of character"
	     (with-open-file (csv filename)
	       (loop for line = (csv-parser:read-csv-line csv)
		  while line
		  collect line)))
	   (string-to-number (&optional list)
	     "input list of character, return list of number"
	     (let* ((x (length (car list))) (y (length list)))
	       (loop for loop-y from 0 to (- y 1) by 1 collect
		    (loop for loop-x from 0 to (- x 1) by 1 collect
			 (read-from-string (nth loop-x (nth loop-y list)))))))
	   (list-to-2d-array (&optional list)
	     "input list of number, return 2d array"
	     (let* ((x (length (car list))) (y (length list)) (array))
	       (setf array (make-array `(,y ,x)))
	       (loop for loop-y from 0 to (- y 1) by 1 collect
		    (loop for loop-x from 0 to (- x 1) by 1 collect
			 (setf (aref array loop-y loop-x) (nth loop-x (nth loop-y list)))))
	       (return-from list-to-2d-array array))))
    (list-to-2d-array (string-to-number (load-csv-file filename)))))
