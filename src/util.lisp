(in-package :cl-user)
(defpackage util
  (:use :cl)
<<<<<<< HEAD
  (:export :+= :-=))
(in-package :util)
=======
  (:export :-= :+=))
(in-package util)
>>>>>>> hotfix

(defmacro -= (n1 n2)
  `(setf ,n1 (- ,n1 ,n2)))

(defmacro += (n1 n2)
  `(setf ,n1 (+ ,n1 ,n2)))
