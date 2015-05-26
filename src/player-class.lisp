(in-package :game)    

(defclass player ()
  ((hp
    :initform 1)
   (x
    :accessor x
    :initarg :x)
   (y
    :accessor y
    :initarg :y)
   (w
    :accessor w
    :initform 128)
   (h
    :accessor h
    :initform 128)
   (vx
    :initform 10)
   (vy
    :initform 10)
   (collision
    :accessor collision
    :initform (make-instance 'rect :x 43 :y 15 :w 39 :h 113))
   (damage-collision
    :accessor damage-collision
    :initform (make-instance 'rect :x 43 :y 15 :w 39 :h 113))
   (current-cell
    :initform 0)
   (standing-left-current-cell
    :initform 0)
   (standing-right-current-cell
    :initform 0)
   (running-left-current-cell
    :initform 0)
   (running-right-current-cell
    :initform 0)
   (jumping-left-current-cell
    :initform 0)
   (jumping-right-current-cell
    :initform 0)
   (damage-motion-left-current-cell
    :initform 0)
   (damage-motion1-right-current-cell
    :initform 0)
   (down-motion-left-current-cell
    :initform 0)
   (down-motion-right-current-cell
    :initform 0)
   (frame-counter
    :initform 0)
   (cx-minus-px
    :documentation "position-x minus collision-x"
    :accessor cx-minus-px
    :initform 0)
   (cy-minus-py
    :documentation "position-y minus collision-y"
    :accessor cy-minus-py
    :initform 0)
   (direction
    :documentation "right or left"
    :accessor direction
    :initform nil
    :initarg :direction)
   (jump-power
    :initform 20)
   (action-name
    :documentation "action flag"
    :initform nil)
   (var-jump    
    :initform nil)
   (draw-flag
    :accessor draw-flag
    :initform t)
   (jump-flag
    :accessor jump-flag
    :initform nil)
   (ground-flag
    :accessor ground-flag
    :initform nil)
   (air-flag
    :accessor air-flag
    :initform nil)
   (top-collision-flag
    :accessor top-collision-flag
    :initform nil)
   (bottom-collision-flag
    :accessor bottom-collision-flag
    :initform nil)
   (left-collision-flag
    :accessor left-collision-flag
    :initform nil)
   (right-collision-flag
    :accessor right-collision-flag
    :initform nil)))

(defmethod reinitialize-instance :after ((player player) &rest initargs)
  (with-slots (hp
	       x
	       y
	       collision
	       damage-collision
	       direction
	       down-motion-left-current-cell
	       down-motion-right-current-cell)
      player
    (setf hp 1)
    (setf (x (collision player)) (+ (x (x player)) 43))
    (setf (y (collision player)) (+ (y (y player)) 15))
    (setf (x (damage-collision player)) (+ (x (x player)) 43))
    (setf (y (damage-collision player)) (+ (y (y player)) 15))
    (setf direction "left")
    (setf down-motion-left-current-cell 0)
    (setf down-motion-right-current-cell 0)))

(defmethod update ((player player))
  (with-slots (collision
	       damage-collision)
      player
    (setf (x (damage-collision player)) (x (collision player)))
    (setf (y (damage-collision player)) (y (collision player)))))

(defmethod initialize-instance :after ((player player) &rest initargs)
  (with-slots (x
	       y	    
	       collision
	       damage-collision
	       direction
	       action-name)
      player
    (cond ((string= direction "left")
	   (setf action-name "standing-left"))
	  ((string= direction "right")
	   (setf action-name "standing-right")))
    (setf (x (collision player)) (+ (x (x player)) (x (collision player))))
    (setf (y (collision player)) (+ (y (y player)) (y (collision player))))
    (setf (x (damage-collision player)) (x (collision player)))
    (setf (y (damage-collision player)) (y (collision player)))
    (setf (w (damage-collision player)) (w (collision player)))
    (setf (h (damage-collision player)) (h (collision player)))
    (initialize-player player)))

(defmethod initialize-player ((player player))  
  (with-slots (x
	       y
	       collision
	       cx-minus-px
	       cy-minus-py
	       var-jump)
      player
    (set-duration player)
    (generate-sprite-sheet player)
    (setf var-jump (generate-jump player))
    (setf cx-minus-px (- (x (collision player)) (x (x player))))
    (setf cy-minus-py (- (y (collision player)) (y (y player))))))

(defmethod hp ((player player) &optional (value nil))
  (with-slots (hp) player
    (if (eq value nil)
	(return-from hp hp)
	(return-from hp (+= hp value)))))

(defmethod move ((player player) direction-string)
  (cond ((string= direction-string "left")
	 (move-left player))
	((string= direction-string "right")
	 (move-right player))))

(defmethod move-left ((player player))
  (with-slots (x
	       y
	       collision
	       velocity-x
	       direction
	       air-flag
	       action-name)
      player
    (setf direction "left")
    (-= (x (x player)) velocity-x)
    (-= (x (collision player)) velocity-x)
    (if (eq air-flag nil)
	(setf action-name "running-left")
	(setf action-name "jumping-left"))))

(defmethod move-right ((player player))
  (with-slots (x
	       collision
	       velocity-x
	       direction
	       air-flag
	       action-name)
      player
    (setf direction "right")
    (+= (x (x player)) velocity-x)
    (+= (x (collision player)) velocity-x)
    (if (eq air-flag nil)
	(setf action-name "running-right")
	(setf action-name "jumping-right"))))
