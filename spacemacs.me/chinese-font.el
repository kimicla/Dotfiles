(defun kimi-font-existsp (font)
  (if (null (x-list-fonts font))
      nil
    t))

(defvar font-list '("STFangsong" "Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))

(require 'cl) ;; find-if is in common list package
(find-if #'kimi-font-existsp font-list)

(defun kimi-make-font-string (font-name font-size)
  (if (and (stringp font-size)
           (equal ":" (string (elt font-size 0))))
      (format "%s%s" font-name font-size)
    (format "%s %s" font-name font-size)))

(defun kimi-set-font (english-fonts
                      english-font-size
                      chinese-fonts
                      &optional chinese-font-size)

  "english-font-size could be set to \":pixelsize=18\" or a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
  (require 'cl) ; for find if
  (let ((en-font (kimi-make-font-string
                  (find-if #'kimi-font-existsp english-fonts)
                  english-font-size))
        (zh-font (font-spec :family (find-if #'kimi-font-existsp chinese-fonts)
                            :size chinese-font-size)))

    ;; Set the default English font
    ;;
    ;; The following 2 method cannot make the font settig work in new frames.
    ;; (set-default-font "Consolas:pixelsize=18")
    ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
    ;; We have to use set-face-attribute
    (message "Set English Font to %s" en-font)
    (set-face-attribute 'default nil :font en-font)

    ;; Set Chinese font
    ;; Do not use 'unicode charset, it will cause the English font setting invalid
    (message "Set Chinese Font to %s" zh-font)
    (setq face-font-rescale-alist '((zh-font . 1.2)))
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset zh-font))))

(kimi-set-font
 '("Consolas" "Monaco" "DejaVu Sans Mono" "Monospace" "Courier New") ":pixelsize=14"
 '("STFangsong" "Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))

(global-set-key (kbd "<s-up>") 'text-scale-increase)
(global-set-key (kbd "<s-down>") 'text-scale-decrease)


(provide 'chinese-font)
