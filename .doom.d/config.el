;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

(setq doom-theme 'doom-one)

(setq display-line-numbers-type t)

(beacon-mode 1)

(setq
 plantuml-default-exec-mode 'jar)  ; execute the binary instead of sending request to a server.

(after! org
  ;; If you use `org' and don't want your org files in the default location below,
  ;; change `org-directory'.
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



(setq
 org-journal-dir "~/org/journal/"
 org-journal-date-prefix "#+TITLE:"     ; Org-mode style header.
 org-journal-time-prefix "* "           ; Entries for the day are now top-level headers.
 org-journal-file-format "%Y%m%d.org")  ; Make all journal entries org-mode.

(setq org-roam-directory (file-truename "~/org/knowledge")) ; file-truname is used to resolve symlimks, just in case.
(org-roam-db-autosync-mode)

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
