
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
  (require 'init-git)
  (require 'init-ffip)
  (require 'init-ido)
  (require 'init-acejump)
  (require 'init-acewindow)
  (require 'init-sh)
  (require 'init-smex)
  )

(add-hook 'suspend-hook
	  (lambda () (or (y-or-n-p "Really suspend? ")
			 (error "Suspend canceled"))))
(add-hook 'suspend-resume-hook (lambda () (message "Resumed!")
				 (sit-for 2)))


(global-linum-mode 1)
