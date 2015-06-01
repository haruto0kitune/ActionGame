;;;; uses instance of piyo-flag class
;;;; piyo-flag is global

(in-package :game)

(defclass piyo-draw ()
  ((sprite-sheets    
    :initform (make-instance 'piyo-sprite-sheet))
   (draw-closure
    :initform (make-hash-table :test #'equal))))

(defmethod standing-left ((piyo-draw piyo-draw))
  (with-slots (sprite-sheets) piyo-draw
    (let ((current-cell 0) (frame-counter 0))
      (lambda (x y)
	(sdl:draw-surface-at-* (gethash "standing-left" (sprite-sheet sprite-sheets)) x y :cell current-cell)
	(incf frame-counter)
	(when (> frame-counter (gethash "standing-left" (duration sprite-sheets)))
	  (incf current-cell)
	  (setf frame-counter 0)
	  (if (> current-cell (gethash "standing-left" (total-cells (cells sprite-sheets))))
	      (setf current-cell 0)))))))

(defmethod standing-right ((piyo-draw piyo-draw))
  (with-slots (sprite-sheets) piyo-draw
    (let ((current-cell 0) (frame-counter 0))
      (lambda (x y)
	(sdl:draw-surface-at-* (gethash "standing-right" (sprite-sheet sprite-sheets)) x y :cell current-cell)
	(incf frame-counter)
	(when (> frame-counter (gethash "standing-right" (duration sprite-sheets)))
	  (incf current-cell)
	  (setf frame-counter 0)
	  (if (> current-cell (gethash "standing-right" (total-cells (cells sprite-sheets))))
	      (setf current-cell 0)))))))

(defmethod walking-left ((piyo-draw piyo-draw))
  (with-slots (sprite-sheets) piyo-draw
    (let ((current-cell 0) (frame-counter 0))
      (lambda (x y)
	(sdl:draw-surface-at-* (gethash "walking-left" (sprite-sheet sprite-sheets)) x y :cell current-cell)
	(print current-cell)
	(incf frame-counter)
	(when (> frame-counter (gethash "walking-left" (duration sprite-sheets)))
	  (incf current-cell)
	  (setf frame-counter 0)
	  (if (> current-cell (gethash "walking-left" (total-cells (cells sprite-sheets))))
	      (setf current-cell 0)))))))

(defmethod walking-right ((piyo-draw piyo-draw))
  (with-slots (sprite-sheets) piyo-draw
    (let ((current-cell 0) (frame-counter 0))
      (lambda (x y)
	(sdl:draw-surface-at-* (gethash "walking-right" (sprite-sheet sprite-sheets)) x y :cell current-cell)
	(incf frame-counter)
	(when (> frame-counter (gethash "walking-right" (duration sprite-sheets)))
	  (incf current-cell)
	  (setf frame-counter 0)
	  (if (> current-cell (gethash "walking-right" (total-cells (cells sprite-sheets))))
	      (setf current-cell 0)))))))

(defmethod generate-draw-closure ((piyo-draw piyo-draw))
  (with-slots (draw-closure) piyo-draw
    (setf (gethash "standing-left" draw-closure) (standing-left piyo-draw))
    (setf (gethash "standing-right" draw-closure) (standing-right piyo-draw))
    (setf (gethash "walking-left" draw-closure) (walking-left piyo-draw))
    (setf (gethash "walking-right" draw-closure) (walking-right piyo-draw))))
    
(defmethod draw-sprite ((piyo-draw piyo-draw) x y)
  (with-slots (action-name draw-closure) piyo-draw
      (cond ((string= (action-flag *piyo-flag*) "standing-left") (funcall (gethash "standing-left" draw-closure) x y))
	    ((string= (action-flag *piyo-flag*) "standing-right") (funcall (gethash "standing-right" draw-closure) x y))
	    ((string= (action-flag *piyo-flag*) "walking-left") (funcall (gethash "walking-left" draw-closure) x y))
	    ((string= (action-flag *piyo-flag*) "walking-right") (funcall (gethash "walking-right" draw-closure) x y)))))

(defmethod initialize-instance :after ((piyo-draw piyo-draw) &rest initargs)
  (generate-draw-closure piyo-draw))
