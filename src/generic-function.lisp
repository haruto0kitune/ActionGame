(in-package :cl-user)
(defpackage generic-function
  (:use :cl)
  (:import-from :sprite-sheet-class
		:image-object)
  (:import-from :player-class
		:player
		:hp
		:filename
		:collision-x
		:collision-y
		:collision-width
		:collision-height
		:damage-collision-x
		:damage-collision-y
		:damage-collision-width
		:damage-collision-height
		:position-x
		:position-y
		:velocity-x
		:velocity-y
		:width
		:height
		:x-cell-count
		:y-cell-count
		:total-cell-count
		:current-cell
		:standing-left-current-cell
		:standing-right-current-cell
		:running-left-current-cell
		:running-right-current-cell
		:jumping-left-current-cell
		:jumping-right-current-cell
		:fox-girl-damage-motion1-left-current-cell
		:fox-girl-damage-motion1-right-current-cell
		:fox-girl-down-motion-left-current-cell
		:fox-girl-down-motion-right-current-cell
		:duration
		:frame-counter
		:cx-minus-px
		:cy-minux-py
		:direction
		:jump-power
		:action-name
		:var-jump
		:draw-flag
		:ground-flag
		:air-flag
		:top-collision-flag
		:bottom-collision-flag
		:left-collision-flag
		:right-collision-flag
		:standing-left
		:standing-right
		:walking-left
		:walking-right
		:running-left
		:running-right
		:jumping-left
		:jumping-right
		:crouching-left
		:crouching-right
		:atemi1-left
		:atemi1-right
		:fox-girl-damage-motion1-left
		:fox-girl-damage-motion1-right
		:fox-girl-down-motion-left
		:fox-girl-down-motion-right)
  (:import-from :piyo-class
		:piyo)
  (:import-from :key-state
		:key-state
		:defkeystate)
  (:import-from :block-class
		:blocks))
(in-package :generic-function)

;;;; initialize-instance

(defmethod initialize-instance :after ((image-object image-object) &rest initargs)
  (generate-sprite-sheet image-object))

(defmethod initialize-instance :after ((player player) &rest initargs)
  (with-slots (position-x
	       position-y
	       cx-minus-px
	       cy-minus-py
	       var-jump
	       collision-x
	       collision-y
	       collision-width
	       collision-height
;	       attack-collision-x
;	       attack-collision-y
;	       attack-collision-width
					;	       attack-collision-height)
	       damage-collision-x
	       damage-collision-y
	       damage-collision-width
	       damage-collision-height)
      player
    (setf collision-x (+ position-x 43))
    (setf collision-y (+ collision-y 15))
    (setf damage-collision-x collision-x)
    (setf damage-collision-y collision-y)
    (setf damage-collision-width collision-width)
    (setf damage-collision-height collision-height)
    (generate-sprite-sheet player)
    (setf var-jump (generate-jump player))
    (setf cx-minus-px (- collision-x position-x))
    (setf cy-minus-py (- collision-y position-y))))

(defmethod initialize-instance :after ((piyo piyo) &rest initargs)
  (with-slots (position-x
	       position-y
	       cx-minus-px
	       cy-minus-py
	       var-jump
	       collision-x
	       collision-y
	       collision-width
	       collision-height
	       attack-collision-x
	       attack-collision-y
	       attack-collision-width
	       attack-collision-height)
      piyo
    (setf attack-collision-x collision-x)
    (setf attack-collision-y collision-y)
    (setf attack-collision-width collision-width)
    (setf attack-collision-height collision-height)
    (generate-sprite-sheet piyo)
    (setf var-jump (generate-jump piyo))
    (setf cx-minus-px (- collision-x position-x))
    (setf cy-minus-py (- collision-y position-y))))

(defmethod initialize-instance :after ((blocks blocks) &rest initargs)
  (generate-sprite-sheet blocks))

;;;; generate-sprite-sheet

(defmethod generate-sprite-sheet ((image-object image-object))
  (with-slots (filename width height x-cell-count y-cell-count sprite-sheet)
      image-object
    (let ((sprite-cells nil))
      (setf sprite-sheet (sdl:load-image filename :color-key sdl:*black*))      
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
		 append (loop for x from 0 to (* width x-cell-count) by width
			   collect (list x y width height))))
      (setf (sdl:cells sprite-sheet) sprite-cells))))

(defmethod generate-sprite-sheet ((player player))
  (set-standing-left player)
  (set-standing-right player)
  (set-running-left player)
  (set-running-right player)
  (set-jumping-left player)
  (set-jumping-right player)
  (set-fox-girl-damage-motion1-left player)
  (set-fox-girl-damage-motion1-right player)
  (set-fox-girl-down-motion-left player)
  (set-fox-girl-down-motion-right player))

(defmethod generate-sprite-sheet ((piyo piyo))
  (set-standing-left piyo)
  (set-standing-right piyo)
  (set-walking-left piyo)
  (set-walking-right piyo))

(defmethod generate-sprite-sheet ((blocks blocks))
  (with-slots (filename width height x-cell-count y-cell-count sprite-sheet)
      blocks
    (let ((sprite-cells nil))
      (setf sprite-sheet (sdl:load-image filename :color-key sdl:*black*))      
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
		 append (loop for x from 0 to (* width x-cell-count) by width
			   collect (list x y width height))))
      (setf (sdl:cells sprite-sheet) sprite-cells))))

;;;; draw-sprite

(defmethod draw-sprite ((image-object image-object))
  (with-slots
	(position-x
	 position-y
	 total-cell-count
	 sprite-sheet
	 current-cell
	 duration
	 frame-counter)
      image-object
    (sdl:draw-surface-at-* sprite-sheet position-x position-y :cell current-cell)
    (incf frame-counter)
    (when (> frame-counter duration)
      (incf current-cell)
      (setf frame-counter 0)
      (if (> current-cell total-cell-count)
	  (setf current-cell 0)))))

(defmethod draw-sprite ((player player))
  (with-slots (action-name) player
    (cond ((string= action-name "standing-left") (standing-left player))
	  ((string= action-name "standing-right") (standing-right player))
	  ((string= action-name "running-left") (running-left player))
	  ((string= action-name "running-right") (running-right player))
	  ((string= action-name "jumping-left") (jumping-left player))
	  ((string= action-name "jumping-right") (jumping-right player))
	  ((string= action-name "fox-girl-damage-motion1-left") (fox-girl-damage-motion1-left player))
	  ((string= action-name "fox-girl-damage-motion1-right") (fox-girl-damage-motion1-right player))
	  ((string= action-name "fox-girl-down-motion-left") (fox-girl-down-motion-left player))
	  ((string= action-name "fox-girl-down-motion-right") (fox-girl-down-motion-right player)))))
  
(defmethod draw-sprite ((piyo piyo))
  (with-slots (action-name) piyo
    (cond ((string= action-name "piyo-standing-left") (piyo-standing-left piyo))
	  ((string= action-name "piyo-standing-right") (piyo-standing-right piyo))
	  ((string= action-name "piyo-walking-left") (piyo-walking-left piyo))
	  ((string= action-name "piyo-walking-right") (piyo-walking-right piyo)))))

(defmethod draw-sprite ((blocks blocks))
  (with-slots
	(position-x
	 position-y
	 total-cell-count
	 sprite-sheet
	 current-cell
	 duration
	 frame-counter
	 draw-flag
	 id)
      blocks
    (cond ((= id 0)
	   (sdl:draw-surface-at-* sprite-sheet
				  position-x
				  position-y
				  :cell id))
	  ((= id 1)
	   (sdl:draw-surface-at-* sprite-sheet
				  position-x
				  position-y
				  :cell id)))
    (incf frame-counter)
    (when (> frame-counter duration)
      (incf current-cell)
      (setf frame-counter 0)
      (if (> current-cell total-cell-count)
	  (setf current-cell 0)))))

;;;; update

(defmethod update ((player player))
  (with-slots (collision-x
	       collision-y
;	       attack-collision-x
;	       attack-collision-y
	       damage-collision-x
      	       damage-collision-y)
      player
;   (setf attack-collision-x collision-x)
;   (setf attack-collision-y collision-y)
    (setf damage-collision-x collision-x)
    (setf damage-collision-y collision-y)))

(defmethod update ((piyo piyo))
  (with-slots (collision-x
	       collision-y
	       attack-collision-x
	       attack-collision-y
	       damage-collision-x
      	       damage-collision-y)
      piyo
    (setf attack-collision-x collision-x)
    (setf attack-collision-y collision-y)
    (setf damage-collision-x collision-x)
    (setf damage-collision-y collision-y)))

;;;; move

(defmethod move ((player player) direction-string)
  (cond ((string= direction-string "left") (move-left player))
	((string= direction-string "right") (move-right player))))

(defmethod move ((piyo piyo) direction-string)
  (cond ((string= direction-string "left") (move-left piyo))
	((string= direction-string "right") (move-right piyo))))

;;;; hp

(defmethod hp ((player player) &optional (value nil))
  (with-slots (hp) player
    (if (eq value nil)
	(return-from hp hp)
	(return-from hp (+= hp value)))))

(defmethod hp ((piyo piyo) &optional (value nil))
  (with-slots (hp) piyo
    (if (eq value nil)
	(return-from hp hp)
	(return-from hp (+= hp value)))))

;;;; move-left

(defmethod move-left ((player player))
  (with-slots (position-x
	       collision-x
	       velocity-x
	       direction
	       air-flag
	       action-name)
      player
    (setf direction "left")
    (-= position-x velocity-x)
    (-= collision-x velocity-x)
    (if (eq air-flag nil)
	(setf action-name "running-left")
	(setf action-name "jumping-left"))))

(defmethod move-left ((piyo piyo))
  (with-slots (position-x
	       collision-x
	       damage-collision-x
	       velocity-x
	       direction)
      piyo
    (setf direction "left")
    (-= position-x velocity-x)
    (-= collision-x velocity-x)
    (-= damage-collision-x velocity-x)))

;;;; move-right

(defmethod move-right ((player player))
  (with-slots (position-x
	       collision-x
	       velocity-x
	       direction
	       air-flag
	       action-name)
      player
    (setf direction "right")
    (+= position-x velocity-x)
    (+= collision-x velocity-x)
    (if (eq air-flag nil)
	(setf action-name "running-right")
	(setf action-name "jumping-right"))))

(defmethod move-right ((piyo piyo))
  (with-slots (position-x
	       collision-x
	       damage-collision-x
	       velocity-x
	       direction)
      piyo
    (setf direction "right")
    (+= position-x velocity-x)
    (+= collision-x velocity-x)
    (+= damage-collision-x velocity-x)))

;;;; generate-jump

(defmethod generate-jump ((player player))
  (with-slots (jump-power jump-flag position-y collision-y) player
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
		(-= position-y (floor force))
		(-= collision-y (floor force))		
		(if (not (<= (floor force) 0))
		    (-= force 1.5)
		    (progn
		      (setf jump-flag nil)
		      (setf force start-jump-power))))))))))

(defmethod generate-jump ((piyo piyo))
  (with-slots (jump-power jump-flag position-y collision-y) piyo
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
		(-= position-y (floor force))
		(-= collision-y (floor force))		
		(if (not (<= (floor force) 0))
		    (-= force 1.5)
		    (progn
		      (setf jump-flag nil)
		      (setf force start-jump-power))))))))))

;;;; jump

(defmethod jump ((player player))
  (with-slots (var-jump
	       ground-flag
	       jump-flag
	       direction
	       action-name)
      player
    (when (eq ground-flag t)
      (setf jump-flag t)
      (if (string= direction "left") (setf action-name "jumping-left"))
      (if (string= direction "right") (setf action-name "jumping-right")))
    (funcall var-jump)))

(defmethod jump ((piyo piyo))
  (with-slots (var-jump) piyo
    (funcall var-jump)))

;;;; set sprite sheet

(defmethod set-standing-left ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       standing-left)
      player
    (let ((sprite-cells nil))
      (setf standing-left (sdl:load-image (gethash "standing-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "standing-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells standing-left) sprite-cells))))

(defmethod set-standing-right ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       standing-right)
      player
    (let ((sprite-cells nil))
      (setf standing-right (sdl:load-image (gethash "standing-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "standing-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells standing-right) sprite-cells))))

(defmethod set-running-left ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       running-left)
      player
    (let ((sprite-cells nil))
      (setf running-left (sdl:load-image (gethash "running-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "running-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells running-left) sprite-cells))))

(defmethod set-running-right ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       running-right)
      player
    (let ((sprite-cells nil))
      (setf running-right (sdl:load-image (gethash "running-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "running-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells running-right) sprite-cells))))

(defmethod set-jumping-left ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       jumping-left)
      player
    (let ((sprite-cells nil))
      (setf jumping-left (sdl:load-image (gethash "jumping-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "jumping-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells jumping-left) sprite-cells))))

(defmethod set-jumping-right ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       jumping-right)
      player
    (let ((sprite-cells nil))
      (setf jumping-right (sdl:load-image (gethash "jumping-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "jumping-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells jumping-right) sprite-cells))))

(defmethod set-fox-girl-damage-motion1-left ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       fox-girl-damage-motion1-left)
      player
    (let ((sprite-cells nil))
      (setf fox-girl-damage-motion1-left (sdl:load-image (gethash "fox-girl-damage-motion1-left" filename)
							 :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "fox-girl-damage-motion1-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells fox-girl-damage-motion1-left) sprite-cells))))

(defmethod set-fox-girl-damage-motion1-right ((player player))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       fox-girl-damage-motion1-right)
      player
    (let ((sprite-cells nil))
      (setf fox-girl-damage-motion1-right (sdl:load-image (gethash "fox-girl-damage-motion1-right" filename)
							 :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "fox-girl-damage-motion1-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells fox-girl-damage-motion1-right) sprite-cells))))

(defmethod set-standing-left ((piyo piyo))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       standing-left)
      piyo
    (let ((sprite-cells nil))
      (setf standing-left (sdl:load-image (gethash "piyo-standing-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "piyo-standing-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells standing-left) sprite-cells))))

(defmethod set-standing-right ((piyo piyo))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       standing-right)
      piyo
    (let ((sprite-cells nil))
      (setf standing-right (sdl:load-image (gethash "piyo-standing-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "piyo-standing-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells standing-right) sprite-cells))))

(defmethod set-walking-left ((piyo piyo))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       walking-left)
      piyo
    (let ((sprite-cells nil))
      (setf walking-left (sdl:load-image (gethash "piyo-walking-left" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "piyo-walking-left"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells walking-left) sprite-cells))))

(defmethod set-walking-right ((piyo piyo))
  (with-slots (filename
	       width
	       height
	       x-cell-count
	       y-cell-count
	       walking-right)
      piyo
    (let ((sprite-cells nil))
      (setf walking-right (sdl:load-image (gethash "piyo-walking-right" filename)
					  :color-key sdl:*black*))
      (setf sprite-cells
	    (loop for y from 0 to (* height y-cell-count) by height
	       append (loop for x from 0 to (* width
					       (gethash "piyo-walking-right"
							x-cell-count)) by width
			 collect (list x y width height))))
      (setf (sdl:cells walking-right) sprite-cells))))

;;;; animation

(defmethod standing-left ((player player))
  (with-slots
	(position-x
	 position-y
	 standing-left
	 standing-left-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player
    (sdl:draw-surface-at-* standing-left
			   position-x
			   position-y
			   :cell standing-left-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "standing-left" duration))
      (incf standing-left-current-cell)
      (setf frame-counter 0)
      (if (> standing-left-current-cell (gethash "standing-left"
						 total-cell-count))
	  (setf standing-left-current-cell 0)))))

(defmethod standing-right ((player player))
  (with-slots
	(position-x
	 position-y
	 standing-right
	 standing-right-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player
    (sdl:draw-surface-at-* standing-right
			   position-x
			   position-y
			   :cell standing-right-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "standing-right" duration))
      (incf standing-right-current-cell)
      (setf frame-counter 0)
      (if (> standing-right-current-cell (gethash "standing-right"
						 total-cell-count))
	  (setf standing-right-current-cell 0)))))

(defmethod running-left ((player player))
  (with-slots
	(position-x
	 position-y
	 running-left
	 running-left-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player
    (sdl:draw-surface-at-* running-left
			   position-x
			   position-y
			   :cell running-left-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "running-left" duration))
      (incf running-left-current-cell)
      (setf frame-counter 0)
      (if (> running-left-current-cell (gethash "running-left"
						 total-cell-count))
	  (setf running-left-current-cell 0)))))

(defmethod running-right ((player player))
  (with-slots
	(position-x
	 position-y
	 running-right
	 running-right-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player
    (sdl:draw-surface-at-* running-right
			   position-x
			   position-y
			   :cell running-right-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "running-right" duration))
      (incf running-right-current-cell)
      (setf frame-counter 0)
      (if (> running-right-current-cell (gethash "running-right"
						 total-cell-count))
	  (setf running-right-current-cell 0)))))

(defmethod jumping-left ((player player))
  (with-slots
	(position-x
	 position-y
	 jumping-left
	 jumping-left-current-cell
	 total-cell-count
	 frame-counter
	 duration
	 ground-flag)
      player
    (if (eq ground-flag t)
	(setf jumping-left-current-cell 0))
    (sdl:draw-surface-at-* jumping-left
			   position-x
			   position-y
			   :cell jumping-left-current-cell)
    (incf frame-counter)	   
    (when (> frame-counter (gethash "jumping-left" duration))
      (incf jumping-left-current-cell)
      (setf frame-counter 0)
      (if (> jumping-left-current-cell (gethash "jumping-left"
						total-cell-count))
	  (setf jumping-left-current-cell (gethash "jumping-left"
						   total-cell-count))))))

(defmethod jumping-right ((player player))
  (with-slots
	(position-x
	 position-y
	 jumping-right
	 jumping-right-current-cell
	 total-cell-count
	 frame-counter
	 duration
	 ground-flag)
      player
    (if (eq ground-flag t)
	(setf jumping-right-current-cell 0))
    (sdl:draw-surface-at-* jumping-right
			   position-x
			   position-y
			   :cell jumping-right-current-cell)
    (incf frame-counter)	   
    (when (> frame-counter (gethash "jumping-right" duration))
      (incf jumping-right-current-cell)
      (setf frame-counter 0)
      (if (> jumping-right-current-cell (gethash "jumping-right"
						total-cell-count))
	  (setf jumping-right-current-cell (gethash "jumping-right"
						   total-cell-count))))))

(defmethod fox-girl-damage-motion1-left ((player player))
  (with-slots
	(position-x
	 position-y
	 fox-girl-damage-motion1-left
	 fox-girl-damage-motion1-left-current-cell
	 total-cell-count
	 frame-counter
	 duration
	 hp
	 action-name)
      player
    (when (and (<= hp 0)
	       (> fox-girl-damage-motion1-left-current-cell
		  (gethash "fox-girl-damage-motion1-left" total-cell-count)))
      (format t "down~%")
      (setf action-name "fox-girl-down-motion-left"))
    
    (sdl:draw-surface-at-* fox-girl-damage-motion1-left
			   position-x
			   position-y
			   :cell fox-girl-damage-motion1-left-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "fox-girl-damage-motion1-left" duration))
      (incf fox-girl-damage-motion1-left-current-cell)
      (setf frame-counter 0)
      (if (> fox-girl-damage-motion1-left-current-cell (gethash "fox-girl-damage-motion1-left"
								total-cell-count))
	  (setf fox-girl-damage-motion1-left-current-cell 0)))))

(defmethod fox-girl-damage-motion1-right ((player player))
  (with-slots
	(position-x
	 position-y
	 fox-girl-damage-motion1-right
	 fox-girl-damage-motion1-right-current-cell
	 total-cell-count
	 frame-counter
	 duration
	 hp
	 action-name)
      player
    (when (and (<= hp 0)
	       (> fox-girl-damage-motion1-right-current-cell
		  (gethash "fox-girl-damage-motion1-right" total-cell-count)))
      (format t "down~%")
      (setf action-name "fox-girl-down-motion-right"))
    
    (sdl:draw-surface-at-* fox-girl-damage-motion1-right
			   position-x
			   position-y
			   :cell fox-girl-damage-motion1-right-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "fox-girl-damage-motion1-right" duration))
      (incf fox-girl-damage-motion1-right-current-cell)
      (setf frame-counter 0)
      (if (> fox-girl-damage-motion1-right-current-cell (gethash "fox-girl-damage-motion1-right"
								total-cell-count))
	  (setf fox-girl-damage-motion1-right-current-cell 0)))))

(defmethod fox-girl-down-motion-left ((player player))
  (with-slots
	(position-x
	 position-y
	 fox-girl-down-motion-left
	 fox-girl-down-motion-left-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player
    (sdl:draw-surface-at-* fox-girl-down-motion-left
			   position-x
			   position-y
			   :cell fox-girl-down-motion-left-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "fox-girl-down-motion-left" duration))
      (setf frame-counter 0)
      (if (not (= fox-girl-down-motion-left-current-cell
		  (gethash "fox-girl-down-motion-left" total-cell-count)))
	  (incf fox-girl-down-motion-left-current-cell)))))

(defmethod fox-girl-down-motion-right ((player player))
  (with-slots
	(position-x
	 position-y
	 fox-girl-down-motion-right
	 fox-girl-down-motion-right-current-cell
	 total-cell-count
	 frame-counter
	 duration)
      player
    (sdl:draw-surface-at-* fox-girl-down-motion-right
			   position-x
			   position-y
			   :cell fox-girl-down-motion-right-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "fox-girl-down-motion-right" duration))
      (setf frame-counter 0)
      (if (not (= fox-girl-down-motion-right-current-cell
		  (gethash "fox-girl-down-motion-right" total-cell-count)))
	  (incf fox-girl-down-motion-right-current-cell)))))

(defmethod piyo-standing-left ((piyo piyo))
  (with-slots
	(position-x
	 position-y
	 standing-left
	 standing-left-current-cell
	 total-cell-count
	 duration
	 frame-counter)
      piyo
    (sdl:draw-surface-at-* standing-left
			   position-x
			   position-y
			   :cell standing-left-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "piyo-standing-left" duration))
      (incf standing-left-current-cell)
      (setf frame-counter 0)
      (if (> standing-left-current-cell (gethash "piyo-standing-left"
						 total-cell-count))
	  (setf standing-left-current-cell 0)))))

(defmethod piyo-standing-right ((piyo piyo))
  (with-slots
	(position-x
	 position-y
	 standing-right
	 standing-right-current-cell
	 total-cell-count
	 duration
	 frame-counter)
      piyo
    (sdl:draw-surface-at-* standing-right
			   position-x
			   position-y
			   :cell standing-right-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "piyo-standing-right" duration))
      (incf standing-right-current-cell)
      (setf frame-counter 0)
      (if (> standing-right-current-cell (gethash "piyo-standing-right"
						  total-cell-count))
	  (setf standing-right-current-cell 0)))))

(defmethod piyo-walking-left ((piyo piyo))
  (with-slots
	(position-x
	 position-y
	 walking-left
	 walking-left-current-cell
	 total-cell-count
	 duration
	 frame-counter)
      piyo
    (sdl:draw-surface-at-* walking-left
			   position-x
			   position-y
			   :cell walking-left-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "piyo-walking-left" duration))
      (incf walking-left-current-cell)
      (setf frame-counter 0)
      (if (> walking-left-current-cell (gethash "piyo-walking-left"
						 total-cell-count))
	  (setf walking-left-current-cell 0)))))

(defmethod piyo-walking-right ((piyo piyo))
  (with-slots
	(position-x
	 position-y
	 walking-right
	 walking-right-current-cell
	 total-cell-count
	 duration
	 frame-counter)
      piyo
    (sdl:draw-surface-at-* walking-right
			   position-x
			   position-y
			   :cell walking-right-current-cell)
    (incf frame-counter)
    (when (> frame-counter (gethash "piyo-walking-right" duration))
      (incf walking-right-current-cell)
      (setf frame-counter 0)
      (if (> walking-right-current-cell (gethash "piyo-walking-right"
						total-cell-count))
	  (setf walking-right-current-cell 0)))))