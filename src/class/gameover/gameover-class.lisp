(in-package :game)

(defclass gameover ()
  ((image
    :initform (make-instance 'image :x 0 :y 0 :w 800 :h 600))
   (sprite
    :initform (sdl:load-image "../pixel_animation/gameover.png" :color-key sdl:*black*))))

(defmethod draw-sprite ((gameover gameover) x y)
  (with-slots (sprite image) gameover
    (sdl:draw-surface-at-* sprite (x image) (y image))))
   
