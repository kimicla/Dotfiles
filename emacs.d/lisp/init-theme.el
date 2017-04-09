(load-theme 'ample t t)
(load-theme 'ample-flat t t)
(load-theme 'ample-light t t)
(load-theme 'solarized t t)

;;; Theme configuration for solarized

;; (add-hook 'after-make-frame-functions
;; 	  (lambda (frame)
;; 	    (let ((mode (if (display-graphic-p frame) 'light 'dark)))
;; 	      (set-frame-parameter frame 'background-mode mode)
;; 	      (set-terminal-parameter frame 'background-mode mode))
;; 	    (enable-theme 'solarized)))

(require 'moe-theme)
(moe-dark)


(provide 'init-theme)
