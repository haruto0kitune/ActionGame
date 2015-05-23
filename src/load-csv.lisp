(in-package :load-csv)

(defun load-csv (filename)
  "input csv filename, return array"
  (list-to-2d-array (string-to-number (load-csv-file filename))))

(defun load-csv-file (filename)
  "input csv filename, return list of character"
  (with-open-file (csv filename)
    (loop for line = (csv-parser:read-csv-line csv)
       while line
       collect line)))

(defun string-to-number (&optional list)
  "input list of character, return list of number"
  (let* ((x (length (car list))) (y (length list)))
    (loop for loop-y from 0 to (- y 1) by 1 collect
	 (loop for loop-x from 0 to (- x 1) by 1 collect
	      (read-from-string (nth loop-x (nth loop-y list)))))))

(defun list-to-2d-array (&optional list)
  "input list of number, return 2d array"
  (let* ((x (length (car list))) (y (length list)) (array))
    (setf array (make-array `(,y ,x)))
    (loop for loop-y from 0 to (- y 1) by 1 collect
	 (loop for loop-x from 0 to (- x 1) by 1 collect
	      (setf (aref array loop-y loop-x) (nth loop-x (nth loop-y list)))))
    (return-from list-to-2d-array array)))


      
	    


