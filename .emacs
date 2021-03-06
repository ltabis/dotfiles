;; Ltabis's emacs configuration.

;; TODO: - add some of vscode usefull keybindings.
;;       - add a ui workspace / file manager.
;;       - run mode files only when modes are loaded.
;;       - setup multilines key bindings.

;; install melpa to get nice packages.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; load 'use-package' package, funny.
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

;; removes the menu & tool bars.
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(show-paren-mode 1)

;; add line numbers
(global-display-line-numbers-mode 1)

;; removes the startup screen.
(setq inhibit-startup-screen t)

;; pain.
(global-unset-key (kbd "<left>"))
(global-unset-key (kbd "<right>"))
(global-unset-key (kbd "<up>"))
(global-unset-key (kbd "<down>"))
(global-unset-key (kbd "<C-left>"))
(global-unset-key (kbd "<C-right>"))
(global-unset-key (kbd "<C-up>"))
(global-unset-key (kbd "<C-down>"))
(global-unset-key (kbd "<M-left>"))
(global-unset-key (kbd "<M-right>"))
(global-unset-key (kbd "<M-up>"))
(global-unset-key (kbd "<M-down>"))

;; set backup files into .emacs_saves.
(setq backup-directory-alist '(("." . "~/.emacs.saves")))

;; ido mode provide nice utilities for searching files & buffers.
(require 'ido)
(ido-mode t)

;; enable typing some french characters.
(require 'iso-transl)

;; theme.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes '(wheatgrass))
 '(package-selected-packages
   '(glsl-mode deadgrep yaml-mode smex toml-mode rainbow-delimiters multiple-cursors yasnippet flycheck lsp-ui use-package company lsp-mode rustic)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'multiple-cursors)
(global-set-key (kbd "C-c m c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; to make global searches.
(global-set-key (kbd "<f5>") #'deadgrep)

(setq auto-mode-alist (cons '("\\.vsl$" . rust-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.rhai$" . rust-mode) auto-mode-alist))

;; load modes
(load "~/.emacs.modes/rust.el")
(put 'upcase-region 'disabled nil)
