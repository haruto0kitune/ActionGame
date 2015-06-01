(in-package :game)

(defclass blocks-cells ()
  ((x-cells
    :documentation "take 1 from actual number"
    :accessor x-cells
    :initform (make-hash-table :test #'equal))
   (y-cells
    :documentation "take 1 from actual number"
    :accessor y-cells
    :initform 0)
   (total-cells
    :documentation "take 1 from actual number"
    :accessor total-cells
    :initform (make-hash-table :test #'equal))))

(defmethod set-x-cells ((blocks-cells blocks-cells))
  (with-slots (x-cells) blocks-cells
    (setf (gethash "blocks1" x-cells) 1)))

(defmethod set-total-cells ((blocks-cells blocks-cells))
  (with-slots (total-cells) blocks-cells
    (setf (gethash "blocks1" total-cells) 1)))

(defmethod initialize-instance :after ((blocks-cells blocks-cells) &rest initargs)
  (set-x-cells blocks-cells)
  (set-total-cells blocks-cells))
