;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

(setq *is-a-mac* (eq system-type 'darwin))
(setq *win64* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *emacs24* (and (not (featurep 'xemacs)) (or (>= emacs-major-version 24))) )
(setq *no-memory* (cond
		   (*is-a-mac*
		    (< (string-to-number (nth 1 (split-string (shell-command-to-string "sysctl hw.physmem")))) 4000000000))
		   (*linux* nil)
		   (t nil)))

(let ((file-name-handler-alist nil))
  (require 'init-site-lisp)
  (require 'init-elpa)
  (require 'init-exec-path)
  (require 'init-theme)
  (require 'init-helm)
  (require 'init-git)
  (require 'init-ffip)
  (require 'init-ido)
  (require 'init-acejump)
  (require 'init-acewindow)
  (require 'init-sh)
  (require 'init-smex)
  (require 'init-web-mode)
  )

;; auto-complete configuration
(ac-config-default)


;;(helm-projectile-on)

(add-hook 'suspend-hook
	  (lambda () (or (y-or-n-p "Really suspend? ")
			 (error "Suspend canceled"))))
(add-hook 'suspend-resume-hook (lambda () (message "Resumed!")
				 (sit-for 2)))


(global-linum-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm web-mode smex projectile powerline neotree moe-theme magit-gitflow idomenu ido-ubiquitous guide-key google-translate flx-ido find-file-in-project company color-theme-solarized browse-kill-ring auto-complete ample-theme ace-window ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
