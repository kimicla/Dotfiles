(ido-mode 1)
;; (setq ffip-prefer-ido-mode t)
(autoload 'find-file-in-project "find-file-in-project" nil t)
(autoload 'find-file-in-project-by-selected "find-file-in-project" nil t)
(autoload 'find-directory-in-project-by-selected "find-file-in-project" nil t)
(autoload 'ffip-show-diff "find-file-in-project" nil t)
(autoload 'ffip-save-ivy-last "find-file-in-project" nil t)
(autoload 'ffip-ivy-resume "find-file-in-project" nil t)

(global-set-key (kbd "C-x f") 'find-file-in-project)

(provide 'init-ffip)
