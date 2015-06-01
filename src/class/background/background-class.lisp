(in-package :game)

(defclass background ()
  ((filename
    :initform "../pixel_animation/background.png")
   (image
    :initform (make-instance 'rect :x 0 :y 0 :w 800 :h 600))
   (sprite
    :initform nil)))

(defmethod initialize-instance :after ((background background) &rest initargs)
  (with-slots (filename sprite) background	       
    (setf sprite (sdl:load-image filename))))

(defmethod draw-sprite ((background background) x y)
  (with-slots (sprite) background
    (sdl:draw-surface-at-* sprite x y)))
	 

    
