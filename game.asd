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
			((:file "package")
			 (:file "util")
			 (:file "key-state")
			 (:file "load-csv")
			 (:file "sprite-sheet-class" :depends-on ("util"))
			 (:file "player-class" :depends-on ("util"))
			 (:file "block-class" :depends-on ("util"))
			 (:file "collision" :depends-on ("util"))
			 (:file "gravity" :depends-on ("util"))
			 (:file "load-json")
			 (:file "piyo-class" :depends-on ("util"))
			 (:file "main" :depends-on ("util"
						    "key-state"
						    "load-csv"
						    "collision"
						    "gravity"
						    "load-json"))))))

				
				
				
  
