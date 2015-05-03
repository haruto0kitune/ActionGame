(defun hello-2 ()
  (ltk:with-ltk ()
    (let* ((f (make-instance 'ltk:frame))
	   (canvas (ltk:make-canvas f :width 100 :height 100))
				    
				    
	   (b1 (make-instance 'ltk:button
			      :master f
			      :text "button 1"
			      :command (lambda () (format t "button1~&"))))
	   (b2 (make-instance 'ltk:button
			      :master f
			      :text "button 2"
			      :command (lambda () (format t "button2~&")))))
      (ltk:pack f)
      (ltk:pack canvas)
      (ltk:pack b1 :side :left)
      (ltk:pack b2 :side :left)
      (ltk:configure f :borderwidth 3)
      (ltk:configure f :relief :sunken))))
  

