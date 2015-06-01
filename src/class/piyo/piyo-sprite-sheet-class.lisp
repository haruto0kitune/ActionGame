(in-package :game)

(defclass piyo-sprite-sheet ()
  ((filename
    :initform (make-hash-table :test #'equal))
   (w
    :initform 64)
   (h
    :initform 64)
   (sprite-sheet
    :reader sprite-sheet
    :initform (make-hash-table :test #'equal))
   (cells
    :reader cells
    :initform (make-instance 'piyo-cells))
   (duration
    :reader duration
    :initform (make-hash-table :test #'equal))))

(defmethod set-filename ((piyo-sprite-sheet piyo-sprite-sheet))
  (with-slots (filename) piyo-sprite-sheet
    (setf (gethash "standing-left" filename) "../pixel_animation/enemy/enemy1_standing1_left.png")
    (setf (gethash "standing-right" filename) "../pixel_animation/enemy/enemy1_standing1_right.png")
    (setf (gethash "walking-left" filename) "../pixel_animation/enemy/enemy1_walk_left.png")
    (setf (gethash "walking-right" filename) "../pixel_animation/enemy/enemy1_walk_right.png")))

(defmethod load-image ((piyo-sprite-sheet piyo-sprite-sheet))
  (with-slots (sprite-sheet filename) piyo-sprite-sheet
    (setf (gethash "standing-left" sprite-sheet) (sdl:load-image (gethash "standing-left" filename) :color-key sdl:*black*))
    (setf (gethash "standing-right" sprite-sheet) (sdl:load-image (gethash "standing-right" filename) :color-key sdl:*black*))
    (setf (gethash "walking-left" sprite-sheet) (sdl:load-image (gethash "walking-left" filename) :color-key sdl:*black*))
    (setf (gethash "walking-right" sprite-sheet) (sdl:load-image (gethash "walking-right" filename) :color-key sdl:*black*))))

(defmacro sprite-cells2 (w h string cells)
  "return list"
  `(loop for y from 0 to (funcall #'y-cells ,cells) by ,h
       append (loop for x from 0 to (funcall #'* ,w (funcall #'gethash ,string (funcall #'x-cells ,cells))) by ,w collect (list x y ,w ,h))))

(defmethod set-standing-left ((piyo-sprite-sheet piyo-sprite-sheet))
  (with-slots (w h cells sprite-sheet) piyo-sprite-sheet
    (let ((sprite-cells (sprite-cells2 w h "standing-left" cells)))
      (setf (sdl:cells (gethash "standing-left" sprite-sheet)) sprite-cells))))

(defmethod set-standing-right ((piyo-sprite-sheet piyo-sprite-sheet))
  (with-slots (w h cells sprite-sheet) piyo-sprite-sheet
    (let ((sprite-cells (sprite-cells2 w h "standing-right" cells)))
      (setf (sdl:cells (gethash "standing-right" sprite-sheet)) sprite-cells))))

(defmethod set-walking-left ((piyo-sprite-sheet piyo-sprite-sheet))
  (with-slots (w h cells sprite-sheet) piyo-sprite-sheet
    (let ((sprite-cells (sprite-cells2 w h "walking-left" cells)))
      (setf (sdl:cells (gethash "walking-left" sprite-sheet)) sprite-cells))))

(defmethod set-walking-right ((piyo-sprite-sheet piyo-sprite-sheet))
  (with-slots (w h cells sprite-sheet) piyo-sprite-sheet
    (let ((sprite-cells (sprite-cells2 w h "walking-right" cells)))
      (setf (sdl:cells (gethash "walking-right" sprite-sheet)) sprite-cells))))

(defmethod generate-sprite-sheet ((piyo-sprite-sheet piyo-sprite-sheet))
  (set-standing-left piyo-sprite-sheet)
  (set-standing-right piyo-sprite-sheet)
  (set-walking-left piyo-sprite-sheet)
  (set-walking-right piyo-sprite-sheet))

(defmethod set-duration ((piyo-sprite-sheet piyo-sprite-sheet))
  (with-slots (duration) piyo-sprite-sheet
    (setf (gethash "standing-left" duration) 1)
    (setf (gethash "standing-right" duration) 1)
    (setf (gethash "walking-left" duration) 8)
    (setf (gethash "walking-right" duration) 8)))

(defmethod initialize-instance :after ((piyo-sprite-sheet  piyo-sprite-sheet) &rest initargs)
  (set-filename piyo-sprite-sheet)
  (load-image piyo-sprite-sheet)
  (generate-sprite-sheet piyo-sprite-sheet)
  (set-duration piyo-sprite-sheet))
