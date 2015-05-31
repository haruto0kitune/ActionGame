(in-package :game)

(defclass blocks-cells ()
  ((x-cells
    :documentation "take 1 from actual number"
    :accessor x-cells
    :initform 2)
   (y-cells
    :documentation "take 1 from actual number"
    :accessor y-cells
    :initform 0)
   (total-cells
    :documentation "take 1 from actual number"
    :accessor total-cells
    :initform 2)))
