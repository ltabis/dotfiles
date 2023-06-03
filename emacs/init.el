;; Install melpa for packages.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install 'use-package' if it does not exist on the system.
;; Use package is a nice package installation abstraction.
;; https://github.com/jwiegley/use-package#installing-use-package
;; https://ianyepan.github.io/posts/setting-up-use-package/
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t  	; avoid calling :ensure on every package installation, will install them if they do not exist on the system.
	use-package-expand-minimally t))

(setq inhibit-startup-message t	; Don't show the splash screen.
      visible-bell t)			; Blinks when reaching end or start of buffer.
(menu-bar-mode -1)			; Remove menu bar
(tool-bar-mode -1)			; Remove tool bar
(scroll-bar-mode -1)			; Remove scroll bar
(show-paren-mode 1)			; Show matching parens.
(hl-line-mode 1)			; Highlight the selected line.
(blink-cursor-mode -1)		; Prevent the cursor from blinking.
(global-display-line-numbers-mode 1)	; Shoe line numbers in every buffer.
(recentf-mode 1)			; Remember recent edited files. TODO: add `recentf-open-files` shortcut.
(save-place-mode 1)			; Point goes to the last place where it was when you previously visited the same file.

(use-package zenburn-theme
  :config (load-theme 'zenburn t))

;; TODO: inspire from https://github.com/rougier/elegant-emacs/blob/master/elegance.el
(set-face-font 'default "Roboto Mono Light 14")
(setq-default line-spacing 0)

(setq backup-directory-alist '(("." . "~/.emacs.saves")))

(use-package multiple-cursors
  :bind
  ("C-c e l" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . 'mc/mark-next-like-this)
  ("C-c C-<" . 'mc/mark-all-like-this))

(use-package beacon
  :config (beacon-mode 1))

(use-package rainbow-delimiters :hook (prog-mode-hook . rainbow-delimiters-mode))

(use-package hl-todo
  :init
  (global-hl-todo-mode)
  :bind
  ("C-c h p" . hl-todo-previous)
  ("C-c h n" . hl-todo-next)
  ("C-c h o" . hl-todo-occur)
  ("C-c h i" . hl-todo-insert)
  :config
  (setq hl-todo-keyword-faces
	'(("TODO"   . "#FF0000")
	  ("FIXME"  . "#FF0000")
	  ("DEBUG"  . "#A020F0")
	  ("NOTE"   . "#A020F0")
	  ("GOTCHA" . "#FF4500")
	  ("STUB"   . "#1E90FF"))))

(use-package org
  :config
  (setq
   org-directory "~/org/"
   org-log-into-drawer t
   org-agenda-files '("~/org/")
   org-log-done 'time)

  ;; Register new templates here.
  (setq org-capture-templates
	'(
	  ("t" "simple todo" entry (file+headline "~/org/todo.org" "Tasks")
	   "* TODO %?\n  %i\n")

	  ("a" "tracked todo" entry (file+headline "~/org/todo.org" "Tasks")
	   "* TODO %?\n  %i\n  %a")

	  ("i" "simple idea" entry (file+headline "~/org/idea.org" "Ideas")
	   "* IDEA %?\n  %i\n")

	  ("j" "journal entry" entry (file+datetree "~/org/journal.org")
	   "* %?\nEntered on %U\n  %i\n  %a"))))

;; Tangle org files on save.
(use-package org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(use-package org-fancy-priorities
  :hook (org-mode . org-fancy-priorities-mode)
  :config (setq org-fancy-priorities-list '("🔴" "🟡" "🟢" "⚪")))

(use-package org-journal
  :config
  (setq
   org-journal-dir "~/org/journal/"
   org-journal-date-prefix "#+TITLE:"     ; Org-mode style header.
   org-journal-time-prefix "* "           ; Entries for the day are now top-level headers.
   org-journal-file-format "%Y%m%d.org")) ; Make all journal entries org-mode.

(use-package pdf-tools)
(use-package org-noter)

(use-package org-roam
  :config
  (setq org-roam-directory (file-truename "~/org/knowledge")) ; file-truname is used to resolve symlimks, just in case.
  (org-roam-db-autosync-mode))

(use-package org-roam-ui
  :config
  (setq org-roam-ui-sync-theme t
	org-roam-ui-follow t
	org-roam-ui-update-on-save t))
