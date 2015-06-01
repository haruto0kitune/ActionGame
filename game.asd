;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(in-package :cl-user)
(defpackage game-asd
  (:use :cl :asdf))
(in-package :game-asd)

(defsystem game
  :version "0.1"
  :author "Sakurai Haruto"
  :components ((:module "src"		
			:components ((:file "package")
				     (:file "utils")
				     (:file "class-utils")
				     (:module "class"					      
					      :components ((:module "background"
								    :components ((:file "background-class")))
							   (:module "block"
								    :components ((:file "block-flag-class")
										 (:file "block-cells-class")
										 (:file "block-class")
										 (:file "block-draw-class")
										 (:file "block-sprite-sheet-class")))
							   (:module "gameover"
								    :components ((:file "gameover-class")))
							   (:module "physics"
								    :components ((:file "collision")
										 (:file "gravity")))
							   (:module "piyo"
								    :components ((:file "piyo-flag-class")
										 (:file "piyo-cells-class")
										 (:file "piyo-class")
										 (:file "piyo-draw-class")
										 (:file "piyo-sprite-sheet-class")))
							   (:module "player"
								    :components ((:file "player-flag-class")
										 (:file "player-cells-class")
										 (:file "player-class")
										 (:file "player-draw-class")
										 (:file "player-sprite-sheet-class")))
							   (:module "stage"
								    :components ((:file "scroll-class")
										 (:file "stage-class")))
										 
							   (:module "system"
								    :components ((:file "key-state")
										 (:file "system-data-class")
										 (:file "system-flag-class")))))

			 (:file "main")))))

				
				
				
  
