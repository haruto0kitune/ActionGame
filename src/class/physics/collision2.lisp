(in-package :game)



(defun detect-collision-of-line-segments (rect1 rect2)
  (when (and (= (y rect1) (y rect2))
	     (or (<= (x rect2) (x rect1) (+ (x rect2) (w rect2)))
		 (<= (x rect2) (x rect2) (+ (x rect2) (w rect2)))))
    t))
