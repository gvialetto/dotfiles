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
;; custom.d for custom libraries
(add-to-list 'load-path "~/.emacs.d/custom.d/")
(let ((default-directory "~/.emacs.d/custom.d/"))
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
;; Try to split vertically by default until things get ugly
;;(setq split-height-threshold nil)
;;(setq split-width-threshold 80)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
;; Destroy some annoying things
(setq vc-follow-symlinks t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))
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
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
;; SML - https://github.com/Bruce-Connor/smart-mode-line
(require 'smart-mode-line)
(add-hook 'after-init-hook 'sml/setup)
(add-to-list 'sml/replacer-regexp-list '("^:PRJ:aur/" ":AUR:"))
(add-to-list 'sml/replacer-regexp-list '("^:PRJ:euler/" ":EULER:"))
(add-to-list 'sml/replacer-regexp-list '("^~/projects/" ":PRJ:"))
(add-to-list 'sml/replacer-regexp-list '("^~/work/" ":WRK:"))
;; Quack - http://www.neilvandyke.org/quack/quack.el
;;(defun quack-hook ()
(setq quack-fontify-style 'emacs
    quack-default-program "csi"
    quack-newline-behavior 'newline
    quack-global-menu-p nil)
(require 'quack)
;;(add-hook 'scheme-mode-hook 'quack-hook)
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
