(in-package :game)

(defclass player-sprite-sheet ()
  ((filename
    :initform (make-hash-table :test #'equal))
   (w
    :initform 128)
   (h
    :initform 128)
   (sprite-sheet
    :reader sprite-sheet
    :initform (make-hash-table :test #'equal))
   (cells
    :reader cells
    :initform (make-instance 'player-cells))
   (duration
    :reader duration
    :initform (make-hash-table :test #'equal))))

(defmethod set-filename ((player-sprite-sheet player-sprite-sheet))
  (with-slots (filename) player-sprite-sheet
    (setf (gethash "standing-left" filename) "../pixel_animation/player_standing_left.png")
    (setf (gethash "standing-right" filename) "../pixel_animation/player_standing_right.png")
    (setf (gethash "running-left" filename) "../pixel_animation/player_running_left.png")
    (setf (gethash "running-right" filename) "../pixel_animation/player_running_right.png")
    (setf (gethash "jumping-left" filename) "../pixel_animation/player_jumping_left.png")
    (setf (gethash "jumping-right" filename) "../pixel_animation/player_jumping_right.png")
    (setf (gethash "damage-motion-left" filename) "../pixel_animation/fox_girl_damage_motion1_left.png")
    (setf (gethash "damage-motion-right" filename) "../pixel_animation/fox_girl_damage_motion1_right.png")
    (setf (gethash "down-motion-left" filename) "../pixel_animation/fox_girl_down_motion_left2.png")
    (setf (gethash "down-motion-right" filename) "../pixel_animation/fox_girl_down_motion_right2.png")))

(defmethod load-image ((player-sprite-sheet player-sprite-sheet))
  (with-slots (sprite-sheet filename) player-sprite-sheet
    (setf (gethash "standing-left" sprite-sheet) (sdl:load-image (gethash "standing-left" filename) :color-key sdl:*black*))
    (setf (gethash "standing-right" sprite-sheet) (sdl:load-image (gethash "standing-right" filename) :color-key sdl:*black*))
    (setf (gethash "running-left" sprite-sheet) (sdl:load-image (gethash "running-left" filename) :color-key sdl:*black*))
    (setf (gethash "running-right" sprite-sheet) (sdl:load-image (gethash "running-right" filename) :color-key sdl:*black*))
    (setf (gethash "jumping-left" sprite-sheet) (sdl:load-image (gethash "jumping-left" filename) :color-key sdl:*black*))
    (setf (gethash "jumping-right" sprite-sheet) (sdl:load-image (gethash "jumping-right" filename) :color-key sdl:*black*))
    (setf (gethash "damage-motion-left" sprite-sheet) (sdl:load-image (gethash "damage-motion-left" filename) :color-key sdl:*black*))
    (setf (gethash "damage-motion-right" sprite-sheet) (sdl:load-image (gethash "damage-motion-right" filename) :color-key sdl:*black*))
    (setf (gethash "down-motion-left" sprite-sheet) (sdl:load-image (gethash "down-motion-left" filename) :color-key sdl:*black*))
    (setf (gethash "down-motion-right" sprite-sheet) (sdl:load-image (gethash "down-motion-right" filename) :color-key sdl:*black*))))

(defmacro sprite-cells2 (player-sprite-sheet string)
  "return list"
 ``(with-slots (w h cells) player-sprite-sheet
     (loop for y from 0 to
	  (funcall #'y-cells cells) by ,h
	 append (loop for x from 0 to (funcall #'* ,w (funcall #'gethash string (funcall #'x-cells cells))) by ,w collect (list x y ,w ,h)))))

(defmethod generate-sprite-cells ((player-sprite-sheet player-sprite-sheet) string)
  "return list"
  (with-slots (w h cells) player-sprite-sheet
    ``(loop for y from 0 to ,,(funcall #'y-cells cells) by ,,h
	 append (loop for x from 0 to (funcall #'* ,,w ,(funcall ,#'gethash ,string (funcall ,#'x-cells ,cells))) by ,,w collect (list x y ,,w ,,h)))))

(defmethod set-standing-left ((player-sprite-sheet player-sprite-sheet))
  (with-slots (filename w h cells sprite-sheet) player-sprite-sheet
    (let ((sprite-cells (generate-sprite-cells player-sprite-sheet "standing-left")))
      (setf (sdl:cells (gethash "standing-left" sprite-sheet)) sprite-cells))))

(defmethod set-standing-right ((player-sprite-sheet player-sprite-sheet))
  (with-slots (filename w h cells sprite-sheet) player-sprite-sheet
    (let ((sprite-cells (generate-sprite-cells player-sprite-sheet "standing-right")))
      (setf (sdl:cells (gethash "standing-right" sprite-sheet)) sprite-cells))))

(defmethod set-running-left ((player-sprite-sheet player-sprite-sheet))
  (with-slots (filename w h cells sprite-sheet) player-sprite-sheet
    (let ((sprite-cells (generate-sprite-cells player-sprite-sheet "running-left")))
      (setf (sdl:cells (gethash "running-left" sprite-sheet)) sprite-cells))))

(defmethod set-running-right ((player-sprite-sheet player-sprite-sheet))
  (with-slots (filename w h cells sprite-sheet) player-sprite-sheet
    (let ((sprite-cells (generate-sprite-cells player-sprite-sheet "running-right")))
      (setf (sdl:cells (gethash "running-right" sprite-sheet)) sprite-cells))))

(defmethod set-jumping-left ((player-sprite-sheet player-sprite-sheet))
  (with-slots (filename w h cells sprite-sheet) player-sprite-sheet
    (let ((sprite-cells (generate-sprite-cells player-sprite-sheet"jumping-left")))
      (setf (sdl:cells (gethash "jumping-left" sprite-sheet)) sprite-cells))))

(defmethod set-jumping-right ((player-sprite-sheet player-sprite-sheet))
  (with-slots (filename w h cells sprite-sheet) player-sprite-sheet
    (let ((sprite-cells (generate-sprite-cells player-sprite-sheet "jumping-right")))
      (setf (sdl:cells (gethash "jumping-right" sprite-sheet)) sprite-cells))))

(defmethod set-damage-motion-left ((player-sprite-sheet player-sprite-sheet))
  (with-slots (filename w h cell sprite-sheet) player-sprite-sheet
    (let ((sprite-cells (generate-sprite-cells player-sprite-sheet "damage-motion-left")))
      (setf (sdl:cells (gethash "damage-motion-left" sprite-sheet)) sprite-cells))))

(defmethod set-damage-motion-right ((player-sprite-sheet player-sprite-sheet))
  (with-slots (filename w h cells sprite-sheet) player-sprite-sheet
    (let ((sprite-cells (generate-sprite-cells player-sprite-sheet "damage-motion-right")))
      (setf (sdl:cells (gethash "damage-motion-right" sprite-sheet)) sprite-cells))))

(defmethod set-down-motion-left ((player-sprite-sheet player-sprite-sheet))
  (with-slots (filename w h cells sprite-sheet) player-sprite-sheet
    (let ((sprite-cells (generate-sprite-cells player-sprite-sheet "down-motion-left")))
      (setf (sdl:cells (gethash "down-motion-left" sprite-sheet)) sprite-cells))))

(defmethod set-down-motion-right ((player-sprite-sheet player-sprite-sheet))
  (with-slots (filename w h cells sprite-sheet) player-sprite-sheet
    (let ((sprite-cells (generate-sprite-cells player-sprite-sheet "down-motion-right")))
      (setf (sdl:cells (gethash "down-motion-right" sprite-sheet)) sprite-cells))))  

(defmethod generate-sprite-sheet ((player-sprite-sheet player-sprite-sheet))
  (set-standing-left player-sprite-sheet)
  (set-standing-right player-sprite-sheet)
  (set-running-left player-sprite-sheet)
  (set-running-right player-sprite-sheet)
  (set-jumping-left player-sprite-sheet)
  (set-jumping-right player-sprite-sheet)
  (set-damage-motion-left player-sprite-sheet)
  (set-damage-motion-right player-sprite-sheet)
  (set-down-motion-left player-sprite-sheet)
  (set-down-motion-right player-sprite-sheet))

(defmethod set-duration ((player-sprite-sheet player-sprite-sheet))
  (with-slots (duration) player-sprite-sheet
    (setf (gethash "standing-left" duration) 7)
    (setf (gethash "standing-right" duration) 7)
    (setf (gethash "running-left" duration) 4)
    (setf (gethash "running-right" duration) 4)
    (setf (gethash "jumping-left" duration) 4)
    (setf (gethash "jumping-right" duration) 4)
    (setf (gethash "damage-motion-left" duration) 4)
    (setf (gethash "damage-motion-right" duration) 4)
    (setf (gethash "down-motion-left" duration) 4)
    (setf (gethash "down-motion-right" duration) 4)))

(defmethod initialize-instance :after ((player-sprite-sheet  player-sprite-sheet) &rest initargs)
  (set-filename player-sprite-sheet)
  (load-image player-sprite-sheet)
  (generate-sprite-sheet player-sprite-sheet)
  (set-duration player-sprite-sheet))
