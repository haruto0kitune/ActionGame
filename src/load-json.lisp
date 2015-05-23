(in-package :load-json)	    

;(defstruct sprite-sheet-data
;  (frames (make-frames))
;  (meta (make-meta)))

(defstruct frames
  (duration 0))

(defun generate-duration-array (filename)
  (let* ((frames-array (generate-frames-array filename))
	(duration-array (make-array (array-dimension frames-array 0))))
    (loop for x across frames-array with i = -1 do (incf i) collect
	 (setf (aref duration-array i) (frames-duration (aref frames-array i))))
    (return-from generate-duration-array duration-array)))

(defun generate-frames-array (filename)
  (let (array)
    (setf array (make-array (length (cdr (car (load-json filename))))))
    (loop for x across array with i = -1 do (incf i) collect
	 (setf (aref array i) (make-frames :duration (cdr (nth 6 (nth i (cdr (car (load-json filename)))))))))
    (return-from generate-frames-array array)))

(defun load-json (filename)
  "read json file, then return list"
  (with-open-file (stream filename)
    (json:decode-json stream)))
    
