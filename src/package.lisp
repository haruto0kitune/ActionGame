(in-package :cl-user)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (find-package :game)    
    (defpackage game
      (:use :cl)
      (:export :main))))
