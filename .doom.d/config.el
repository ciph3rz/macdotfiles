;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "edworks"
      user-mail-address "edworks@gmx.net")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 14))
;; (setq doom-font (font-spec :family "Iosevka" :size 14)
(setq doom-font (font-spec :family "Source Code Pro" :size 18)
      ;;doom-variable-pitch-font (font-spec :family "Libre Baskerville")
      ;;doom-variable-pitch-font (font-spec :family "ETBembo" :size 18)
      doom-serif-font (font-spec :family "Iosevka"))

  (custom-theme-set-faces
   'user
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info ((t (:foreground "dark orange"))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   '(org-link ((t (:foreground "royal blue" :underline t))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-property-value ((t (:inherit fixed-pitch))) t)
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
   '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'modus-operandi)
;;(setq doom-theme 'doom-tron)
(setq doom-theme 'doom-city-lights)

;; Enable Auto Save and backup
(setq auto-save-default t
      make-backup-files t)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq deft-directory "~/org/"
 deft-extentions '("org" "txt")
 deft-recursive t)
  ;; set org file directory
(after! org

(setq org-files-directory "~/org/")

(setq org-log-into-drawer t )

(setq org-todo-keywords
      '(
        (sequence "TODO(t!)" "INPROGRESS(i!)" "PROJ(p!)" "WAIT(w@/!)" "FOLLOWUP(f!)" "SOMEDAY(s@/!)" "|" "CANCELLED(c!)" "DONE(d!)")
        ))
(setq org-capture-templates
		'(

     ("G" "Define a goal" entry (file+headline "~/org/capture.org" "Capture") (file "~/org/templates/tpl-goal.txt") :empty-lines-after 2)

     ("N" "NEXT entry" entry (file+headline "~/org/capture.org" "Capture") (file "~/org/templates/tpl-next.txt") :empty-lines-before 1)

     ("T" "TODO entry" entry (file+headline "~/org/capture.org" "Capture") (file "~/org/templates/tpl-todo.txt") :empty-lines-before 1)

     ("W" "WAITING entry" entry (file+headline "~/org/capture.org" "Capture") (file "~/org/templates/tpl-waiting.txt") :empty-lines-before 1)

     ("S" "SOMEDAY entry" entry (file+headline "~/org/capture.org" "Capture") (file "~/org/templates/tpl-someday.txt") :empty-lines-before 1)

     ("P" "PROJ entry" entry (file+headline "~/org/capture.org" "Capture") (file "~/org/templates/tpl-proj.txt") :empty-lines-before 1)


     ("B" "Book on the to-read-list" entry (file+headline "~/org/private.org" "Books to read") (file "~/org/tpl-book.txt") :empty-lines-after 2)


     ("p" "Create a daily plan")

     ("pP" "Daily plan private" plain (file+olp+datetree "~/org/plan-free.org") (file "~/org/templates/tpl-dailyplan.txt") :immediate-finish t)

     ("pW" "Daily plan work" plain (file+olp+datetree "~/org/plan-work.org") (file "~/org/templates/tpl-dailyplan.txt") :immediate-finish t)

     ("J" "Journal entry")
     ("jP" "Journal entry private privat" entry (file+olp+datetree "~/org/journal-privat.org") "** %^{Heading}")
      ("jW" "Journal entry work " entry (file+olp+datetree "~/org/journal.org") "** %^{Heading}")
     ))

;;(setq! org-log done 'time)
;; https://emacs.stackexchange.com/questions/59824/how-to-map-or-iterate-over-a-list-of-files-and-set-the-result-to-org-agenda-fil
;; Use `mapcar'
;; (setq org-agenda-files
;;       (mapcar (lambda (f) (expand-file-name file org-gtd-folder))
;;               org-gtd-task-files))

;; ;; Use `dolist'
;; (dolist (file  org-agenda-files)
;;   (push (expand-file-name file org-gtd-folder) org-agenda-files)
;;   org-agenda-files)

  ;; set archive tag
  (setq org-archive-tag "archive")
  ;; set archive file
  (setq org-archive-location (concat org-files-directory "archive.org::* From %s"))
  ;; refiling targets include any file contributing to the agenda - up to 2 levels deep
  (setq org-refile-targets '((nil :maxlevel . 4)
                             (org-agenda-files :maxlevel . 4)))
(setq org-refile-allow-creating-parent-nodes t)

  ;; Org-Super-Agenda Part II
;; Updated LINE
  (setq org-agenda-files '("~/org/work/bisp.org" "~/org/capture.org" "~/org/home/home.org"))
  ;; Custome functions to focus agenda views on either home vs work vs all

  (defun org-focus-private() "Set focus on private things." (interactive)
    (setq org-agenda-files '("~/org/home/home.org")))
  (defun org-focus-work() "Set focus on work things." (interactive)
    (setq org-agenda-files '("~/org/work/bisp.org")))
  (defun org-focus-all() "Set focus on all things." (interactive)
    (setq org-agenda-files '("~/org/work/bisp.org" "~/org/home/home.org")))
  ;; Org-Super-Agenda
  ;; (define-package org-super-agenda
  ;;   :after org-agenda
  ;;   :init
  ;;   (setq org-super-agenda-groups '((:name "Today"
  ;;                                  :time-grid t
  ;;                                  :scheduled today)
  ;;                           (:name "Due today"
  ;;                                  :deadline today)
  ;;                           (:name "Important"
  ;;                                  :priority "A")
  ;;                           (:name "Overdue"
  ;;                                  :deadline past)
  ;;                           (:name "Due soon"
  ;;                                  :deadline future)
  ;;                           (:name "Big Outcomes"
  ;;                                  :tag "bo")))
  ;;  :config
  ;;  (org-super-agenda-mode))

  ;; Org Journal Settings
  (setq org-journal-dir "~/org/journal/")
	(setq org-journal-file-format "%Y-%m-%d.org")
	(setq org-journal-date-prefix "#+TITLE: ")
	(setq org-journal-date-format "%A, %B %d %Y")
	(setq org-journal-enable-agenda-integration t)

	(setq org-refile-use-outline-path t)
	;;(setq org-refile-use-outline-path 'file)
	(setq org-outline-path-complete-in-steps nil)

;; ORG Visual Settings
  (add-hook! org-mode :append
           #'visual-line-mode
           #'variable-pitch-mode)
;; Konig Functions to copy link to clipboard
(defun my/copy-idlink-to-clipboard() "Copy an ID link with the
headline to killring, if no ID is there then create a new unique
ID.  This function works only in org-mode or org-agenda buffers.

The purpose of this function is to easily construct id:-links to
org-mode items. If its assigned to a key it saves you marking the
text and copying to the killring."
       (interactive)
       (when (eq major-mode 'org-agenda-mode) ;if we are in agenda mode we switch to orgmode
	 (org-agenda-show)
	 (org-agenda-goto))
       (when (eq major-mode 'org-mode) ; do this only in org-mode buffers
	 (setq mytmphead (nth 4 (org-heading-components)))
         (setq mytmpid (funcall 'org-id-get-create))
	 (setq mytmplink (format "[[id:%s][%s]]" mytmpid mytmphead))
	 (kill-new mytmplink)
	 (message "Copied %s to killring (clipboard)" mytmplink)
       ))

(global-set-key (kbd "<f5>") 'my/copy-idlink-to-clipboard)

(defun org-reset-checkbox-state-maybe ()
  "Reset all checkboxes in an entry if the `RESET_CHECK_BOXES' property is set"
  (interactive "*")
  (if (org-entry-get (point) "RESET_CHECK_BOXES")
      (org-reset-checkbox-state-subtree)))

(defun org-checklist ()
  (when (member org-state org-done-keywords) ;; org-state dynamically bound in org.el/org-todo
    (org-reset-checkbox-state-maybe)))

(add-hook 'org-after-todo-state-change-hook 'org-checklist)

;; ORG DOWNLOAD-Clipboard
(defun zz/org-download-paste-clipboard (&optional use-default-filename)
  (interactive "P")
  (require 'org-download)
  (let ((file
         (if (not use-default-filename)
             (read-string (format "Filename [%s]: "
                                  org-download-screenshot-basename)
                          nil nil org-download-screenshot-basename)
           nil)))
    (org-download-clipboard file)))

(after! org
  (setq org-download-method 'directory)
  (setq org-download-image-dir "images")
  (setq org-download-heading-lvl nil)
  (setq org-download-timestamp "%Y%m%d-%H%M%S_")
  (setq org-image-actual-width 300)
  (setq org-download-screenshot-method "/usr/local/bin/pngpaste %s")
  (map! :map org-mode-map
        "C-c l a y" #'zz/org-download-paste-clipboard
        "C-M-y" #'zz/org-download-paste-clipboard))

	;; set max identation for descritpion lists
	(setq org-list=description-max-ident 5)
	;; prvent demoting heading also shifting text inside  sections
	(setq org-adapt-indentation nil)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Other Settings
(setq org-archive-location "%s::* ARCHIVES")
(setq tramp-default-method "ssh")
(define-skeleton org-skeleton
  "Header info for a emacs-org file."
  "Title: "
  "#+TITLE:" str " \n"
  "#+AUTHOR: Ciph3rz\n"
  "#+email: ciph3rz@zoho.com\n"
  "#+INFOJS_OPT: \n"
  "#+BABEL: :session sh :cache yes :results output graphics :exports both :tangle yes \n"
  "-----"
 )
;; Custom Keybindings
(global-set-key [C-S-9] 'org-skeleton)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key (kbd "<f6>") 'org-capture)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

; The default does not like the ~ before > so do a kludge
(setq shell-prompt-pattern '"^[^#$%>\n]*~?[#$%>] *")

;;(setq byte-compile-warnings '(cl-functions))
;; Babel configuration NEW
(setq org-babel-load-languages (quote ((emacs-lisp . t) (shell . t))))
)
