(setq google-translate-translation-directions-alist
      '(("en" . "de") ("de" . "en") ("zh" . "en") ("en" . "zh")))

(global-set-key "\C-ct" 'google-translate-smooth-translate)
(global-set-key (kbd "C-c r") 'google-translate-at-point-reverse)
(global-set-key (kbd "C-c R") 'google-translate-query-translate-reverse)

(provide 'init-translate)
