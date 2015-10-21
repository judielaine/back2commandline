;;
;; Back to the command line ~JEB 20150515
;;
;; Time-stamp: "2015-10-20 13:31:33 bushj"

;;


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 '(make-backup-files t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )



;; ----------------------------------------------------------------------
;;                                                         file locations
;; ----------------------------------------------------------------------
;; 20150515 - http://www.emacswiki.org/emacs/LoadPath 
(add-to-list 'load-path "~/.emacs.d/lisp/")
;; 20150521 - http://gabrielelanaro.github.io/emacs-for-python/
(load-file "~/.emacs.d/lisp/gabrielelanaro-emacs-for-python-2f284d1/epy-init.el")
;; 20150526
(load-file "~/.emacs.d/evernotekey.el")


;; 20150517 - http://orgmode.org/worg/org-tutorials/orgtutorial_dto.html
;; 20150519 - changing to include the whole directory
(setq org-agenda-files (list "~/.emacs.d/PIM/"))
(setq org-agenda-include-diary t)
(setq diary-file "~/.emacs.d/PIM/diary")
;; ----------------------------------------------------------------------
;;                                              tools in alphabetic order
;; ----------------------------------------------------------------------

;; 20150515 - http://www.emacswiki.org/emacs/TimeStamp
(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-pattern nil)

;; GIT ------------------------------------------------------------------
;
;; 20150515 - @WorkMac does not have the git.el file on it anywhere. So
;;          d/l the two files from
;;          http://git.kernel.org/cgit/git/git.git/tree/contrib/emacs/
;;          See http://www.emacswiki.org/emacs/Git
;;          See http://alexott.net/en/writings/emacs-vcs/EmacsGit.html#sec3
(require 'git)
(require 'git-blame)

;; Package management ---------------------------------------------------
;
;; http://melpa.org/#/ package.el now includes a mechanism to upgrade
;; packages. After running package-list-packages, type U (mark
;; Upgradable packages) and then x (eXecute the installs and
;; deletions). When it’s done installing all the packages it will ask
;; if you want to delete the obsolete packages and so you can hit y
;; (Yes).
(require 'package) 
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) 

;; ----------------------------------------------------------------------
;;                                mode customizations in alphabetic order
;; ----------------------------------------------------------------------
;
;; column-number-mode 20150521 omg not default.
(column-number-mode)


;; DIARY MODE -----------------------------------------------------------
;; REF: http://sunsite.univie.ac.at/textbooks/emacs/emacs_33.html
;; 20150517 - http://www.emacswiki.org/emacs/DiaryMode
;;(require 'calendar)  

;; 20150518 - sorted in order
;; (add-hook 'list-diary-entries-hook 'sort-diary-entries t)
(setq calendar-latitude 37.4)
(setq calendar-longitude -122.1)
(setq calendar-location-name "Mountain View, CA")


;; EVERNOTE MODE --------------------------------------------------------
;; 2015-05-17 http://emacs-evernote-mode.googlecode.com/svn/branches/0_41/doc/readme_en.html
(setq evernote-ruby-command "/opt/local/bin/ruby")
(require 'evernote-mode)
(setq evernote-username "judielaine") ; optional: you can use this username as default.
(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ; option
(global-set-key "\C-cec" 'evernote-create-note)
(global-set-key "\C-ceo" 'evernote-open-note)
(global-set-key "\C-ces" 'evernote-search-notes)
(global-set-key "\C-ceS" 'evernote-do-saved-search)
(global-set-key "\C-cew" 'evernote-write-note)
(global-set-key "\C-cep" 'evernote-post-region)
(global-set-key "\C-ceb" 'evernote-browser)
;; MARKDOWN MODE --------------------------------------------------------

;;
;; 20150515 - adding markdown mode 

     (autoload 'markdown-mode "markdown-mode"
       "Major mode for editing Markdown files" t)
     (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
     (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
     (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; 20150515 http://www.emacswiki.org/emacs/MarkdownMode
     (add-hook 'markdown-mode-hook
	       (lambda ()
		 (when buffer-file-name
		   (add-hook 'after-save-hook
			     'check-parens
			     nil t))))

;; ORG MODE -------------------------------------------------------------
;; Creating symlink from .emacs.d/PIM to Google Drive space so that the
;; PII can sync between machines. 

;; 20150515 - 17 as i am learning the mode 
;;          automatically go to org-mode for .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;;          per http://orgmode.org/worg/org-tutorials/orgtutorial_dto.html
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

;;          timestamps on "done" C-c C-t
(setq org-log-done t)
(setq org-catch-invisible-edits t)
;; 201506`3 took out soume of the non-functioning check box stuff
(setq org-html-checkbox-type 'html)
;; 20150608 http://stackoverflow.com/questions/30688204/task-dependency-in-org-mode
(setq org-enforce-todo-dependencies t)
;; 20150613 default is 14
(setq org-deadline-warning-days 3)
;; 20150614 http://orgmode.org/worg/org-faq.html#orgheadline140
(setq org-agenda-todo-ignore-scheduled t)
;; 20150521 - reading the org-mode manual systematically
(setq org-catch-invisible-edits t
      ;; from http://writequit.org/org/settings.html
      ;; Separate drawers for clocking and logs 20150521
      org-drawers `("PROPERTIES" "CLOCK" "LOGBOOK" "HIDDEN" "RESULTS")
      ;; timestamps on "done" C-c C-t 20150515-17
      org-log-done t)
;; 20150621 Sunrise-set
(setq org-agenda-sunrise-sunset t)


;; 20150522 - http://stackoverflow.com/questions/30312638/is-there-a-package-or-setting-to-show-an-org-mode-link-under-cursor-destinatio
(defun org-link-message ()
  "Show org-mode link destination under cursor in the mode line: by John Kitchin"
  (let ((object (org-element-context)))
    (when (eq (car object) 'link)
      (message "%s"
	       (org-element-property :raw-link object)))))

;; PlantUML -------------------------------------------------------------
;; 20151020 see https://github.com/skuro/puml-mode
;; Enable puml-mode for PlantUML files
;; C-c C-c  renders a PlantUML diagram from the current buffer in the best supported format
;; (setq puml-plantuml-jar-path "~/.emacs.d/lisp/plantuml.jar")
(add-to-list 'auto-mode-alist
	     '("\\.puml\\'" . puml-mode)
	     '("\\.plantuml\\'" . puml-mode))



;; PYTHON MODE ----------------------------------------------------------
;; 20150521 - http://stackoverflow.com/questions/10241279/how-do-i-run-a-python-interpreter-in-emacs
(setq python-shell-interpreter "/usr/local/bin/python3")



;; ----------------------------------------------------------------------
;;                                                              resources
;; ----------------------------------------------------------------------

;; [1] http://dotfiles.github.io/
