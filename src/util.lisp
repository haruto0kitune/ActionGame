(in-package :cl-user)
(defpackage util
  (:use :cl)
  (:export :-= :+=))
(in-package util)

(defmacro -= (n1 n2)
  `(setf ,n1 (- ,n1 ,n2)))

(defmacro += (n1 n2)
  `(setf ,n1 (+ ,n1 ,n2)))
