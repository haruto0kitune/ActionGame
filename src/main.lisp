;;;; debug
(declaim (optimize (debug 3) (safety 3)
                   (speed 0) (space 0) (compilation-speed 0)))

;;;; attention
;;;;
;;;; a large scale refactoring
;;;;

;;;; temp todo memo
;;;;
;;;; 
;;;;

;;;; next todo
;;;;
;;;; implement the enemy.
;;;;

(load "key-state.lisp" :external-format :utf-8)
(load "load-csv.lisp" :external-format :utf-8)
(load "sprite-sheet-class.lisp" :external-format :utf-8)
(load "player-class.lisp" :external-format :utf-8)
(load "block-class.lisp" :external-format :utf-8)
(load "collision.lisp" :external-format :utf-8)
(load "gravity.lisp" :external-format :utf-8)
(load "load-json" :external-format :utf-8)
(load "piyo-class" :external-format :utf-8)

;; debug flag
(defparameter *debug* t)

;; hash table for action-name
(defparameter *action-name* (make-hash-table :test #'equal))
(setf (gethash "standing-left" *action-name*) "standing-left")
(setf (gethash "standing-right" *action-name*) "standing-right")
(setf (gethash "running-left" *action-name*) "running-left")
(setf (gethash "running-right" *action-name*) "running-right")
(setf (gethash "jumping-left" *action-name*) "jumping-left")
(setf (gethash "jumping-right" *action-name*) "jumping-right")
(setf (gethash "piyo-standing-left" *action-name*) "piyo-standing-left")
(setf (gethash "piyo-standing-right" *action-name*) "piyo-standing-right")
(setf (gethash "piyo-walking-left" *action-name*) "piyo-walking-left")
(setf (gethash "piyo-walking-right" *action-name*) "piyo-walking-right")

;; hash table for filename
(defparameter *filename* (make-hash-table :test #'equal))
(setf (gethash "standing-left" *filename*)
      "../pixel_animation/player_standing_left.png")
(setf (gethash "standing-right" *filename*)
      "../pixel_animation/player_standing_right.png")
;(setf (gethash "walking-left" *filename*)
;     "../pixel_animation/player_walking_left.png")
;(setf (gethash "walking-right" *filename*)
;      "../pixel_animation/player_walking_right.png")
(setf (gethash "running-left" *filename*)
      "../pixel_animation/player_running_left.png")
(setf (gethash "running-right" *filename*)
      "../pixel_animation/player_running_right.png")
(setf (gethash "jumping-left" *filename*)
      "../pixel_animation/player_jumping_left.png")
(setf (gethash "jumping-right" *filename*)
      "../pixel_animation/player_jumping_right.png")
;;;; enemy
;;; piyo
(setf (gethash "piyo-standing-left" *filename*)
      "../pixel_animation/enemy/enemy1_standing1_left.png")
(setf (gethash "piyo-standing-right" *filename*)
      "../pixel_animation/enemy/enemy1_standing1_right.png")
(setf (gethash "piyo-walking-left" *filename*)
      "../pixel_animation/enemy/enemy1_walk_left.png")
(setf (gethash "piyo-walking-right" *filename*)
      "../pixel_animation/enemy/enemy1_walk_right.png")

;; hash table for duration
(defparameter *duration* (make-hash-table :test #'equal))
(setf (gethash "standing-left" *duration*) 7)
(setf (gethash "standing-right" *duration*) 7)
(setf (gethash "running-left" *duration*) 4)
(setf (gethash "running-right" *duration*) 4)
(setf (gethash "jumping-left" *duration*) 4)
(setf (gethash "jumping-right" *duration*) 4)
(setf (gethash "piyo-standing-left" *duration*) 1)
(setf (gethash "piyo-standing-right" *duration*) 1)
(setf (gethash "piyo-walking-left" *duration*) 3)
(setf (gethash "piyo-walking-right" *duration*) 3)

;; hash table for cells
;; actual cell - 1
(defparameter *cell* (make-hash-table :test #'equal))
(setf (gethash "block" *cell*) 2)
(setf (gethash "standing-left" *cell*) 11)
(setf (gethash "standing-right" *cell*) 11)
(setf (gethash "running-left" *cell*) 7)
(setf (gethash "running-right" *cell*) 7)
(setf (gethash "jumping-left" *cell*) 3)
(setf (gethash "jumping-right" *cell*) 3)
(setf (gethash "piyo-standing-left" *cell*) 0)
(setf (gethash "piyo-standing-right" *cell*) 0)
(setf (gethash "piyo-walking-left" *cell*) 1)
(setf (gethash "piyo-walking-right" *cell*) 1)

;; filename
(defparameter *background* "../pixel_animation/background.png")
(defparameter *standing_right* "../pixel_animation/player_standing.png")
(defparameter *standing_left* "../pixel_animation/player_standing_left.png")
(defparameter *dash_left* "../pixel_animation/player_dash_left.png")
(defparameter *dash_right* "../pixel_animation/player_dash.png")
(defparameter *jump_right* "../pixel_animation/player_jump.png")
(defparameter *jump_left* "../pixel_animation/player_jump_left.png")

;;sprite width height
(defparameter *sprite-width* 128)
(defparameter *sprite-height* 128)

;;sprite total cell count
(defparameter *cells-of-player_standing* 12)
(defparameter *cells-of-player_dash* 8)
(defparameter *cells-of-player_jump* 10)

;; player
(defvar *player* nil)

;; enemy
(defvar *piyo* nil)
(defvar *piyo2* nil)

;; move
(defparameter *left-dash* nil)
(defparameter *right-dash* nil)

;; jump
(defparameter *player-jump* nil)
(defparameter *player-jump-left* nil)
(defparameter *draw-player-jump* nil)
(defparameter *draw-player-jump-left* nil)
(defparameter *jump* nil)
(defparameter *y_temp* 0)
(defparameter *y_prev* 0)
(defparameter *F* 20)
(defparameter *jump-flag* nil)
(defparameter *jump-right-flag* nil)
(defparameter *jump-left-flag* nil)

;; key-state
(defparameter *current-key* nil)

;; background
(defparameter *background* nil)

;; window
(defparameter *window-width* 800)
(defparameter *window-height* 600)
(defparameter *window-center-x* (/ *window-width* 2))

;; other
(defparameter *standing* nil)

;; key state
(defparameter *current-key-state* (make-instance 'key-state))

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
  (when (> (image-object-collision-x *player*) *scroll-line-right*)
    (loop for y from 0 to (- *block-column* 1) by 1 collect
	 (loop for x from 0 to (- *block-row* 1) by 1 collect
	      (progn
		(-= (image-object-position-x (aref *block-instance-array* y x))
		    *scroll-x*)
		(-= (image-object-collision-x (aref *block-instance-array* y x))
		    *scroll-x*))))
    (-= (image-object-position-x *piyo*)
	*scroll-x*)
    (-= (image-object-collision-x *piyo*)
	*scroll-x*)
    (-= (image-object-position-x *piyo2*)
	*scroll-x*)
    (-= (image-object-collision-x *piyo2*)
	*scroll-x*)
    (when (<= (image-object-position-x (aref *block-instance-array*
				       0
				       *scroll-array-counter*))
	    -40)
;      (format t "a")
      (if (not (= (+ *scroll-array-counter* *the-number-of-row-block-in-window*) (- *block-row* 1)))
	  (+= *scroll-array-counter* 1)))
    (format t "~a~%" *scroll-array-counter*)
    (-= (image-object-position-x *player*) *scroll-x*)
    (-= (image-object-collision-x *player*) *scroll-x*))
  
  ;; left scroll line
  (when (< (image-object-collision-x *player*) *scroll-line-left*)
    (loop for y from 0 to (- *block-column* 1) by 1 collect
	 (loop for x from 0 to (- *block-row* 1) by 1 collect
	      (progn
	      (+= (image-object-position-x (aref *block-instance-array* y x))
		  *scroll-x*)
	      (+= (image-object-collision-x (aref *block-instance-array* y x))
		  *scroll-x*))))
    (+= (image-object-position-x *piyo*)
	*scroll-x*)
    (+= (image-object-collision-x *piyo*)
	*scroll-x*)
    (+= (image-object-position-x *piyo2*)
	*scroll-x*)
    (+= (image-object-collision-x *piyo2*)
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
    (+= (image-object-collision-x *player*) *scroll-x*)))

(defun generate-instance ()
  (setf *player* (make-instance 'player
				:filename *filename*
				:collision-x 243
				:collision-y 15
				:collision-width 39
				:collision-height 113
				:position-x 200
				:position-y 0
				:velocity-x 10
				:velocity-y 10
				:width 128
				:height 128
				:x-cell-count *cell*
				:y-cell-count 0
				:total-cell-count *cell*
				:duration *duration*
				:draw-flag t))
  (setf *piyo* (make-instance 'piyo
			      :filename *filename*
			      :collision-x 109
			      :collision-y 13
			      :collision-width 40
			      :collision-height 40
			      :position-x 100			      
			      :position-y 0
			      :velocity-x 4			      
			      :velocity-y 8
			      :width 64
			      :height 64
			      :x-cell-count *cell*
			      :y-cell-count 0
			      :total-cell-count *cell*
			      :duration *duration*
			      :direction "right"
			      :action-name "piyo-walking-right"
			      :draw-flag t))
  (setf *piyo2* (make-instance 'piyo
			      :filename *filename*
			      :collision-x 209
			      :collision-y 13
			      :collision-width 40
			      :collision-height 40
			      :position-x 200			      
			      :position-y 0
			      :velocity-x 4			      
			      :velocity-y 8
			      :width 64
			      :height 64
			      :x-cell-count *cell*
			      :y-cell-count 0
			      :total-cell-count *cell*
			      :duration *duration*
			      :direction "right"
			      :action-name "piyo-walking-right"
			      :draw-flag t))
  (setf *background*
	(make-instance 'image-object
		       :filename "../pixel_animation/background.png"
		       :position-x 0
		       :position-y 0
		       :width 800
		       :height 600))
  ;;
  ;; generate block instance
  ;;
  (loop for y from 0 to (- *block-column* 1) by 1 collect
       (loop for x from 0 to (- *block-row* 1) by 1 collect
	    (setf (aref *block-instance-array* y x)
		  (make-instance 'blocks
				 :filename "../pixel_animation/test1.png"
				 :collision-x (* x *block-width*) 
				 :collision-y (* y *block-height*) 
				 :collision-width *block-width*
				 :collision-height *block-height*
				 :position-x (* x *block-width*) 
				 :position-y (* y *block-width*) 
				 :width *block-width*
				 :height *block-height*
				 :x-cell-count 2
				 :y-cell-count 0
				 :total-cell-count 2
				 :duration 0
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
  (generate-instance))		    

(defun key-event2 (player)
  (with-slots (right left up) *current-key-state*
;    (format t "up:~a~%" up)
;    (format t "right:~a~%" right)
;    (format t "left:~a~%" left)
    (when (and (eq up nil)
	       (eq left nil)
	       (eq right nil)
	       (eq (image-object-ground-flag player) t)
	       (string= (image-object-direction player) "left"))
      (setf (image-object-action-name player) "standing-left"))
    (when (and (eq up nil)
	       (eq left nil)
	       (eq right nil)
	       (eq (image-object-ground-flag player) t)
	       (string= (image-object-direction player) "right"))
      (setf (image-object-action-name player) "standing-right"))
    (when (and (eq up t)
	       (eq left t))
      (when (eq (image-object-ground-flag player) t)
	(setf (image-object-jump-flag player) t)
	(when (string= (image-object-direction player) "left")
	  (setf (image-object-action-name player) "jumping-left"))))
    (when (eq up t)
      (when (eq (image-object-ground-flag player) t)
	(setf (image-object-jump-flag player) t)
	(when (string= (image-object-direction player) "left")
	  (setf (image-object-action-name player) "jumping-left"))
	(when (string= (image-object-direction player) "right")
	  (setf (image-object-action-name player) "jumping-right"))))
    (when (and (eq left t)
	       (eq right nil))
      (move-left player)
      (setf (image-object-direction player) "left")
      (if (eq (image-object-air-flag player) nil)
	  (setf (image-object-action-name player) "running-left")
	  (setf (image-object-action-name player) "jumping-left")))
    (when (and (eq right t)
	       (eq left nil))
      (move-right player)
      (setf (image-object-direction player) "right")
      (if (eq (image-object-air-flag player) nil)
	  (setf (image-object-action-name player) "running-right")
	  (setf (image-object-action-name player) "jumping-right")))))

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
  (draw-sprite *background*)
  (piyo-ai)
  (draw-sprite-piyo *piyo*
		    (image-object-action-name *piyo*))
  (draw-sprite-piyo *piyo2*
		      (image-object-action-name *piyo2*))
  (draw-sprite-player *player*
		      (image-object-action-name *player*))
  (draw-stage-debug-mode2 *block-instance-array*)
  (if (eq *debug* t) (draw-hitbox)))

(defun draw-hitbox ()
  (when (eq *debug* t)
    (defvar color (sdl:color :r 255))
    ;; player
    (sdl:draw-rectangle-* (image-object-collision-x *player*)
			  (image-object-collision-y *player*)
			  (image-object-collision-width *player*)
			  (image-object-collision-height *player*)
			  :color color)
    ;; piyo
    (sdl:draw-rectangle-* (image-object-collision-x *piyo*)
			  (image-object-collision-y *piyo*)
			  (image-object-collision-width *piyo*)
			  (image-object-collision-height *piyo*)
			  :color color)))

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
	 (move-left *piyo*))
	((string= (image-object-direction *piyo*) "right")
	 (move-right *piyo*)))
  (cond ((string= (image-object-direction *piyo2*) "left")
	 (move-left *piyo2*))
	((string= (image-object-direction *piyo2*) "right")
	 (move-right *piyo2*))))

(defun check-jump-flag ()
  (if (eq (image-object-jump-flag *player*) t)		  
      (progn
	(setf *g-flag* nil)
	(jump *player*))))

(defun free-fall ()
  (funcall *player-free-fall* *player* *g-flag*)
  (funcall *piyo-free-fall* *piyo* *piyo-g-flag*)
  (funcall *piyo2-free-fall* *piyo2* *piyo2-g-flag*))
  
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
		       (update-key-state key t *current-key-state*))
      (:key-up-event (:key key)
		     (update-key-state key nil *current-key-state*))
      (:idle ()
	     (sdl:clear-display sdl:*black*)
	     (key-event2 *player*)
	     (check-jump-flag)
	     (free-fall)
	     (block-collision)
	     (scroll)
	     (draw)
	     (sdl:update-display)))))
