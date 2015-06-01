(in-package :game)

(defclass blocks-sprite-sheet ()
  ((filename
    :initform (make-hash-table :test #'equal))
   (w
    :initform 40)
   (h
    :initform 40)
   (sprite-sheet
    :reader sprite-sheet
    :initform (make-hash-table :test #'equal))
   (cells
    :reader cells
    :initform (make-instance 'blocks-cells))
   (duration
    :reader duration
    :initform 0)
   (id
    :accessor id
    :initform 0
    :initarg :id)))

(defmethod set-filename ((blocks-sprite-sheet blocks-sprite-sheet))
  (with-slots (filename) blocks-sprite-sheet
    (setf (gethash "blocks1" filename) "../pixel_animation/test1.png")))

(defmethod load-image ((blocks-sprite-sheet blocks-sprite-sheet))
  (with-slots (sprite-sheet filename) blocks-sprite-sheet
    (setf (gethash "blocks1" sprite-sheet) (sdl:load-image (gethash "blocks1" filename) :color-key sdl:*black*))))

(defmacro sprite-cells2 (w h string cells)
  "return list"
  `(loop for y from 0 to (funcall #'y-cells ,cells) by ,h
      append (loop for x from 0 to (funcall #'* ,w (funcall #'gethash ,string (funcall #'x-cells ,cells))) by ,w collect (list x y ,w ,h))))

(defmethod set-blocks1 ((blocks-sprite-sheet blocks-sprite-sheet))
  (with-slots (w h cells sprite-sheet) blocks-sprite-sheet
    (let ((sprite-cells (sprite-cells2 w h "blocks1" cells)))
      (setf (sdl:cells (gethash "blocks1" sprite-sheet)) sprite-cells))))

(defmethod generate-sprite-sheet ((blocks-sprite-sheet blocks-sprite-sheet))
  (with-slots (sprite-sheet) blocks-sprite-sheet
    (set-blocks1 blocks-sprite-sheet)))

(defmethod initialize-instance :after ((blocks-sprite-sheet blocks-sprite-sheet) &rest initargs)
  (set-filename blocks-sprite-sheet)
  (load-image blocks-sprite-sheet)
  (generate-sprite-sheet blocks-sprite-sheet))
    
