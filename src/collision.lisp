;;;; in  → object instance 1, object instance 2
;;;; out → t or nil
;;;;
;;;; data
;;;;
;;;; x → image object position x
;;;; y → image object position y
;;;; w → image object width
;;;; h → image object height
;;;; cpx → central point x → (x + w) / 2
;;;; cpy → central point y → (y + h) / 2
;;;; hw → half of width
;;;; hh → half of height
;;;; lx → length x
;;;; ly → length y
;;;; dx → distance x
;;;; dy → distance y
;;;; top → cpy - hh
;;;; bottom → cpy + hh
;;;; left → cpx - hw
;;;; right → cpx + hw

(in-package :game)

(defun collide (instance1 instance2)
  "Type of instance is image object"
  (let* ((c-x1 (image-object-collision-x instance1))
	 (c-y1 (image-object-collision-y instance1))
	 (c-w1 (image-object-collision-width instance1))
	 (c-h1 (image-object-collision-height instance1))
	 (c-hw1 (/ c-w1 2))
	 (c-hh1 (/ c-h1 2))
	 (c-cpx1 (+ c-x1 c-hw1))
	 (c-cpy1 (+ c-y1 c-hh1))
	 (c-x2 (image-object-collision-x instance2))
	 (c-y2 (image-object-collision-y instance2))
	 (c-w2 (image-object-collision-width instance2))
	 (c-h2 (image-object-collision-height instance2))
	 (c-hw2 (/ c-w2 2))
	 (c-hh2 (/ c-h2 2))
	 (c-cpx2 (+ c-x2 c-hw2))
	 (c-cpy2 (+ c-y2 c-hh2))
	 (c-lx (- c-cpx2 c-cpx1))
	 (c-ly (- c-cpy2 c-cpy1))
	 (c-dx (- (- c-lx c-cpx1) c-cpx2))
	 (c-dy (- (- c-ly c-cpy1) c-cpy2))
	 (c-top1 (- c-cpy1 c-hh1))
	 (c-bottom1 (+ c-cpy1 c-hh1))
	 (c-left1 (- c-cpx1 c-hw1))
	 (c-right1 (+ c-cpx1 c-hw1))
	 (c-top2 (- c-cpy2 c-hh2))
	 (c-bottom2 (+ c-cpy2 c-hh2))
	 (c-left2 (- c-cpx2 c-hw2))
	 (c-right2 (+ c-cpx2 c-hw2))
	 (x1 (image-object-position-x instance1))
	 (y1 (image-object-position-y instance1))
	 (w1 (image-object-width instance1))
	 (h1 (image-object-height instance1))
	 (hw1 (/ w1 2))
	 (hh1 (/ h1 2))
	 (cpx1 (+ x1 hw1))
	 (cpy1 (+ y1 hh1))
	 (x2 (image-object-collision-x instance2))
	 (y2 (image-object-position-y instance2))
	 (w2 (image-object-width instance2))
	 (h2 (image-object-height instance2))
	 (hw2 (/ w2 2))
	 (hh2 (/ h2 2))
	 (cpx2 (+ x2 hw2))
	 (cpy2 (+ y2 hh2))
	 (lx (- cpx2 cpx1))
	 (ly (- cpy2 cpy1))
	 (dx (- (- lx cpx1) cpx2))
	 (dy (- (- ly cpy1) cpy2))
	 (top1 (- cpy1 hh1))
	 (bottom1 (+ cpy1 hh1))
	 (left1 (- cpx1 hw1))
	 (right1 (+ cpx1 hw1))
	 (top2 (- cpy2 hh2))
	 (bottom2 (+ cpy2 hh2))
	 (left2 (- cpx2 hw2))
	 (right2 (+ cpx2 hw2))
	 (bottom-collision-flag1 nil)
	 (collision-flag nil)
	 (top1-and-bottom2 nil))
    ;; if cpx2 < cpx1 and cpy2 < cpy1,
    ;; conversion cpx2 - cpx1 from cpx1 - cpx2
    ;; and cpy2 - cpy1 from cpy1 - cpy2.        
    (when (< lx 0)
      (setf lx (- cpx1 cpx2))
      (setf dx (- (- lx cpx2) cpx1)))
    (when (< ly 0)
      (setf ly (- cpy1 cpy2))
      (setf dy (- (- ly cpy2) cpy1)))
    (when (< c-lx 0)
      (setf c-lx (- c-cpx1 c-cpx2))
      (setf c-dx (- (- c-lx c-cpx2) c-cpx1)))
    (when (< c-ly 0)
      (setf c-ly (- c-cpy1 c-cpy2))
      (setf c-dy (- (- c-ly c-cpy2) c-cpy1)))
    ;; collision detection
    ;; top1 and bottom2
    (when (and (<= c-top1 c-bottom2)
	       (> c-top1 c-top2)
	       (< c-left1 c-right2)
	       (> c-right1 c-left2))
      (setf top1-and-bottom2 t)
      (funcall (image-object-var-jump instance1) t)
      (setf (image-object-jump-flag instance1) nil)
      (setf (image-object-collision-y instance1) c-bottom2)
      (setf (image-object-position-y instance1)
	    (- c-bottom2 (image-object-cy-minus-py instance1))))
    ;; bottom1 and top2
    (when (and (>= c-bottom1 c-top2)
	       (< c-bottom1 c-bottom2)
	       (< c-left1 c-right2)
	       (> c-right1 c-left2))
      (setf bottom-collision-flag1 t)
      (setf collision-flag t)
      (setf c-bottom1 c-top2)
      (setf (image-object-collision-y instance1) 
	    (- (- c-top2 c-hh1) c-hh1))
      (setf (image-object-position-y instance1)
	    (-
	     (-
	      (- c-top2 c-hh1)
	      c-hh1)
	     (image-object-cy-minus-py instance1))))
    ;;left1 and right2
;    (if (eq top1-and-bottom2 t)
    (when (and (< c-left1 c-right2)
	       (> c-left1 c-left2)
	       (<= c-top1 c-bottom2)
	       (> c-bottom1 c-top2))
      (setf collision-flag t)
      (when (not (eq top1-and-bottom2 t))
	(setf (image-object-left-collision-flag instance1) t)
	(setf (image-object-collision-x instance1) right2)
	(setf (image-object-position-x instance1)
	      (- right2 (image-object-cx-minus-px instance1)))))

	;; right1 and left2
;	(if (eq top1-and-bottom2 t)
    (when (and (> c-right1 c-left2)
	       (< c-right1 c-right2)
	       (<= c-top1 c-bottom2)
	       (> c-bottom1 c-top2))
      (setf collision-flag t)
      (when (not (eq top1-and-bottom2 t))
	(setf (image-object-right-collision-flag instance1) t)
	(setf (image-object-collision-x instance1)
	      (- (- c-left2 c-hw1) c-hw1))
	(setf (image-object-position-x instance1)
	      (- (- (- c-left2 c-hw1) c-hw1)
		 (image-object-cx-minus-px instance1)))))
    (return-from collide collision-flag)))

(defun bottom-collide (instance1 instance2)
  "bottom collision detection of instance1"
  (let* ((c-x1 (image-object-collision-x instance1))
	 (c-y1 (image-object-collision-y instance1))
	 (c-w1 (image-object-collision-width instance1))
	 (c-h1 (image-object-collision-height instance1))
	 (c-hw1 (/ c-w1 2))
	 (c-hh1 (/ c-h1 2))
	 (c-cpx1 (+ c-x1 c-hw1))
	 (c-cpy1 (+ c-y1 c-hh1))
	 (c-x2 (image-object-collision-x instance2))
	 (c-y2 (image-object-collision-y instance2))
	 (c-w2 (image-object-collision-width instance2))
	 (c-h2 (image-object-collision-height instance2))
	 (c-hw2 (/ c-w2 2))
	 (c-hh2 (/ c-h2 2))
	 (c-cpx2 (+ c-x2 c-hw2))
	 (c-cpy2 (+ c-y2 c-hh2))
	 (c-lx (- c-cpx2 c-cpx1))
	 (c-ly (- c-cpy2 c-cpy1))
	 (c-dx (- (- c-lx c-cpx1) c-cpx2))
	 (c-dy (- (- c-ly c-cpy1) c-cpy2))
	 (c-top1 (- c-cpy1 c-hh1))
	 (c-bottom1 (+ c-cpy1 c-hh1))
	 (c-left1 (- c-cpx1 c-hw1))
	 (c-right1 (+ c-cpx1 c-hw1))
	 (c-top2 (- c-cpy2 c-hh2))
	 (c-bottom2 (+ c-cpy2 c-hh2))
	 (c-left2 (- c-cpx2 c-hw2))
	 (c-right2 (+ c-cpx2 c-hw2))
	 (bottom-collision-flag1 nil)
	 (collision-flag nil))
    ;; if cpx2 < cpx1 and cpy2 < cpy1,
    ;; conversion cpx2 - cpx1 from cpx1 - cpx2
    ;; and cpy2 - cpy1 from cpy1 - cpy2.        
    (when (< c-lx 0)
      (setf c-lx (- c-cpx1 c-cpx2))
      (setf c-dx (- (- c-lx c-cpx2) c-cpx1)))
    (when (< c-ly 0)
      (setf c-ly (- c-cpy1 c-cpy2))
      (setf c-dy (- (- c-ly c-cpy2) c-cpy1)))
    ;; collision detection
    ;; bottom1 and top2
    (when (and (>= c-bottom1 c-top2)
	       (< c-bottom1 c-bottom2)
	       (< c-left1 c-right2)
	       (> c-right1 c-left2))
      t)))

(defstruct rect x y w h)   

(defun collision-of-rect-and-rect (rect1 rect2)
  "rect is struct"
  (if (and (<= (rect-x rect1) (+ (rect-x rect2) (rect-w rect2)))
	   (<= (rect-x rect2) (+ (rect-x rect1) (rect-w rect1)))
	   (<= (rect-y rect1) (+ (rect-y rect2) (rect-h rect2)))
	   (<= (rect-y rect2) (+ (rect-y rect1) (rect-h rect1))))
      (return-from collision-of-rect-and-rect t)
      (return-from collision-of-rect-and-rect nil)))
