(helm-mode 1)

(global-set-key (kbd "M-m") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; (helm-projectile-on)
;; (global-set-key (kbd "M-m p f") 'helm-projectile-recentf)
;; (global-set-key (kbd "M-m p p") 'helm-projectile-switch-project)
;; (global-set-key (kbd "M-m p g") 'magit-status)

(provide 'init-helm)
