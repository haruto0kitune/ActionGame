(in-package :game)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; collision-x = position-x + 9  ;;
;; collision-y = position-y + 13 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass piyo ()
  ((hp
    :initform 1
    :initarg :hp)
   (filename
    :documentation "hash table"
    :initform (make-hash-table :test #'equal))
   (x
    :accessor x
    :initarg :x)
   (y
    :accessor y
    :initarg :y)
   (w
    :accessor w
    :initform 64)
   (h
    :accessor h
    :initform 64)
   (collision
    :accessor collision
    :initform (make-instance 'rect :x 9 :y 13 :w 40 :h 40))
   (attack-collision
    :accessor attack-collision
    :initform (make-instance 'rect :x 9 :y 13 :w 40 :h 40))
   (damage-collision
    :accessor damage-collision
    :initform (make-instance 'rect :x 9 :y 13 :w 40 :h 40))
   (vx
    :initform 5)
   (vy
    :initform 5)
   (x-cell-count
    :documentation "take 1 from actual number"
    :initform (make-hash-table :test #'equal))
   (y-cell-count
    :documentation "take 1 from actual number"
    :initform 0)
   (total-cell-count
    :documentation "take 1 from actual number"
    :initform (make-hash-table :test #'equal))
   (sprite-sheet
    :initform nil)
   (current-cell
    :initform 0)
   (standing-left-current-cell
    :initform 0)
   (standing-right-current-cell
    :initform 0)
   (walking-left-current-cell
    :initform 0)
   (walking-right-current-cell
    :initform 0)
   (duration
    :initform (make-hash-table :test #'equal))
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
    :accessor jump-power
    :initform 20
    :initarg :jump-power)
   (action-name
    :documentation "action flag"
    :accessor action-name
    :initform nil)
   (var-jump
    :accessor var-jump
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
    :initform nil)
   (standing-left
    :documentation "sprite-sheet"
    :accessor standing-left
    :initform nil
    :initarg :standing-left)
   (standing-right
    :documentation "sprite-sheet"
    :accessor standing-right
    :initform nil
    :initarg :standing-right)
   (walking-left
    :documentation "sprite-sheet"
    :accessor walking-left
    :initform nil
    :initarg :walking-left)
   (walking-right
    :documentation "sprite-sheet"
    :accessor walking-right
    :initform nil
    :initarg :walking-right)
   (jumping-left
    :documentation "sprite-sheet"
    :accessor jumping-left
    :initform nil
    :initarg :jumping-left)
   (jumping-right
    :documentation "sprite-sheet"
    :accessor jumping-right
    :initform nil
    :initarg :jumping-right)
   (attack1-left
    :documentation "sprite-sheet"
    :accessor attack1-left
    :initform nil
    :initarg :attack1-left)
   (attack1-right
    :documentation "sprite-sheet"
    :accessor attack1-right
    :initform nil
    :initarg :attack1-right)))

(defmethod set-filename ((piyo piyo))
  (with-slots (filename) piyo
    (setf (gethash "piyo-standing-left" filename)
	  "../pixel_animation/enemy/enemy1_standing1_left.png")
    (setf (gethash "piyo-standing-right" filename)
	  "../pixel_animation/enemy/enemy1_standing1_right.png")
    (setf (gethash "piyo-walking-left" filename)
	  "../pixel_animation/enemy/enemy1_walk_left.png")
    (setf (gethash "piyo-walking-right" filename)
	  "../pixel_animation/enemy/enemy1_walk_right.png")))

(defmethod set-duration ((piyo piyo))
  (with-slots (duration) piyo
    (setf (gethash "piyo-standing-left" duration) 1)
    (setf (gethash "piyo-standing-right" duration) 1)
    (setf (gethash "piyo-walking-left" duration) 3)
    (setf (gethash "piyo-walking-right" duration) 3)))

(defmethod set-x-cell-count ((piyo piyo))
  (with-slots (x-cell-count) piyo
    (setf (gethash "piyo-standing-left" x-cell-count) 0)
    (setf (gethash "piyo-standing-right" x-cell-count) 0)
    (setf (gethash "piyo-walking-left" x-cell-count) 1)
    (setf (gethash "piyo-walking-right" x-cell-count) 1)))

(defmethod set-total-cell-count ((piyo piyo))
  (with-slots (total-cell-count) piyo
    (setf (gethash "piyo-standing-left" total-cell-count) 0)
    (setf (gethash "piyo-standing-right" total-cell-count) 0)
    (setf (gethash "piyo-walking-left" total-cell-count) 1)
    (setf (gethash "piyo-walking-right" total-cell-count) 1)))

(defmethod initialize-instance :after ((piyo piyo) &rest initargs)
  (with-slots (x y collision attack-collision direction action-name) piyo
    (cond ((string= direction "left") (setf action-name "piyo-standing-left"))
	  ((string= direction "right") (setf action-name "piyo-standing-right")))
    (set-filename piyo)
    (set-duration piyo)
    (setf (x (collision piyo)) (+ x (x (collision piyo))))
    (setf (y (collision piyo)) (+ y (y (collision piyo))))
    (set-x-cell-count piyo)
    (set-total-cell-count piyo)
    (setf (x (attack-collision piyo)) (x (collision piyo)))
    (setf (y (attack-collision piyo)) (y (collision piyo)))
    (setf (w (attack-collision piyo)) (w (collision piyo)))
    (setf (h (attack-collision piyo)) (h (collision piyo)))
    (initialize-piyo piyo)))

(defmethod initialize-piyo ((piyo piyo))  
  (with-slots (x y collision cx-minus-px cy-minus-py var-jump) piyo
    (generate-sprite-sheet piyo)
    (setf var-jump (generate-jump piyo))
    (setf cx-minus-px (- (x (collision piyo)) x))
    (setf cy-minus-py (- (y (collision piyo)) y))))

(defmethod update ((piyo piyo))
  (with-slots (collision attack-collision damage-collision) piyo
    (setf (x (attack-collision piyo)) (x (collision piyo)))
    (setf (y (attack-collision piyo)) (y (collision piyo)))
    (setf (x (damage-collision piyo)) (x (collision piyo)))
    (setf (y (damage-collision piyo)) (y (collision piyo)))))

(defmethod move ((piyo piyo) direction-string)
  (cond ((string= direction-string "left") (move-left piyo))
	((string= direction-string "right") (move-right piyo))))

(defmethod move-left ((piyo piyo))
  (with-slots (x vx collision damage-collision direction) piyo
    (setf direction "left")
    (-= x vx)
    (-= (x (collision piyo)) vx)
    (-= (x (damage-collision piyo)) vx)))

(defmethod move-right ((piyo piyo))
  (with-slots (x vx collision damage-collision direction) piyo
    (setf direction "right")
    (+= x vx)
    (+= (x (collision piyo)) vx)
    (+= (x (damage-collision piyo)) vx)))
	   
(defmethod generate-jump ((piyo piyo))
  (with-slots (jump-power jump-flag collision y) piyo
    (let* ((start-jump-power jump-power)
	   (force jump-power)
	   (prev-y 0)
	   (temp-y 0)) 
      (lambda (&optional reset)
	(progn
	  (if (eq reset t)
	      (setf force start-jump-power))
	  (if (eq jump-flag t)
	      (progn		
		(setf prev-y temp-y)
		(-= temp-y (floor force))
		(-= y (floor force))
		(-= (y (collision piyo)) (floor force))
		(if (not (<= (floor force) 0))
		    (-= force 1.5)
		    (progn
		      (setf jump-flag nil)
		      (setf force start-jump-power))))))))))

(defmethod jump ((piyo piyo))
  (with-slots (var-jump) piyo
      (funcall var-jump)))

(defmethod set-standing-left ((piyo piyo))
  (with-slots (filename w h x-cell-count y-cell-count standing-left) piyo
    (let ((sprite-cells nil))
      (setf standing-left (sdl:load-image (gethash "standing-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* h y-cell-count) by h
	       append (loop for x from 0 to (* w
					       (gethash "standing-left"
							x-cell-count)) by w
			 collect (list x y w h))))
      (setf (sdl:cells standing-left) sprite-cells))))

(defmethod set-standing-right ((piyo piyo))
  (with-slots (filename w h x-cell-count y-cell-count standing-right) piyo
    (let ((sprite-cells nil))
      (setf standing-right (sdl:load-image (gethash "standing-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* h y-cell-count) by h
	       append (loop for x from 0 to (* w
					       (gethash "standing-right"
							x-cell-count)) by w
			 collect (list x y w h))))
      (setf (sdl:cells standing-right) sprite-cells))))

(defmethod set-walking-left ((piyo piyo))
  (with-slots (filename w h x-cell-count y-cell-count walking-left) piyo
    (let ((sprite-cells nil))
      (setf walking-left (sdl:load-image (gethash "walking-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* h y-cell-count) by h
	       append (loop for x from 0 to (* w
					       (gethash "walking-left"
							x-cell-count)) by w
			 collect (list x y w h))))
      (setf (sdl:cells walking-left) sprite-cells))))

(defmethod set-walking-right ((piyo piyo))
  (with-slots (filename w h x-cell-count y-cell-count walking-right) piyo
    (let ((sprite-cells nil))
      (setf walking-right (sdl:load-image (gethash "walking-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* h y-cell-count) by h
	       append (loop for x from 0 to (* w
					       (gethash "walking-right"
							x-cell-count)) by w
			 collect (list x y w h))))
      (setf (sdl:cells walking-right) sprite-cells))))

(defmethod generate-sprite-sheet ((piyo piyo))
  (set-standing-left piyo)
  (set-standing-right piyo)
  (set-walking-left piyo)
  (set-walking-right piyo))

(defmethod standing-left ((piyo piyo))
  (with-slots
	(x
	 y
	 standing-left
	 standing-left-current-cell
	 total-cell-count
	 duration
	 frame-counter)
      piyo
    (sdl:draw-surface-at-* standing-left x y :cell standing-left-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "standing-left" duration))
      (incf standing-left-current-cell)
      (setf frame-counter 0)
      (if (> standing-left-current-cell (gethash "standing-left"
						 total-cell-count))
	  (setf standing-left-current-cell 0)))))

(defmethod standing-right ((piyo piyo))
  (with-slots
	(x
	 y
	 standing-right
	 standing-right-current-cell
	 total-cell-count
	 duration
	 frame-counter)
      piyo
    (sdl:draw-surface-at-* standing-right x y :cell standing-right-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "standing-right" duration))
      (incf standing-right-current-cell)
      (setf frame-counter 0)
      (if (> standing-right-current-cell (gethash "standing-right"
						  total-cell-count))
	  (setf standing-right-current-cell 0)))))

(defmethod walking-left ((piyo piyo))
  (with-slots
	(x
	 y
	 walking-left
	 walking-left-current-cell
	 total-cell-count
	 duration
	 frame-counter)
      piyo
    (sdl:draw-surface-at-* walking-left x y :cell walking-left-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "walking-left" duration))
      (incf walking-left-current-cell)
      (setf frame-counter 0)
      (if (> walking-left-current-cell (gethash "walking-left"
						total-cell-count))
	  (setf walking-left-current-cell 0)))))

(defmethod walking-right ((piyo piyo))
  (with-slots
	(x
	 y
	 walking-right
	 walking-right-current-cell
	 total-cell-count
	 duration
	 frame-counter)
      piyo
    (sdl:draw-surface-at-* walking-right x y :cell walking-right-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "walking-right" duration))
      (incf walking-right-current-cell)
      (setf frame-counter 0)
      (if (> walking-right-current-cell (gethash "walking-right"
						total-cell-count))
	  (setf walking-right-current-cell 0)))))

(defmethod draw-sprite ((piyo piyo))
  (with-slots (action-name) piyo
    (cond ((string= action-name "standing-left") (standing-left piyo))
	  ((string= action-name "standing-right") (standing-right piyo))
	  ((string= action-name "walking-left") (walking-left piyo))
	  ((string= action-name "walking-right") (walking-right piyo)))))
	  
