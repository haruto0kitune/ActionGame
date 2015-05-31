(in-package :game)

(defclass blocks-sprite-sheet ()
  ((filename
    :initform "../pixel_animation/test1.png")
   (w
    :initform 40)
   (h
    :initform 40)
   (sprite-sheet
    :reader sprite-sheet
    :initform nil)
   (cells
    :reader cells
    :initform (make-instance 'blocks-cells))
   (duration
    :reader duration
    :initform 0)
   (id
    :accessor id
    :initform nil
    :initarg :id)))

(defmethod load-image ((blocks-sprite-sheet blocks-sprite-sheet))
  (with-slots (sprite-sheet filename) blocks-sprite-sheet
    (setf sprite-sheet (sdl:load-image filename :color-key sdl:*black*))))

(defmethod initialize-instance :after ((blocks-sprite-sheet blocks-sprite-sheet) &rest initargs)
  (load-image blocks-sprite-sheet))
    
