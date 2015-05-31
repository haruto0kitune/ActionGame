(in-package :game)

(defclass piyo-cells ()
  ((x-cells
    :documentation "take 1 from actual number"
    :reader x-cells
    :initform (make-hash-table :test #'equal))
   (y-cells
    :documentation "take 1 from actual number"
    :reader y-cells
    :initform 0)
   (total-cells
    :documentation "take 1 from actual number"
    :reader total-cells
    :initform (make-hash-table :test #'equal))))

(defmethod set-x-cells ((piyo-cells piyo-cells))
  (with-slots (x-cells) piyo-cells
    (setf (gethash "standing-left" x-cells) 0)
    (setf (gethash "standing-right" x-cells) 0)
    (setf (gethash "walking-left" x-cells) 1)
    (setf (gethash "walking-right" x-cells) 1)))

(defmethod set-total-cells ((piyo-cells piyo-cells))
  (with-slots (total-cells) piyo-cells
    (setf (gethash "standing-left" total-cells) 0)
    (setf (gethash "standing-right" total-cells) 0)
    (setf (gethash "walking-left" total-cells) 1)
    (setf (gethash "walking-right" total-cells) 1)))
