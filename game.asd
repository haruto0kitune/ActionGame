;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(in-package :cl-user)
(defpackage game-asd
  (:use :cl :asdf))
(in-package :game-asd)

(defsystem game
  :version "0.1"
  :author "Sakurai Haruto"
  :components ((:module "src"
			:components
			((:file "util")
			 (:file "load-csv")
			 (:file "class")
;			 (:file "sprite-sheet-class")
;			 (:file "player-class" :depends-on ("sprite-sheet-class"))
;			 (:file "block-class")
			 (:file "collision" :depends-on ("class"
							 "util"))
			 (:file "gravity" :depends-on ("util"))
			 (:file "load-json")
;			 (:file "piyo-class" :depends-on ("sprite-sheet-class"))
			 (:file "generic-function" :depends-on ("class"
								"util"))
			 (:file "main" :depends-on ("util"
						    "class"
						    "generic-function"
						    "load-csv"
						    "collision"
						    "gravity"
						    "load-json"))))))
				
				
				
  
