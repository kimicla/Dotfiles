(require 'package)

(defvar melpa-use-https-repo nil
    "By default, HTTP is used to download packages.
But you may use safer HTTPS instead.")

(if melpa-use-https-repo
    (setq package-archives
	  '(;; uncomment below line if you need use GNU ELPA
	    ("gnu" . "http://elpa.gnu.org/packages/")
	    ("melpa" . "http://melpa.org/packages/")
	    ("melpa-stable" . "http://stable.melpa.org/packages/")))
  (setq package-archives
	'(;; uncomment below line if you need use GNU ELPA
	  ("gnu" . "https://elpa.gnu.org/packages/")
	  ("melpa" . "https://melpa.org/packages/")
	  ("melpa-stable" . "https://stable.melpa.org/packages/"))))


;; List of VISIBLE packages from melpa-unstable (http://melpa.org)
;; Feel free to add more packages!
(defvar melpa-include-packages
  '(bbdb
    color-theme
    wgrep
    robe
    groovy-mode
    inf-ruby
    simple-httpd
    dsvn
    move-text
    string-edit ; looks magnars don't update stable tag frequently
    findr
    mwe-log-commands
    yaml-mode
    noflet
    db
    creole
    web
    sass-mode
    idomenu
    pointback
    buffer-move
    regex-tool
    quack
    legalese
    htmlize
    scratch
    session
    crontab-mode
    bookmark+
    flymake-lua
    multi-term
    dired+
    inflections
    dropdown-list
    lua-mode
    tidy
    pomodoro
    auto-compile
    packed
    gitconfig-mode
    textile-mode
    w3m
    erlang
    company-c-headers
    ;; make all the color theme packages available
    afternoon-theme
    define-word
    ahungry-theme
    alect-themes
    ample-theme
    ample-zen-theme
    anti-zenburn-theme
    atom-dark-theme
    badger-theme
    base16-theme
    basic-theme
    birds-of-paradise-plus-theme
    workgroups2
    bliss-theme
    boron-theme
    bubbleberry-theme
    busybee-theme
    calmer-forest-theme
    cherry-blossom-theme
    clues-theme
    colonoscopy-theme
    color-theme-approximate
    color-theme-buffer-local
    color-theme-sanityinc-solarized
    color-theme-sanityinc-tomorrow
    color-theme-solarized
    colorsarenice-theme
    cyberpunk-theme
    dakrone-theme
    darcula-theme
    dark-krystal-theme
    darkburn-theme
    darkmine-theme
    display-theme
    distinguished-theme
    django-theme
    espresso-theme
    firebelly-theme
    firecode-theme
    flatland-black-theme
    pythonic
    flatland-theme
    flatui-theme
    gandalf-theme
    gotham-theme
    grandshell-theme
    gruber-darker-theme
    gruvbox-theme
    hc-zenburn-theme
    hemisu-theme
    heroku-theme
    google-translate
    helm
    )
  "Don't install any Melpa packages except these packages")


;;------------------------------------------------------------------------------
;; Internal implementation, newbies should NOT touch code below this line!
;;------------------------------------------------------------------------------

;; Patch up annoying package.el quirks
(defadvice package-generate-autoloads (after close-autoloads (name pkg-dir) activate)
  "Stop package.el from leaving open autoload files lying around."
  (let ((path (expand-file-name (concat
				 ;; name is string when emacs <= 24.3.1,
				 (if (symbolp name) (symbol-name name) name)
				 "-autoloads.el") pkg-dir)))
    (with-current-buffer (find-file-existing path)
      (kill-buffer nil))))

;; Add support to package.el for pre-filtering available packages
(defvar package-filter-function nil
    "Optional predicate function used to internally filter packages used by package.el.
The function is called with the arguments PACKAGE VERSION ARCHIVE, where
PACKAGE is a symbol, VERSION is a vector as produced by `version-to-list', and
ARCHIVE is the string name of the package archive.")

(defadvice package--add-to-archive-contents
    (around filter-packages (package archive) activate)
  "Add filtering of available packages using `package-filter-function', if non-nil."
  (when (or (null package-filter-function)
	    (funcall package-filter-function
		     (car package)
		     (funcall (if (fboundp 'package-desc-version)
				  'package--ac-desc-version
				'package-desc-vers)
			      (cdr package))
		     archive))
    ad-do-it))

;; On-demand installation of packages
(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
	(package-install package)
      (progn
	(package-refresh-contents)
	(require-package package min-version t)))))

;; Don't take Melpa versions of certain packages
(setq package-filter-function
      (lambda (package version archive)
	(and
	 (not (memq package '(eieio)))
	 (or (and (string-equal archive "melpa") (memq package melpa-include-packages))
	     (not (string-equal archive "melpa")))
	 )))

;; un-comment below code if you prefer use all the package on melpa (unstable) without limitation
(setq package-filter-function nil)

;;------------------------------------------------------------------------------
;; Fire up package.el and ensure the following packages are installed.
;;------------------------------------------------------------------------------

(package-initialize)

(require-package 'ample-theme)
(require-package 'color-theme-solarized)
(require-package 'powerline)
(require-package 'moe-theme)

(require-package 'dash)
(require-package 'auto-complete)
(require-package 'company)
(require-package 'find-file-in-project)
(require-package 'projectile)
(require-package 'neotree)
(require-package 'idomenu)
(require-package 'ido-ubiquitous)
(require-package 'flx-ido)
(require-package 'ace-jump-mode)
(require-package 'ace-window)
(require-package 'magit)
(require-package 'magit-gitflow)
(require-package 'smex)
(require-package 'browse-kill-ring)
(require-package 'guide-key)
(require-package 'web-mode)
(require-package 'helm)


;; Clojure
;; (require-package 'cider)

(provide 'init-elpa)
