(in-package :game)

;;;; debug
(declaim (optimize (debug 3) (safety 3)
                   (speed 0) (space 0) (compilation-speed 0)))

;; gameover
(defparameter *gameover-flag* nil)
(defparameter *gameover* nil)

;; debug flag
(defparameter *debug* t)

;; player
(defvar *player* nil)

;; enemy
(defvar *piyo* nil)
(defvar *piyo2* nil)

;; key-state
(defparameter *current-key* nil)
(defparameter *current-key-state* (make-instance 'key-state))

;; background
(defparameter *background* nil)

;; window
(defparameter *window-width* 800)
(defparameter *window-height* 600)
(defparameter *window-center-x* (/ *window-width* 2))

;; stage
(defparameter *scroll-x* 10)
(defparameter *scroll-array-counter* 0)
(defparameter *scroll-line-left* (+ *window-center-x* -100))
(defparameter *scroll-line-right* (+ *window-center-x* 100))

;; block
(defparameter *block-width* 40)
(defparameter *block-height* 40)
(defparameter *block-array* (load-csv "map2.csv"))
(defparameter *block-row* (array-dimension *block-array* 1))
(defparameter *block-column* (array-dimension *block-array* 0))
(defparameter *block-instance-array* (make-array `(,*block-column* ,*block-row*)))
(defparameter *the-number-of-row-block-in-window* (/ *window-width* *block-width*))
(defparameter *the-number-of-column-block-in-window* (/ *window-height* *block-height*))

;; g-flag
(defparameter *g-flag* t)
(defparameter *piyo-g-flag* t)
(defparameter *piyo2-g-flag* t)

;; free-fall
(defparameter *player-free-fall* (generate-free-fall))
(defparameter *piyo-free-fall* (generate-free-fall))
(defparameter *piyo2-free-fall* (generate-free-fall))

;; full screen flag
(defparameter *full-screen-flag* nil)

(defun scroll ()
  "scrolling stage"
  ;; right scroll line
  (when (> (x (collision *player*)) *scroll-line-right*)
    (loop for y from 0 to (- *block-column* 1) by 1 collect
	 (loop for x from 0 to (- *block-row* 1) by 1 collect
	      (progn
		(-= (image-object-position-x (aref *block-instance-array* y x))
		    *scroll-x*)
		(-= (x (collision (aref *block-instance-array* y x)))
		    *scroll-x*))))
    (-= (image-object-position-x *piyo*)
	*scroll-x*)
    (-= (x (collision *piyo*))
	*scroll-x*)
    (-= (image-object-position-x *piyo2*)
	*scroll-x*)
    (-= (x (collision *piyo2*))
	*scroll-x*)
    (when (<= (image-object-position-x (aref *block-instance-array*
				       0
				       *scroll-array-counter*))
	    -40)
      (if (not (= (+ *scroll-array-counter* *the-number-of-row-block-in-window*) (- *block-row* 1)))
	  (+= *scroll-array-counter* 1)))
    (format t "~a~%" *scroll-array-counter*)
    (-= (image-object-position-x *player*) *scroll-x*)
    (-= (x (collision *player*)) *scroll-x*))
  
  ;; left scroll line
  (when (< (x (collision *player*)) *scroll-line-left*)
    (loop for y from 0 to (- *block-column* 1) by 1 collect
	 (loop for x from 0 to (- *block-row* 1) by 1 collect
	      (progn
	      (+= (image-object-position-x (aref *block-instance-array* y x))
		  *scroll-x*)
	      (+= (x (collision (aref *block-instance-array* y x)))
		  *scroll-x*))))
    (+= (image-object-position-x *piyo*)
	*scroll-x*)
    (+= (x (collision *piyo*))
	*scroll-x*)
    (+= (image-object-position-x *piyo2*)
	*scroll-x*)
    (+= (x (collision *piyo2*))
	*scroll-x*)

    ;;;;
        (when (>= (image-object-position-x (aref *block-instance-array*
				       0
				       (+ *scroll-array-counter*
					  *the-number-of-row-block-in-window*)))	
	    800)
      (if (not (= *scroll-array-counter* 0))
	  (-= *scroll-array-counter* 1)))
    ;;;;
    (+= (image-object-position-x *player*) *scroll-x*)
    (+= (x (collision *player*)) *scroll-x*)))

(defun generate-instance ()
  (setf *player* (make-instance 'player	:x 200 :y 300 :direction "left"))
  (setf *piyo* (make-instance 'piyo :x 100 :y 0 :direction "right"))
  (setf *piyo2* (make-instance 'piyo :x 200 :y 0 :direction "right"))
  (setf *background* (make-instance 'background)) 

  (loop for y from 0 to (- *block-column* 1) by 1 collect
       (loop for x from 0 to (- *block-row* 1) by 1 collect
	    (setf (aref *block-instance-array* y x)
		  (make-instance 'blocks
				 :x (* x *block-width*) 
				 :y (* y *block-width*) 
				 :draw-flag (aref *block-array* y x)
				 :id (aref *block-array* y x))))))

(defun initialize ()
  (sdl:window *window-width*
	      *window-height*
	      :title-caption "2DACT"
	      :fullscreen *full-screen-flag*
	      :double-buffer t
	      :hw t
	      :position #(50 50))
  (setf (sdl:frame-rate) 60)
  (sdl:set-video-driver "directx")
  (sdl:init-video)
  (setf *gameover* (sdl:load-image "../pixel_animation/gameover.png"
				   :color-key sdl:*black*))
  (generate-instance))		    

(defun key-event2 (player current-key-state)
  (with-slots (right left up) current-key-state
    (with-slots (ground-flag direction action-name) player
      (when (and (eq up nil)
		 (eq left nil)
		 (eq right nil)
		 (eq ground-flag t)
		 (string= direction "left"))
	(setf action-name "standing-left"))
      (when (and (eq up nil)
		 (eq left nil)
		 (eq right nil)
		 (eq ground-flag t)
		 (string= direction "right"))
	(setf action-name "standing-right"))
      (if (eq up t) (jump player))
      (if (eq left t) (move player "left"))
      (if (eq right t) (move player "right")))))

(defun draw-stage-debug-mode2 (instance-array)
  (setf *block-array* (load-csv "map2.csv"))
  (loop for y from 0 to (- *block-column* 1) by 1 collect
       (loop for x from *scroll-array-counter* to (+ *the-number-of-row-block-in-window* *scroll-array-counter*)
	  by 1 collect
	    (progn
	      ;;debug mode
	      (setf (image-object-id (aref instance-array y x))
		    (aref *block-array* y x))
	      (setf (image-object-draw-flag (aref instance-array y x))
		    (aref *block-array* y x))
	      (if (>= (image-object-draw-flag (aref instance-array y x)) 0)
		  (draw-sprite (aref instance-array y x)))))))

(defun draw ()
  ;; damage piyo
  (when (eq (damage-detect *piyo*) t)
    (if (>= (image-object-hp *player*) 1)
	(hp *player* -1))
;      (-= (image-object-hp *player*) 1))
    (cond ((string= (image-object-direction *player*) "left")
	   (format t "l~%")
	   (setf (image-object-action-name *player*) "fox-girl-damage-motion1-left"))
	  ((string= (image-object-direction *player*) "right")
	   (format t "r~%")
	   (setf (image-object-action-name *player*) "fox-girl-damage-motion1-right"))))
  ;; damage piyo2
  (when (eq (damage-detect *piyo2*) t)
    (if (>= (image-object-hp *player*) 1) 
      (-= (image-object-hp *player*) 1))
    (cond ((string= (image-object-direction *player*) "left")
	   (format t "l~%")
	   (setf (image-object-action-name *player*) "fox-girl-damage-motion1-left"))
	  ((string= (image-object-direction *player*) "right")
	   (format t "r~%")
	   (setf (image-object-action-name *player*) "fox-girl-damage-motion1-right"))))
  (when (<= (image-object-hp *player*) 0)
    (cond ((string= (image-object-direction *player*) "left")
	   (format t "l~%")
	   (setf (image-object-action-name *player*) "fox-girl-down-motion-left"))
	  ((string= (image-object-direction *player*) "right")
	   (format t "r~%")
	   (setf (image-object-action-name *player*) "fox-girl-down-motion-right"))))
  (draw-sprite *background*)
  (draw-sprite *piyo*)
  (draw-sprite *piyo2*)
  (draw-sprite *player*)
  (draw-stage-debug-mode2 *block-instance-array*)

  (when (eq *debug* t)
    (draw-hitbox)
    (draw-damage-box)))

(defun draw-hitbox ()
  (when (eq *debug* t)
    (let ((color (sdl:color :r 255)))
;    (defvar color (sdl:color :r 255))
    ;; player
    (sdl:draw-rectangle-* (x (collision *player*))
			  (y (collision *player*))
			  (w (collision *player*))
			  (h (collision *player*))
			  :color color)
    ;; piyo
    (sdl:draw-rectangle-* (x (collision *piyo*))
			  (y (collision *piyo*))
			  (w (collision *piyo*))
			  (h (collision *piyo*))
			  :color color)
    (sdl:draw-rectangle-* (x (collision *piyo2*))
			  (y (collision *piyo2*))
			  (w (collision *piyo2*))
			  (h (collision *piyo2*))
			  :color color))))

(defun draw-damage-box ()
  (when (eq *debug* t)
    (let ((color (sdl:color :b 255)))
    ;; player
    (sdl:draw-rectangle-* (x (damage-collision *player*))
			  (y (damage-collision *player*))
			  (w (damage-collision *player*))
			  (h (damage-collision *player*))
			  :color color)
    ;; piyo
    (sdl:draw-rectangle-* (x (damage-collision *piyo*))
			  (y (damage-collision *piyo*))
			  (w (damage-collision *piyo*))
			  (h (damage-collision *piyo*))
			  :color color)
    (sdl:draw-rectangle-* (x (damage-collision *piyo2*))
			  (y (damage-collision *piyo2*))
			  (w (damage-collision *piyo2*))
			  (h (damage-collision *piyo2*))
			  :color color))))
  
(defun block-collision ()
  (let ((bottom-collision-flag-counter-player 0)
	(bottom-collision-flag-counter-piyo 0)
	(bottom-collision-flag-counter-piyo2 0))
    (loop for y from 0 to (- *block-column* 1) by 1 collect
	 (loop for x from 0 to (- *block-row* 1) by 1 collect
	      (when (>= (image-object-draw-flag (aref *block-instance-array* y x))
		       0)
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;; player
		(if (eq (bottom-collide *player* (aref *block-instance-array* y x))
			t)
		    (incf bottom-collision-flag-counter-player))		
		(if (> bottom-collision-flag-counter-player 0)
		    (progn
		      (setf *g-flag* nil)
		      (setf (image-object-ground-flag *player*) t)
		      (setf (image-object-air-flag *player*) nil))
		    (progn 
		      (setf *g-flag* t)
		      (setf (image-object-ground-flag *player*) nil)
		      (setf (image-object-air-flag *player*) t)))
		(collide *player* (aref *block-instance-array* y x))
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;; piyo
		(if (eq (bottom-collide *piyo* (aref *block-instance-array* y x))
			t)
		    (incf bottom-collision-flag-counter-piyo))		
		(if (> bottom-collision-flag-counter-piyo 0)
		    (progn
		      (setf *piyo-g-flag* nil)
		      (setf (image-object-ground-flag *piyo*) t)
		      (setf (image-object-air-flag *piyo*) nil))
		    (progn 
		      (setf *piyo-g-flag* t)
		      (setf (image-object-ground-flag *piyo*) nil)
		      (setf (image-object-air-flag *piyo*) t)))
		(collide *piyo* (aref *block-instance-array* y x))
		;; piyo2
		(if (eq (bottom-collide *piyo2* (aref *block-instance-array* y x))
			t)
		    (incf bottom-collision-flag-counter-piyo2))		
		(if (> bottom-collision-flag-counter-piyo2 0)
		    (progn
		      (setf *piyo2-g-flag* nil)
		      (setf (image-object-ground-flag *piyo2*) t)
		      (setf (image-object-air-flag *piyo2*) nil))
		    (progn 
		      (setf *piyo2-g-flag* t)
		      (setf (image-object-ground-flag *piyo2*) nil)
		      (setf (image-object-air-flag *piyo2*) t)))
		(collide *piyo2* (aref *block-instance-array* y x)))))))

(defun piyo-ai ()		       
  (when (eq (image-object-left-collision-flag *piyo*) t)
    (setf (image-object-direction *piyo*) "right")
    (setf (image-object-action-name *piyo*) "piyo-walking-right")
    (setf (image-object-left-collision-flag *piyo*) nil))
  (when (eq (image-object-left-collision-flag *piyo2*) t)
    (setf (image-object-direction *piyo2*) "right")
    (setf (image-object-action-name *piyo2*) "piyo-walking-right")
    (setf (image-object-left-collision-flag *piyo2*) nil))
  (when (eq (image-object-right-collision-flag *piyo*) t)
    (setf (image-object-direction *piyo*) "left")
    (setf (image-object-action-name *piyo*) "piyo-walking-left")
    (setf (image-object-right-collision-flag *piyo*) nil))
  (when (eq (image-object-right-collision-flag *piyo2*) t)
    (setf (image-object-direction *piyo2*) "left")
    (setf (image-object-action-name *piyo2*) "piyo-walking-left")
    (setf (image-object-right-collision-flag *piyo2*) nil))
  
  (cond ((string= (image-object-direction *piyo*) "left")
	 (move *piyo* "left"))
	((string= (image-object-direction *piyo*) "right")
	 (move *piyo* "right")))
  (cond ((string= (image-object-direction *piyo2*) "left")
	 (move *piyo2* "left"))
	((string= (image-object-direction *piyo2*) "right")
	 (move *piyo2* "right"))))

(defun check-jump-flag ()
  (if (eq (image-object-jump-flag *player*) t)		  
      (progn
	(setf *g-flag* nil)
	(jump *player*))))

(defun free-fall ()
  (funcall *player-free-fall* *player* *g-flag*)
  (funcall *piyo-free-fall* *piyo* *piyo-g-flag*)
  (funcall *piyo2-free-fall* *piyo2* *piyo2-g-flag*))

(defun update-character ()
  (mapcar #'update `(,*player*
		     ,*piyo*
		     ,*piyo2*)))

(defun damage-detect (enemy)
  (if (and (<= (x (collision *player*)
	       (+ (image-object-attack-collision-x enemy)
		  (image-object-attack-collision-width enemy)))
	   (<= (image-object-attack-collision-x enemy)
	       (+ (x (collision *player*)
		  (image-object-damage-collision-width *player*)))
	   (<= (image-object-damage-collision-y *player*)
	       (+ (image-object-attack-collision-y enemy)
		  (image-object-attack-collision-height enemy)))
	   (<= (image-object-attack-collision-y enemy)
	       (+ (image-object-damage-collision-y *player*)
		  (image-object-damage-collision-height *player*))))
    t
    nil))  

(defun gameover ()
  (when (or (<= (image-object-hp *player*) 0)
	    (>= (image-object-position-y *player*) 600))
    (setf *gameover-flag* t)
    (sdl:clear-display sdl:*black*)	
    (check-jump-flag)
    (free-fall)
    (block-collision)
    (scroll)
    (update-character)
    (piyo-ai)
    (draw)
    (cond ((string= (image-object-direction *player*) "left")
	   (setf (image-object-action-name *player*)
		 "fox-girl-down-motion-left"))
	  ((string= (image-object-direction *player*) "right")
	   (setf (image-object-action-name *player*)
		 "fox-girl-down-motion-right")))
    (sdl:draw-surface-at-* *gameover* 0 0)
    (sdl:update-display)))

(defun mainloop ()
  (when (and (> (image-object-hp *player*) 0)
	     (< (image-object-position-y *player*) 600))
    (setf *gameover-flag* nil)
    (sdl:clear-display sdl:*black*)
    (key-event2 *player* *current-key-state*)
    (check-jump-flag)
    (free-fall)
    (block-collision)
    (scroll)
    (update-character)
    (piyo-ai)
    (draw)
    (sdl:update-display)))

(defun reset ()
  (reinitialize-instance *player*))

(defun main ()
  (sdl:with-init ()
    (initialize)
    (sdl:with-events (:poll)
      (:quit-event () t)
      (:key-down-event (:key key)
		       (when (sdl:key= key :sdl-key-escape)
			 (sdl:push-quit-event))
		       (when (sdl:key= key :sdl-key-1)
			 (if (eq *full-screen-flag* nil)
			     (setf *full-screen-flag* t)
			     (setf *full-screen-flag* nil))
			 (sdl:window 800 600 :fullscreen *full-screen-flag*))
		       (when (sdl:key= key :sdl-key-d)
			 (if (eq *debug* nil)
			     (setf *debug* t)
			     (setf *debug* nil)))
		       (when (sdl:key= key :sdl-key-r)
			 (if (eq *gameover-flag* t)
			     (reset)))
		       (update-key-state key t *current-key-state*))
      (:key-up-event (:key key)
		     (update-key-state key nil *current-key-state*))
      (:idle ()
	     (gameover)
	     (mainloop)))))
