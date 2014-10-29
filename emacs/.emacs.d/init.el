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
(cond (window-system (set-face-attribute 'default nil :font "Hermit-12")))
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
(ido-everywhere t)
;; Whitespace mode configuration
(setq whitespace-style '(spaces tabs space-mark tab-mark))
;; Delete trailing whitespace when saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; Run the garbage collector more sparingly
(setq gc-cons-threshold 20000000)

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
    better-defaults
    haskell-mode
    clojure-mode
    cursor-chg
    highlight-indentation
    highlight-symbol
    smart-mode-line
    pkgbuild-mode
    undo-tree
    magit
    smartparens
    ido-ubiquitous
    flx-ido
    multiple-cursors
    cider
    flycheck
    rust-mode))
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

;; SMART MODE LINE
(add-hook 'after-init-hook 'sml/setup)
(with-eval-after-load 'smart-mode-line
  (setq sml/theme 'dark)
  (add-to-list 'sml/replacer-regexp-list '("^:PRJ:aur/" ":AUR:"))
  (add-to-list 'sml/replacer-regexp-list '("^:PRJ:euler/" ":EULER:"))
  (add-to-list 'sml/replacer-regexp-list '("^~/Projects/" ":PRJ:"))
  (add-to-list 'sml/replacer-regexp-list '("^~/Work/" ":WRK:")))

;; SMARTPARENS + RAINBOW DELIMITERS
(with-eval-after-load 'smartparens
  (require 'smartparens-config)
  (smartparens-global-mode t)
  (show-smartparens-global-mode t)
  (sp-pair "(" ")" :wrap "M-(")
  (add-hook 'clojure-mode-hook 'smartparens-strict-mode)
  (add-hook 'cider-repl-mode-hook 'smartparens-strict-mode))
(with-eval-after-load 'rainbow-delimiters
  (require 'rainbow-delimiters)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  (require 'color)
  (loop for index
	from 1 to rainbow-delimiters-max-face-count
	do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
     (cl-callf color-saturate-name (face-foreground face) 30)))
  (require 'paren) ; show-paren-mismatch is defined in paren.el
  (set-face-attribute 'rainbow-delimiters-unmatched-face nil
		      :foreground 'unspecified
		      :inherit 'show-paren-mismatch))

;; HASKELL
(with-eval-after-load 'haskell-mode
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

;; FLEX IDO
(add-hook 'after-init-hook (lambda () (flx-ido-mode t)))
(with-eval-after-load 'flx-ido-mode
  (setq ido-use-faces nil))

;; RUST
(with-eval-after-load 'rust-mode
  (add-hook 'rust-mode-hook #'flycheck-mode))
