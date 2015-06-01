;;;; uses instance of player-flag class
;;;; player-flag is global

(in-package :game)    

(defclass player ()
  ((hp
    :initform 1)
   (image
    :accessor image
    :initform (make-instance 'image :x 0 :y 0 :w 128 :h 128))
   (velocity
    :accessor velocity
    :initform (make-instance 'velocity :vx 10 :vy 10))
   (collision
    :accessor collision
    :initform (make-instance 'rect :x 43 :y 15 :w 39 :h 113))
   (damage-collision
    :accessor damage-collision
    :initform (make-instance 'rect :x 43 :y 15 :w 39 :h 113))
   (cx-minus-px
    :documentation "position-x minus collision-x"
    :accessor cx-minus-px
    :initform 0)
   (cy-minus-py
    :documentation "position-y minus collision-y"
    :accessor cy-minus-py
    :initform 0)
   (jump-power
    :initform 20)
   (jump
    :reader jump)
   (draw
    :reader draw
    :initform (make-instance 'player-draw))
   (free-fall
    :initform (generate-free-fall))))

(defmethod set-x ((player player) value)
  (with-slots (image collision damage-collision) player
    (setf (x image) value)
    (setf (x collision) (+ (x image) (x collision)))
    (setf (x damage-collision) (+ (x image) (x damage-collision)))))

(defmethod add-value-to-x ((player player) value)
  (with-slots (image collision damage-collision) player
    (+= (x image) value)
    (+= (x collision) value)
    (+= (x damage-collision) value)))

(defmethod sub-value-to-x ((player player) value)
  (with-slots (image collision damage-collision) player
    (-= (x image) value)
    (-= (x collision) value)
    (-= (x damage-collision) value)))

(defmethod update ((player player))
  (with-slots (collision damage-collision) player
    (setf (x damage-collision) (x collision))
    (setf (y damage-collision) (y collision))))

(defmethod hp ((player player) &optional (value nil))
  (with-slots (hp) player
    (if (eq value nil)
	(return-from hp hp)
	(return-from hp (+= hp value)))))

(defmethod move ((player player) direction-string)
  (cond ((string= direction-string "left") (move-left player))
	((string= direction-string "right") (move-right player))))

(defmethod move-left ((player player))
  (with-slots (image collision velocity) player
    (setf (direction *player-flag*) "left")
    (-= (x image) (vx velocity))
    (-= (x collision) (vx velocity))
    (if (eq (air-flag *player-flag*) nil)
	(setf (action-flag *player-flag*) "running-left")
	(setf (action-flag *player-flag*) "jumping-left"))))

(defmethod move-right ((player player))
  (with-slots (image collision velocity) player
    (setf (direction *player-flag*) "right")
    (+= (x image) (vx velocity))
    (+= (x collision) (vx velocity))
    (if (eq (air-flag *player-flag*) nil)
	(setf (action-flag *player-flag*) "running-right")
	(setf (action-flag *player-flag*) "jumping-right"))))

(defmethod generate-jump ((player player))
  (with-slots (jump-power collision) player
    (let* ((start-jump-power jump-power) (force jump-power) (prev-y 0) (temp-y 0)) 
      (lambda (&optional reset)
	(progn
	  (if (eq reset t) (setf force start-jump-power))
	  (if (eq (jump-flag *player-flag*) t)
	      (progn		
		(setf prev-y temp-y)
		(-= temp-y (floor force))
		(-= (y image) (floor force))
		(-= (y collision) (floor force))		
		(if (not (<= (floor force) 0))
		    (-= force 1.5)
		    (progn
		      (setf (jump-flag *player-flag*) nil)
		      (setf force start-jump-power))))))))))

(defmethod jump ((player player))
  (with-slots (jump) player
    (when (eq (ground-flag *player-flag*) t)
      (setf (jump-flag *player-flag*) t)
      (cond ((string= (direction *player-flag*) "left") (setf (action-flag *player-flag*) "jumping-left"))
	    ((string= (direction *player-flag*) "right") (setf (action-flag *player-flag*) "jumping-right")))
    (funcall jump))))

(defmethod reinitialize-instance :after ((player player) &rest initargs)
  (with-slots (hp x y collision damage-collision) player
    (setf hp 1)
    (setf (x collision) (+ (x image) 43))
    (setf (y collision) (+ (y image) 15))
    (setf (x damage-collision) (+ (x image) 43))
    (setf (y damage-collision) (+ (y image) 15))))

(defmethod initialize-instance :after ((player player) &rest initargs)
  (with-slots (image collision damage-collision cx-minus-px cy-minus-py jump) player
    (cond ((string= (direction *player-flag*) "left") (setf (action-flag *player-flag*) "standing-left"))
	  ((string= (direction *player-flag*) "right") (setf (action-flag *player-flag*) "standing-right")))
    (setf (x collision) (+ (x image) (x collision)))
    (setf (y collision) (+ (y image) (y collision)))
    (setf (x damage-collision) (x collision))
    (setf (y damage-collision) (y collision))
    (setf (w damage-collision) (w collision))
    (setf (h damage-collision) (h collision))
    (setf cx-minus-px (- (x collision) (x image)))
    (setf cy-minus-py (- (y collision) (y image)))
    (setf jump (generate-jump player))))
