(in-package :game)

(defclass blocks-draw ()
  ((sprite-sheets
    :reader sprite-sheets
    :initform (make-instance 'blocks-sprite-sheet))
   (draw-closure
    :initform (make-hash-table :test #'equal))))

(defmethod blocks1 ((blocks-draw blocks-draw))
  (with-slots (sprite-sheets) blocks-draw
    (let ((current-cell 0) (frame-counter 0))
      (lambda (x y)
	(cond ((= (id sprite-sheets) 0) (sdl:draw-surface-at-* (gethash "blocks1" (sprite-sheet sprite-sheets)) x y :cell (id sprite-sheets)))
	      ((= (id sprite-sheets) 1) (sdl:draw-surface-at-* (gethash "blocks1" (sprite-sheet sprite-sheets)) x y :cell (id sprite-sheets))))
	(incf frame-counter)
	(when (> frame-counter (duration sprite-sheets))
	  (incf current-cell)
	  (setf frame-counter 0)
	  (if (> current-cell (gethash "blocks1" (total-cells (cells sprite-sheets))))
	      (setf current-cell 0)))))))

(defmethod generate-draw-closure ((blocks-draw blocks-draw))
  (with-slots (draw-closure) blocks-draw
    (setf (gethash "blocks1" draw-closure) (blocks1 blocks-draw))))

(defmethod draw-sprite ((blocks-draw blocks-draw) x y)
  (with-slots (draw-closure) blocks-draw
    (funcall (gethash "blocks1" draw-closure) x y)))

(defmethod initialize-instance :after ((blocks-draw blocks-draw) &rest initargs)
  (generate-draw-closure blocks-draw))
    
  
