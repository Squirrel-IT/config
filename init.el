

;; BASICS ------------------------------------------------------------------------------------------

;; define the file for customizations
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file))


;; Don't show the splash screen
(setq inhibit-startup-message t)  ; Comment at end of line!




;; PACKAGES ----------------------------------------------------------------------------------------

;; Define and initialise package repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)




;; GUI ---------------------------------------------------------------------------------------------
(tool-bar-mode -1)
(menu-bar-mode 1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)
(column-number-mode 1)

;; Font
(set-frame-font "Inconsolata 12" nil t)


;; Theming
;;(load-theme 'melancholy t)


;; MODULES -----------------------------------------------------------------------------------------
;; cider
(use-package cider)

;; paredit
(use-package paredit)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)

;; powerline
(use-package powerline)
(powerline-default-theme)


;; helm
(use-package helm
  :bind (("M-x" . helm-M-x)
         ("M-<f5>" . helm-find-files)
         ([f10] . helm-buffers-list)
         ([S-f10] . helm-recentf)))

(use-package helm-directory)
;;
;; (define-key global-map (kbd "C-c l") 'helm-directory)
;;(define-key global-map (kbd "C-c C-l") 'helm-directory)
;;;(setq helm-directory-basedir "~/src/github.com/projectA/")
;;(setq helm-directory-basedir-list '("~/src/github.com/projectA/" "~/src/github.com/projectB/" "~/Dropbox"))

;; rainbow delimeters
(use-package rainbow-delimiters)


