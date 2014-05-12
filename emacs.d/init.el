;; EMACS init file

;; ===============================================================
;; Basic configuration
;; ===============================================================
;; Turn off bars, etc.
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-screen t)
;; Start from scratch buffer
(setq initial-buffer-choice t)
(setq initial-scratch-message "")
;; disable backup / auto save
(setq backup-inhibited t)
(setq auto-save-default nil)
;; Theming
(load-theme 'wombat t)
(set-face-attribute 'default nil :font "Source Code Pro-14")
(column-number-mode t)
;; Auto refresh buffers
(global-auto-revert-mode 1)
(setq auto-revert-verbose nil)
;; Destroy some annoying things
(setq vc-follow-symlinks t)
(setq confirm-nonexistent-file-or-buffer nil)
;; Remove text in active region if inserting text
(delete-selection-mode 1)
;; Enable auto-fill-mode
(set-fill-column 79)
(auto-fill-mode t)
;; Enable IDO mode
(ido-mode t)

;; ===============================================================
;; Packages
;; ===============================================================
(require 'package)
(setq package-user-dir "~/.emacs.d/packages/")
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/")
  '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
(require 'cl)
;; Package list
(defvar packages-list
  '(rainbow-delimiters
    haskell-mode
    clojure-mode
    cursor-chg
    highlight-indentation
    highlight-symbol
    smart-mode-line
    pkgbuild-mode
    undo-tree
    magit
    smartparens))
(defun has-package-not-installed ()
  (loop for p in packages-list
        when (not (package-installed-p p)) do (return t)
        finally (return nil)))
(when (has-package-not-installed)
  ;; Check for new packages (package versions)
  (message "%s" "Get latest versions of all packages...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; Install the missing packages
  (dolist (p packages-list)
    (when (not (package-installed-p p))
      (package-install p))))

;; Macro to evaluate package configuration after it is loaded
(defmacro after (mode &rest body)
  "`eval-after-load' MODE evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,mode
     '(progn ,@body)))

;; SMART MODE LINE 
(after 'smart-mode-line-autoloads
  (require 'smart-mode-line)
  (setq sml/theme 'dark)
  (add-hook 'after-init-hook 'sml/setup)
  (add-to-list 'sml/replacer-regexp-list '("^:PRJ:aur/" ":AUR:"))
  (add-to-list 'sml/replacer-regexp-list '("^:PRJ:euler/" ":EULER:"))
  (add-to-list 'sml/replacer-regexp-list '("^~/Projects/" ":PRJ:"))
  (add-to-list 'sml/replacer-regexp-list '("^~/Work/" ":WRK:")))

;; SMARTPARENS + RAINBOW DELIMITERS
(after 'smartparens-autoloads
  (smartparens-global-mode t)
  (show-smartparens-global-mode t))
(after 'rainbow-delimiters-autoloads
  (require 'rainbow-delimiters)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  (require 'color)
  (cl-loop 
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
     (cl-callf color-saturate-name (face-foreground face) 30)))
  (require 'paren) ; show-paren-mismatch is defined in paren.el
  (set-face-attribute 'rainbow-delimiters-unmatched-face nil
		      :foreground 'unspecified
		      :inherit 'show-paren-mismatch))

;; HASKELL
(after 'haskell-mode-autoloads
  (setq haskell-stylish-on-save t
	haskell-font-lock-symbols t)
  (defun hs-hook ()
    (turn-on-haskell-doc-mode)
    (turn-on-haskell-indentation)
    (font-lock-mode)
    (set-input-method "haskell-unicode")
    (define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
    (define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)
    (define-key haskell-mode-map (kbd "C-x C-s") 'haskell-mode-save-buffer))
  (add-hook 'haskell-mode-hook 'hs-hook))
