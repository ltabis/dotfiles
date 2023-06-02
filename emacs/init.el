;; Install melpa for packages.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; load 'use-package' package, funny.
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

(setq inhibit-startup-message t		; Don't show the splash screen.
      visible-bell t)			; Blinks when reaching end or start of buffer.
(menu-bar-mode -1)			; Remove menu bar
(tool-bar-mode -1)			; Remove tool bar
(scroll-bar-mode -1)			; Remove scroll bar
(show-paren-mode 1)			; Show matching parens.
(hl-line-mode 1)			; Highlight the selected line.
(blink-cursor-mode -1)			; Prevent the cursor from blinking.
(global-display-line-numbers-mode 1)	; Shoe line numbers in every buffer.

(load-theme 'modus-vivendi t)

(setq backup-directory-alist '(("." . "~/.emacs.saves")))

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(setq hl-todo-keyword-faces
      '(("TODO"   . "#FF0000")
	  ("FIXME"  . "#FF0000")
	  ("DEBUG"  . "#A020F0")
	  ("GOTCHA" . "#FF4500")
	  ("STUB"   . "#1E90FF")))

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
       "* %?\nEntered on %U\n  %i\n  %a")))

;; Tangle org files on save.
(require 'org-auto-tangle)
(add-hook 'org-mode-hook 'org-auto-tangle-mode)

(setq
 org-journal-dir "~/org/journal/"
 org-journal-date-prefix "#+TITLE:"     ; Org-mode style header.
 org-journal-time-prefix "* "           ; Entries for the day are now top-level headers.
 org-journal-file-format "%Y%m%d.org")  ; Make all journal entries org-mode.

(setq org-roam-directory (file-truename "~/org/knowledge")) ; file-truname is used to resolve symlimks, just in case.
(org-roam-db-autosync-mode)
