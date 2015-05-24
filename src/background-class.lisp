(in-package :game)

(defclass background ()
  ((filename
    :initform "../pixel_animation/background.png")
   (x
    :initform 0)
   (y
    :initform 0)
   (image
    :initform nil)))

(defmethod initialize-instance :after ((background background) &rest initargs)
  (with-slots (filename image) background	       
    (setf image (sdl:load-image filename))))

(defmethod draw-sprite ((background background))
  (with-slots (x y image) background
    (sdl:draw-surface-at-* image x y)))
	 

    
