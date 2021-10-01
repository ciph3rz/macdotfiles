;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "edworks"
      user-mail-address "edworks@tribal-odyssey.com")

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
(setq doom-font (font-spec :family "Iosevka SS04" :size 18 :weight 'Light)
      doom-variable-pitch-font (font-spec :family "Baskerville" :size 18 :weight 'Regular))
      ;;doom-variable-pitch-font (font-spec :family "ETBembo" :size 18)
;;      doom-serif-font (font-spec :family "Iosevka"))

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

;; ORG-ROAM Settings

(use-package! org-roam
  :init
  (setq org-roam-v2-ack t)
  (map! :leader
        :prefix "n"
        :desc "org-roam" "l" #'org-roam-buffer-toggle
        :desc "org-roam-node-insert" "i" #'org-roam-node-insert
        :desc "org-roam-node-find" "f" #'org-roam-node-find
        :desc "org-roam-ref-find" "r" #'org-roam-ref-find
        :desc "org-roam-show-graph" "g" #'org-roam-show-graph
        :desc "org-roam-capture" "c" #'org-roam-capture
        :desc "org-roam-node-insert-immediate" "I" #'org-roam-node-insert-immediate
        :desc "my/org-roam-find-project" "p" #'org-roam-node-find-project
        :desc "my/org-roam-capture-task" "t" #'my/org-roam-capture-task
        :desc "my/org-roam-capture-inbox" "b" #'my/org-roam-capture-inbox)
  (setq org-roam-directory (file-truename "~/org/RoamNotes")
        org-roam-db-location (file-truename "~/code/Roam/org-roam.db")
        org-roam-db-gc-threshold most-positive-fixnum
        org-id-link-to-org-use-id t)
  :config
  (org-roam-setup)
  (set-popup-rules!
    `((,(regexp-quote org-roam-buffer) ; persistent org-roam buffer
       :side right :width .33 :height .5 :ttl nil :modeline nil :quit nil :slot 1)
      ("^\\*org-roam: " ; node dedicated org-roam buffer
       :side right :width .33 :height .5 :ttl nil :modeline nil :quit nil :slot 2)))

  (add-hook 'org-roam-mode-hook #'turn-on-visual-line-mode)
  (setq org-roam-capture-templates
        '(("d" "default" plain
           "%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
           :immediate-finish t
           :unnarrowed t)
          ("r" "bibliography reference" plain "%?"
           :if-new
           (file+head "references/${citekey}.org" "#+title: ${title}\n")
           :unnarrowed t)
          ("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n* Resources\n\n"
           :if-new
           (file+head "%<%Y%m%d%H%M%S>-${slug}.org" " #+title: ${title}\n#+category: ${title}\n#+filetags: Project")
           :unnarrowed t)))


 (set-company-backend! 'org-mode '(company-capf))
  (require 'org-roam-protocol))

(use-package! org-roam-dailies
  :init
  (map! :leader
        :prefix "n"
        :desc "org-roam-dailies-capture-today" "j" #'org-roam-dailies-capture-today
        :desc "org-roam-dailies-capture-yesterday" "Y" #'org-roam-dailies-capture-yesterday
        :desc "org-roam-dailies-capture-tomorrow" "T" #'org-roam-dailies-capture-tomorrow)
  :config
  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :if-new (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n")))))

;; Custom ORG-ROAM Settings
(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (push arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

(defun my/org-roam-filter-by-tag (tag-name)
  (lambda (node)
    (member tag-name (org-roam-node-tags node))))

(defun my/org-roam-list-notes-by-tag (tag-name)
  (mapcar #'org-roam-node-file
          (seq-filter
           (my/org-roam-filter-by-tag tag-name)
           (org-roam-node-list))))

(defun my/org-roam-refresh-agenda-list ()
  (interactive)
  (setq org-agenda-files (my/org-roam-list-notes-by-tag "Project")))

;; Build the agenda list the first time for the session
(my/org-roam-refresh-agenda-list)

(defun my/org-roam-project-finalize-hook ()
  "Adds the captured project file to `org-agenda-files' if the
capture was not aborted."
  ;; Remove the hook since it was added temporarily
  (remove-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

  ;; Add project file to the agenda list if the capture was confirmed
  (unless org-note-abort
    (with-current-buffer (org-capture-get :buffer)
      (add-to-list 'org-agenda-files (buffer-file-name)))))

(defun my/org-roam-find-project ()
  (interactive)
  ;; Add the project file to the agenda after capture is finished
  (add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

  ;; Select a project file to open, creating it if necessary
  (org-roam-node-find
   nil
   nil
   (my/org-roam-filter-by-tag "Project")
   :templates
   '(("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n* Resources-Links\n\n"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+category: ${title}\n#+filetags: Project")
      :unnarrowed t))))

(defun my/org-roam-capture-inbox ()
  (interactive)
  (org-roam-capture- :node (org-roam-node-create)
                     :templates '(("i" "inbox" plain "* %?"
                                  :if-new (file+head "Inbox.org" "#+title: Inbox\n")))))

(defun my/org-roam-capture-task ()
  (interactive)
  ;; Add the project file to the agenda after capture is finished
  (add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

  ;; Capture the new task, creating the project file if necessary
  (org-roam-capture- :node (org-roam-node-read
                            nil
                            (my/org-roam-filter-by-tag "Project"))
                     :templates '(("p" "project" plain "** TODO %?"
                                   :if-new (file+head+olp "%<%Y%m%d%H%M%S>-${slug}.org"
                                                          "#+title: ${title}\n#+category: ${title}\n#+filetags: Project"
                                                          ("Tasks"))))))

(defun my/org-roam-copy-todo-to-today ()
  (interactive)
  (let ((org-refile-keep t) ;; Set this to nil to delete the original!
        (org-roam-dailies-capture-templates
          '(("t" "tasks" entry "%?"
             :if-new (file+head+olp "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n" ("Tasks")))))
        (org-after-refile-insert-hook #'save-buffer)
        today-file
        pos)
    (save-window-excursion
      (org-roam-dailies--capture (current-time) t)
      (setq today-file (buffer-file-name))
      (setq pos (point)))

    ;; Only refile if the target file is different than the current file
    (unless (equal (file-truename today-file)
                   (file-truename (buffer-file-name)))
      (org-refile nil nil (list "Tasks" today-file nil pos)))))

(add-to-list 'org-after-todo-state-change-hook
             (lambda ()
               (when (equal org-state "DONE")
                 (my/org-roam-copy-todo-to-today))))

;;THIS IS OLD
;; (use-package! org-roam
;;   :init
;;   (setq org-roam-v2-ack t)
;;   (map! :leader
;;         :prefix "n"
;;         :desc "org-roam" "l" #'org-roam-buffer-toggle
;;         :desc "org-roam-node-insert" "i" #'org-roam-node-insert
;;         :desc "org-roam-node-find" "f" #'org-roam-node-find
;;         :desc "org-roam-ref-find" "r" #'org-roam-ref-find
;;         :desc "org-roam-show-graph" "g" #'org-roam-show-graph
;;         :desc "org-roam-capture" "c" #'org-roam-capture)
;;   (setq org-roam-directory (file-truename "~/org/RoamNotes")
;;         org-roam-db-location (file-truename "~/code/Roam/org-roam.db")
;;         org-roam-db-gc-threshold most-positive-fixnum
;;         org-roam-completion-everywhere t
;;         org-id-link-to-org-use-id t)
;;   :config
;;   (org-roam-setup)
;;   (set-popup-rules!
;;     `((,(regexp-quote org-roam-buffer) ; persistent org-roam buffer
;;        :side right :width .33 :height .5 :ttl nil :modeline nil :quit nil :slot 1)
;;       ("^\\*org-roam: " ; node dedicated org-roam buffer
;;        :side right :width .33 :height .5 :ttl nil :modeline nil :quit nil :slot 2)))

;;   (add-hook 'org-roam-mode-hook #'turn-on-visual-line-mode)
;;   (setq org-roam-capture-templates
;;         '(("d" "default" plain
;;            "%?"
;;            :if-new (file+head "${slug}.org"
;;                               "#+title: ${title}\n")
;;            :immediate-finish t
;;            :unnarrowed t)
;;           ("r" "bibliography reference" plain "%?"
;;            :if-new
;;            (file+head "references/${citekey}.org" "#+title: ${title}\n")
;;            :unnarrowed t)
;;           ("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
;;            :if-new
;;            (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project")
;;            :unnarrowed t)))
;;   (set-company-backend! 'org-mode '(company-capf))
;;   (require 'org-roam-protocol))

;; (use-package! org-roam-dailies
;;   :init
;;   (map! :leader
;;         :prefix "n"
;;         :desc "org-roam-dailies-capture-today" "j" #'org-roam-dailies-capture-today)
;;   :config
;;   (setq org-roam-dailies-directory "daily/")
;;   (setq org-roam-dailies-capture-templates
;;         '(("d" "default" entry
;;            "* %?"
;;            :if-new (file+head "%<%Y-%m-%d>.org"
;;                               "#+title: %<%Y-%m-%d>\n")))))






;;(setq org-roam-directory "~/org/RoamNotes")
;;(setq org-roam-db-location (expand-file-name (concat "org-roam." hr/hostname ".db") org-roam-directory))

;; (setq org-capture-templates
;;       '(("d" "default" plain
;;       "%?"
;;       :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
;;       :unnarrowed t))
;;       '("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
;;        :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project")
;;        :unnarrowed t)
;;       )
;; (
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
(setq org-babel-load-languages (quote ((emacs-lisp . t) (bash .t) (sh . t))))
)

;; Custom MacOS M1 config for vterm compilation
'(exec-path
    '("/usr/local/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin"  "/opt/homebrew/bin" "/opt/homebrew/sbin" ))
