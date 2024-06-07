;;; packge --- Summary

;;; Commentary:
;;; Colten's Emacs config

;;; Code:

;; Update some UI
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Fonts
(set-face-attribute 'default nil
		    :font "JetBrainsMono Nerd Font"
		    :height 100
		    :weight 'medium)
(set-face-attribute 'variable-pitch nil
		    :font "JetBrainsMono Nerd Font"
		    :height 110
		    :weight 'medium)
(set-face-attribute 'fixed-pitch nil
		    :font "JetBrainsMono Nerd Font"
		    :height 110
		    :weight 'medium)

(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-10"))

(setq-default line-spacing 0.12)

;; line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(dolist (mode '(term-mode-hook
		eshell-mode-hook
		help-mode-hook
		vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; theme
(load-theme 'tango)

;; Changing bar
(setq-default cursor-type 't)

;; Turn of autosave
(setq auto-save-default nil)
(setq make-backup-files nil)

;; opacity
;; (set-frame-parameter nil 'alpha-background 95)

;; (add-to-list 'default-frame-alist '(alpha-background . 95))


;; gdb
(setq gdb-many-windows 1)

;; Package management
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

;; yasnippet
(use-package yasnippet
  :init (yas-global-mode 1))

;; vertico
(use-package vertico
  :init (vertico-mode 1))

;; Which-key
(use-package which-key
  :init (which-key-mode 1))

(use-package vterm
  :ensure t)

;; Treesitter
(use-package tree-sitter)
(use-package tree-sitter-langs)

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

;; Eglot
(use-package eglot
  :hook
  (c-mode . eglot-ensure)
  (c++-mode . eglot-ensure)
  (tuareg-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
  (add-to-list 'eglot-server-programs '((tuareg-mode) "ocamllsp")))

(keymap-global-set "C-c r" 'eglot-rename)
(keymap-global-set "C-c f" 'eglot-format-buffer)
(keymap-global-set "C-c d n" 'flymake-goto-next-error)
(keymap-global-set "C-c d p" 'flymake-goto-prev-error)

;; Company
(use-package company
  :hook
    (c-mode . company-mode)
    (c++-mode . company-mode)
    (tuareg-mode . company-mode))

(setq company-minimum-prefix-length 1
      company-idle-delay 0.0)

(use-package magit
  :config
  (global-set-key (kbd "C-c g") 'magit))

;; windmove
(use-package windmove
  :config
  (windmove-default-keybindings)
  (setq windmove-wrap-around t))

;; ocaml
(use-package tuareg
  :ensure t)

;; keybinds
(keymap-global-set "C-c C-u" 'uncomment-region)
(keymap-global-set "C-c e" 'eval-buffer)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("93011fe35859772a6766df8a4be817add8bfe105246173206478a0706f88b33d" default))
 '(package-selected-packages
   '(yasnippet which-key vterm vertico tuareg tree-sitter-langs magit company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
