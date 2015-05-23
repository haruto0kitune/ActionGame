;;;;
;;;; piyo class
;;;;

<<<<<<< HEAD
(in-package :cl-user)
(defpackage piyo-class
  (:use :cl)
  (:import-from :sprite-sheet-class)
  (:export :piyo
	   :hp
	   :filename
	   :collision-x
	   :collision-y
	   :collision-width
	   :collision-height
	   :attack-collision-x
	   :attack-collision-y
	   :attack-collision-width
	   :attack-collision-height
	   :damage-collision-x
	   :damage-collision-y
	   :damage-collision-width
	   :damage-collision-height
	   :position-x
	   :position-y
	   :velocity-x
	   :velocity-y
	   :width
	   :height
	   :x-cell-count
	   :y-cell-count
	   :total-cell-count
	   :sprite-sheet
	   :current-cell
	   :standing-left-current-cell
	   :standing-right-current-cell
	   :walking-left-current-cell
	   :walking-right-current-cell
	   :duration
	   :frame-counter
	   :cx-minus-px
	   :cy-minus-py
	   :direction
	   :jump-power
	   :action-name
	   :var-jump
	   :draw-flag
	   :jump-flag
	   :ground-flag
	   :air-flag
	   :top-collision-flag
	   :bottom-collision-flag
	   :left-collision-flag
	   :right-collision-flag
	   :standing-left
	   :standing-right
	   :walking-left
	   :walking-right
	   :jumping-left
	   :jumping-right
	   :attack1-left
	   :attack1-right))
(in-package :piyo-class)
=======
(in-package :game)
>>>>>>> hotfix

;(load "sprite-sheet-class.lisp" :external-format :utf-8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; collision-x = position-x + 9  ;;
;; collision-y = position-y + 13 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass piyo ()
  ((hp
    :documentation "hit point"
    :accessor image-object-hp
    :initform 1
    :initarg :hp)
   (filename
    :documentation "hash table"
    :accessor image-object-filename
    :initform nil
    :initarg :filename)
   (collision-x
    :accessor image-object-collision-x
    :initform 0
    :initarg :collision-x)
   (collision-y
    :accessor image-object-collision-y
    :initform 0
    :initarg :collision-y)
   (collision-width
    :accessor image-object-collision-width
    :initform 0
    :initarg :collision-width)
   (collision-height
    :accessor image-object-collision-height
    :initform 0
    :initarg :collision-height)
   (attack-collision-x
    :accessor image-object-attack-collision-x
    :initform 0
    :initarg :attack-collision-x)
   (attack-collision-y
    :accessor image-object-attack-collision-y
    :initform 0
    :initarg :attack-collision-y)
   (attack-collision-width
    :accessor image-object-attack-collision-width
    :initform 0
    :initarg :attack-collision-width)
   (attack-collision-height
    :accessor image-object-attack-collision-height
    :initform 0
    :initarg :attack-collision-height)
   (damage-collision-x
    :accessor image-object-damage-collision-x
    :initform 0
    :initarg :damage-collision-x)
   (damage-collision-y
    :accessor image-object-damage-collision-y
    :initform 0
    :initarg :damage-collision-y)
   (damage-collision-width
    :accessor image-object-damage-collision-width
    :initform 0
    :initarg :damage-collision-width)
   (damage-collision-height
    :accessor image-object-damage-collision-height
    :initform 0
    :initarg :damage-collision-height)
   (position-x
    :accessor image-object-position-x
    :initform 0
    :initarg :position-x)
   (position-y
    :accessor image-object-position-y
    :initform 0
    :initarg :position-y)
   (velocity-x
    :accessor image-object-velocity-x
    :initform 0
    :initarg :velocity-x)
   (velocity-y
    :accessor image-object-velocity-y
    :initform 0
    :initarg :velocity-y)
   (width
    :accessor image-object-width
    :initform 0
    :initarg :width)
   (height
    :accessor image-object-height
    :initform 0
    :initarg :height)
   (x-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-x-cell-count
    :initform 0
    :initarg :x-cell-count)
   (y-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-y-cell-count
    :initform 0
    :initarg :y-cell-count)
   (total-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-total-cell-count
    :initform 0
    :initarg :total-cell-count)
   (sprite-sheet
    :accessor image-object-sprite-sheet
    :initform nil
    :initarg :sprite-sheet)
   (current-cell
    :accessor image-object-current-cell
    :initform 0
    :initarg :current-cell)
   (standing-left-current-cell
    :accessor image-object-standing-left-current-cell
    :initform 0
    :initarg :standing-left-current-cell)
   (standing-right-current-cell
    :accessor image-object-standing-right-current-cell
    :initform 0
    :initarg :standing-right-current-cell)
   (walking-left-current-cell
    :accessor image-object-walking-left-current-cell
    :initform 0
    :initarg :walking-left-current-cell)
   (walking-right-current-cell
    :accessor image-object-walking-right-current-cell
    :initform 0
    :initarg :walking-right-current-cell)
   (duration
    :accessor image-object-duration
    :initform 0
    :initarg :duration)
   (frame-counter
    :initform 0)
   (cx-minus-px
    :documentation "position-x minus collision-x"
    :accessor image-object-cx-minus-px
    :initform 0)
   (cy-minus-py
    :documentation "position-y minus collision-y"
    :accessor image-object-cy-minus-py
    :initform 0)
   (direction
    :documentation "right or left"
    :accessor image-object-direction
    :initform nil
    :initarg :direction)
   (jump-power
    :accessor image-object-jump-power
    :initform 20
    :initarg :jump-power)
   (action-name
    :documentation "action flag"
    :accessor image-object-action-name
    :initform "piyo-standing-left"
    :initarg :action-name)
   (var-jump
    :accessor image-object-var-jump
    :initform nil)
   (draw-flag
    :accessor image-object-draw-flag
    :initform nil
    :initarg :draw-flag)
   (jump-flag
    :accessor image-object-jump-flag
    :initform nil)
   (ground-flag
    :accessor image-object-ground-flag
    :initform nil)
   (air-flag
    :accessor image-object-air-flag
    :initform nil)
   (top-collision-flag
    :accessor image-object-top-collision-flag
    :initform nil)
   (bottom-collision-flag
    :accessor image-object-bottom-collision-flag
    :initform nil)
   (left-collision-flag
    :accessor image-object-left-collision-flag
    :initform nil)
   (right-collision-flag
    :accessor image-object-right-collision-flag
    :initform nil)
   (standing-left
    :documentation "sprite-sheet"
    :accessor image-object-standing-left
    :initform nil
    :initarg :standing-left)
   (standing-right
    :documentation "sprite-sheet"
    :accessor image-object-standing-right
    :initform nil
    :initarg :standing-right)
   (walking-left
    :documentation "sprite-sheet"
    :accessor image-object-walking-left
    :initform nil
    :initarg :walking-left)
   (walking-right
    :documentation "sprite-sheet"
    :accessor image-object-walking-right
    :initform nil
    :initarg :walking-right)
   (jumping-left
    :documentation "sprite-sheet"
    :accessor image-object-jumping-left
    :initform nil
    :initarg :jumping-left)
   (jumping-right
    :documentation "sprite-sheet"
    :accessor image-object-jumping-right
    :initform nil
    :initarg :jumping-right)
   (attack1-left
    :documentation "sprite-sheet"
    :accessor image-object-attack1-left
    :initform nil
    :initarg :attack1-left)
   (attack1-right
    :documentation "sprite-sheet"
    :accessor image-object-attack1-right
    :initform nil
    :initarg :attack1-right)))
