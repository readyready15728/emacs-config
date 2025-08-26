;; -*- lexical-binding: t; -*-

;; use-package Setup
;; Stolen from: https://ianyepan.github.io/posts/setting-up-use-package/
;; And from: https://sophiebos.io/posts/first-emacs-config/

(require 'package)

(setq package-archives
      '(("GNU ELPA" . "https://elpa.gnu.org/packages/")
	("MELPA" . "https://melpa.org/packages/")
	("ORG" . "https://orgmode.org/elpa/")
	("MELPA Stable" . "https://stable.melpa.org/packages/")
	("nongnu" . "https://elpa.nongnu.org/nongnu/"))
      package-archive-priorities
      '(("GNU ELPA" . 20)
	("MELPA" . 15)
	("ORG" . 10)
	("MELPA Stable" . 5)
	("nongnu" . 0)))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

;; use-package Statements

;; (use-package cyberpunk-theme
;;   :config
;;   (load-theme 'cyberpunk t))

;; Establishing doom-laserwave as the color theme along with ancillary
;; configuration
(use-package doom-themes
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
  :config
  (load-theme 'doom-laserwave t))

;; For all those insidious silly parentheses
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Enable system clipboard when in the terminal
(use-package xclip
  :config
  (xclip-mode t))

;; magit, allegedly the best Git client in the (known) universe
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;; Everything Else

;; No tilde turds cluttering up the place
(setq make-backup-files nil)
;; Auto saves still exist but go into /tmp now
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
;; Not sure I want to enable auto-fill-mode but this will make M-q effective
(setq-default fill-column 78)
;; No beeping
(setq visible-bell t)
;; Remember minibuffer history
(savehist-mode t)
;; Translucent background so I can see what I'm reading underneath
(set-frame-parameter nil 'alpha-background 90)
(add-to-list 'default-frame-alist '(alpha-background . 90))
;; Remove clutter from the interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; No splash screen
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
;; Turn on line numbers globally
(global-display-line-numbers-mode t)
;; Two space soft indent by default
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; Testing blah-blah-blah
