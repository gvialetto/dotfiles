;; -*- mode: Emacs-Lisp; folding-mode: t -*-
;; Simple EMACS init file
 
;; ===============================================================
;; Basic initialization
;; ===============================================================
;; enable marmalade repo
(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)
;; custom plugins/modes
(let ((default-directory "~/.emacs.d/plugins/"))
      (normal-top-level-add-to-load-path '("."))
      (normal-top-level-add-subdirs-to-load-path))
(let ((default-directory "~/.emacs.d/modes/"))
      (normal-top-level-add-to-load-path '("."))
      (normal-top-level-add-subdirs-to-load-path))
;; Start from scratch buffer
(setq initial-buffer-choice t)
(setq initial-scratch-message "")
;; IDO mode
(ido-mode t)

;; ===============================================================
;; Theming
;; ===============================================================
(load-theme 'wombat t)
(set-face-attribute 'default nil :font "Source Code Pro-14")

;; ===============================================================
;; Sanitize ENV
;; ===============================================================
;; disable backup / auto save
(setq backup-inhibited t)
(setq auto-save-default nil)
;; disable menubar, toolbar, scrollbars...
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; Auto refresh buffers
(global-auto-revert-mode 1)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
;; Destroy some annoying things
(setq vc-follow-symlinks t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)
;; Remove text in active region if inserting text
(delete-selection-mode 1)
;; Enable auto-fill-mode
(set-fill-column 79)
(auto-fill-mode t)

;; ===============================================================
;; Extensions
;; ===============================================================
;; Paredit - http://mumble.net/~campbell/emacs/paredit.el
(autoload 'enable-paredit-mode "paredit" t)
;; SML - https://github.com/Bruce-Connor/smart-mode-line
(require 'smart-mode-line)
(setq sml/theme 'dark)
(add-hook 'after-init-hook 'sml/setup)
(add-to-list 'sml/replacer-regexp-list '("^:PRJ:aur/" ":AUR:"))
(add-to-list 'sml/replacer-regexp-list '("^:PRJ:euler/" ":EULER:"))
(add-to-list 'sml/replacer-regexp-list '("^~/Projects/" ":PRJ:"))
(add-to-list 'sml/replacer-regexp-list '("^~/Work/" ":WRK:"))
;; SCHEME
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(require 'chicken)
;; PKGBUILD - https://github.com/gvialetto/pkgbuild-mode
(autoload 'pkgbuild-mode "pkgbuild-mode/pkgbuild-mode" "PKGBUILD" t)
(setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode)) auto-mode-alist))
;; HASKELL - https://github.com/haskell/haskell-mode
;; You will probably need to run 'make all' under the submodule directory
;; for this to work...
(setq haskell-stylish-on-save t
  haskell-font-lock-symbols t)
(require 'haskell-mode-autoloads)
(defun hs-hook ()
  (turn-on-haskell-doc-mode)
  (turn-on-haskell-indentation)
  (font-lock-mode)
  (set-input-method "haskell-unicode")
  (define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
  (define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)
  (define-key haskell-mode-map (kbd "C-x C-s") 'haskell-mode-save-buffer))
(add-hook 'haskell-mode-hook 'hs-hook)
;; RAINBOW DELIMITERS - http://www.emacswiki.org/emacs/RainbowDelimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;; CLOJURE - https://github.com/clojure-emacs/clojure-mode
(require 'clojure-mode)
(add-hook 'clojure-mode-hook 'enable-paredit-mode)
