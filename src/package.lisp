(in-package :cl-user)

(defpackage util
  (:use :cl)
  (:export :-=
	   :+=
	   :rect
	   :x
	   :y
	   :w
	   :h))

(defpackage load-json
  (:use :cl)
  (:export :load-json))

(defpackage load-csv
  (:use :cl)
  (:export :load-csv))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (find-package :game)    
    (defpackage game
      (:use :cl
	    :util)
      (:import-from :load-csv
		    :load-csv)
      (:import-from :load-json
		    :load-json)
      (:export :main))))
