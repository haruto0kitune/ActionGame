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
			 (:file "sprite-sheet-class")
			 (:file "player-class")
			 (:file "block-class")
			 (:file "collision")
			 (:file "gravity")
			 (:file "load-json")
			 (:file "piyo-class")
			 (:file "main" :depends-on ("key-state"
						    "load-csv"
						    "sprite-sheet-class"
						    "player-class"
						    "block-class"
						    "collision"
						    "gravity"
						    "load-json"
						    "piyo-class"))))))

				
				
				
  
