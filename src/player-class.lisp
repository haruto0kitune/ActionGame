;;;;
;;;; player class
;;;;

(in-package :cl-user)
(defpackage player-class
  (:use :cl)
  (:import-from :sprite-sheet-class)
  (:export :player
	   :hp
	   :filename
	   :collision-x
	   :collision-y
	   :collision-width
	   :collision-height
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
	   :current-cell
	   :standing-left-current-cell
	   :standing-right-current-cell
	   :running-left-current-cell
	   :running-right-current-cell
	   :jumping-left-current-cell
	   :jumping-right-current-cell
	   :fox-girl-damage-motion1-left-current-cell
	   :fox-girl-damage-motion1-right-current-cell
	   :fox-girl-down-motion-left-current-cell
	   :fox-girl-down-motion-right-current-cell
	   :duration
	   :frame-counter
	   :cx-minus-px
	   :cy-minux-py
	   :direction
	   :jump-power
	   :action-name
	   :var-jump
	   :draw-flag
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
	   :running-left
	   :running-right
	   :jumping-left
	   :jumping-right
	   :crouching-left
	   :crouching-right
	   :atemi1-left
	   :atemi1-right
	   :fox-girl-damage-motion1-left
	   :fox-girl-damage-motion1-right
	   :fox-girl-down-motion-left
	   :fox-girl-down-motion-right))
(in-package :player-class)

;(load "sprite-sheet-class.lisp" :external-format :utf-8)

(defclass player ()
  ((hp
    :initform 1
    :initarg :hp)
   (filename
    :documentation "hash table"
    :accessor image-object-filename
    :initform nil
    :initarg :filename)
   (collision-x
    :accessor image-object-collision-x
    :initform 0)
   (collision-y
    :accessor image-object-collision-y
    :initform 0)
   (collision-width
    :initform 39)
   (collision-height
    :initform 113)
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
    :initform 10)
   (velocity-y
    :initform 10)
   (width
    :initform 128)
   (height
    :initform 128)
   (x-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-x-cell-count
    :initform (make-hash-table :test #'equal)
    :initarg :x-cell-count)
   (y-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-y-cell-count
    :initform 0
    :initarg :y-cell-count)
   (total-cell-count
    :documentation "take 1 from actual number"
    :accessor image-object-total-cell-count
    :initform (make-hash-table :test #'equal)
    :initarg :total-cell-count)
   (current-cell
    :accessor image-object-current-cell
    :initform 0
    :initarg :current-cell)
   (standing-left-current-cell
    :accessor image-object-standing-left-current-cell
    :initform 0)
   (standing-right-current-cell
    :accessor image-object-standing-right-current-cell
    :initform 0)
   (running-left-current-cell
    :accessor image-object-running-left-current-cell
    :initform 0)
   (running-right-current-cell
    :accessor image-object-running-right-current-cell
    :initform 0)
   (jumping-left-current-cell
    :accessor image-object-jumping-left-current-cell
    :initform 0)
   (jumping-right-current-cell
    :accessor image-object-jumping-right-current-cell
    :initform 0)
   (fox-girl-damage-motion1-left-current-cell
    :accessor image-object-fox-girl-damage-motion1-left-current-cell
    :initform 0)
   (fox-girl-damage-motion1-right-current-cell
    :accessor image-object-fox-girl-damage-motion1-right-current-cell
    :initform 0)
   (fox-girl-down-motion-left-current-cell
    :accessor image-object-fox-girl-down-motion-left-current-cell
    :initform 0)
   (fox-girl-down-motion-right-current-cell
    :accessor image-object-fox-girl-down-motion-right-current-cell
    :initform 0)
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
    :initform 20)
   (action-name
    :initform "standing-left")
   (var-jump
    :initform nil)
   (draw-flag
    :accessor image-object-draw-flag
    :initform t)
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
    :initform nil)
   (standing-right
    :documentation "sprite-sheet"
    :initform nil)
   (walking-left
    :documentation "sprite-sheet"
    :initform nil)
   (walking-right
    :documentation "sprite-sheet"
    :initform nil)
   (running-left
    :documentation "sprite-sheet"
    :initform nil)
   (running-right
    :documentation "sprite-sheet"
    :initform nil)
   (jumping-left
    :documentation "sprite-sheet"
    :initform nil)
   (jumping-right
    :documentation "sprite-sheet"
    :initform nil)
   (crouching-left
    :documentation "sprite-sheet"
    :initform nil)
   (crouching-right
    :documentation "sprite-sheet"
    :initform nil)
   (atemi1-left
    :documentation "sprite-sheet"
    :initform nil)
   (atemi1-right
    :documentation "sprite-sheet"
    :initform nil)
   (fox-girl-damage-motion1-left
    :documentation "sprite-sheet"
    :initform nil)
   (fox-girl-damage-motion1-right
    :accessor image-object-fox-girl-damage-motion1-right
    :initform nil)
   (fox-girl-down-motion-left
    :documentation "sprite-sheet"
    :initform nil)
   (fox-girl-down-motion-right
    :documentation "sprite-sheet"
    :initform nil)))
