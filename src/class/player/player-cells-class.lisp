(in-package :game)

(defclass player-cells ()
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

(defmethod set-x-cells ((player-cells player-cells))
  (with-slots (x-cells) player-cells
    (setf (gethash "standing-left" x-cells) 11)
    (setf (gethash "standing-right" x-cells) 11)
    (setf (gethash "running-left" x-cells) 7)
    (setf (gethash "running-right" x-cells) 7)
    (setf (gethash "jumping-left" x-cells) 3)
    (setf (gethash "jumping-right" x-cells) 3)
    (setf (gethash "damage-motion-left" x-cells) 2)
    (setf (gethash "damage-motion-right" x-cells) 2)
    (setf (gethash "down-motion-left" x-cells) 8)
    (setf (gethash "down-motion-right" x-cells) 8)))

(defmethod set-total-cells ((player-cells player-cells))
  (with-slots (total-cells) player-cells
    (setf (gethash "standing-left" total-cells) 11)
    (setf (gethash "standing-right" total-cells) 11)
    (setf (gethash "running-left" total-cells) 7)
    (setf (gethash "running-right" total-cells) 7)
    (setf (gethash "jumping-left" total-cells) 3)
    (setf (gethash "jumping-right" total-cells) 3)
    (setf (gethash "damage-motion-left" total-cells) 2)
    (setf (gethash "damage-motion-right" total-cells) 2)
    (setf (gethash "down-motion-left" total-cells) 8)
    (setf (gethash "down-motion-right" total-cells) 8)))

(defmethod initialize-instance :after ((player-cells player-cells) &rest initargs)
  (set-x-cells player-cells)
  (set-total-cells player-cells))
