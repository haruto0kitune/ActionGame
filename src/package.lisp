(in-package :cl-user)

(defpackage load-json
  (:use :cl)
  (:export :load-json))

(defpackage load-csv
  (:use :cl)
  (:export :load-csv))

(defpackage key-state
  (:use :cl)
  (:export :key-state :defkeystate :update-key-state))

(defpackage collision
  (:use :cl)
  (:export :collide :bottom-collide))

(defpackage gravity
  (:use :cl)
  (:export generate-free-fall))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (find-package :game)    
    (defpackage game
      (:use :cl :key-state)
      (:import-from :util)
      (:import-from :key-state
		    :key-state
		    :update-key-state
		    :defkeystate)
      (:import-from :load-csv
		    :load-csv)
      (:import-from :load-json
		    :load-json)
      (:export :main))))
