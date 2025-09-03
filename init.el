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

;; C-x o kinda sucks
(use-package ace-window
  :bind (("M-o" . ace-window)))

;; Consider using AuCTeX in the future; don't feel like setting it up now

;; "A polished Dired with batteries included"
;;
;; I'm having trouble finding documentation and getting dirvish to
;; play nice with other windows
;; (use-package dirvish
;;   :config
;;   (dirvish-override-dired-mode))

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
  (load-theme 'doom-outrun-electric t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; IDE-like package for Python in Emacs
;;
;; Debugging isn't quite working; maybe I can contact the maintainer
(use-package elpy
  :init
  (elpy-enable))

;; gradle-mode isn't quite working for me...
;; (use-package gradle-mode
;;   :hook
;;   (java-mode . gradle-mode))

;; LSP support
;;
;; I had a mysterious failure to execute the entire init.el upon turning on
;; which-key integration (appears to be fixed now). The key was learning about
;; --debug-init and the *Warnings* buffer, without which diagnosing these
;; sorts of things becomes very difficult, and the distinctions between
;; different keyword arguments to use-package.
;;
;; Even so, for now I will disable lsp-mode and see how far I can go with
;; more basic packages.
;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")
;;   :config
;;   (lsp-enable-which-key-integration t)
;;   :hook (;; Replace XXX-mode with concrete major-mode (e.g. python-mode)
;;          (python-mode . lsp)))

;; magit, allegedly the best Git client in the (known) universe
(use-package magit
  :bind (("C-x g" . magit-status)))

;; markdown-mode
(use-package markdown-mode
  ;; Explanation of how the regular expression below works:
  ;; https://stackoverflow.com/questions/3494402/setting-auto-mode-alist-in-emacs
  :mode ("\\.md\\'" . gfm-mode)
  :init (setq markdown-command '("pandoc" "--from=markdown" "--to=html5"))
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do))
  :hook (markdown-mode . auto-fill-mode))

;; multi-vterm, self-explanatory
;;
;; M-x mu-t opens the "dedicated" terminal
(use-package multi-vterm
  :init (setq multi-vterm-dedicated-window-height-percent 30)
  :bind (:map vterm-mode-map
              ("C-c C-n" . multi-vterm-next)
              ("C-c C-p" . multi-vterm-prev)))

;; Needed for neotree, should I decide to start using it
(use-package nerd-icons)

;; For all those insidious silly parentheses
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; "Tree layout file explorer for Emacs"
(use-package treemacs
  ;; I had to do the below explicitly for some reason, so that it would work
  ;; with ace-window
  :bind (:map global-map
              ("M-0" . treemacs-select-window)))

;; The best terminal emulator for Emacs
(use-package vterm)

;; Enable system clipboard when in the terminal
(use-package xclip
  :config
  (xclip-mode t))

;; Everything Else

;; Regex incremental search should be the default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; hippie-expand is substantially better than dabbrev-expand
;;
;; Source: https://www.masteringemacs.org/article/text-expansion-hippie-expand
(global-set-key (kbd "M-/") 'hippie-expand)

;; Turn on both line and column numbering in the modline
(line-number-mode 1)
(column-number-mode 1)

;; Turn on line numbers globally
(global-display-line-numbers-mode t)

;; Remove clutter from the interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Remember location in previously visited files
(save-place-mode 1)

;; Remember minibuffer history
(savehist-mode t)

;; Translucent background so I can see what I'm reading underneath
(set-frame-parameter nil 'alpha-background 90)
(add-to-list 'default-frame-alist '(alpha-background . 90))

;; apropos-do-all enhances the apropos search
(setq apropos-do-all t)

;; Auto saves still exist but go into /tmp now
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Case doesn't matter for various types of completion
(setq completion-ignore-case t
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t)

;; No splash screen
(setq inhibit-startup-message t
      initial-scratch-message nil)

;; No tilde turds cluttering up the place
(setq make-backup-files nil)

;; Saves exiting clipboard text into kill ring before replacing it, which can
;; be retrieved with C-y M-y ... uh, just in case
(setq save-interprogram-paste-before-kill t)

;; No beeping
(setq visible-bell t)

;; Not sure I want to enable auto-fill-mode but this will make M-q effective
(setq-default fill-column 78)

;; Two space soft indent by default
(setq-default indent-tabs-mode nil
              tab-width 2)

;; Should be on by default but what the hell I'll make sure
(show-paren-mode 1)

;; Turn on which-key
(which-key-mode)
