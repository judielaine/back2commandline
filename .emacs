;;
;; Back to the command line ~JEB 20150515
;;
;; Time-stamp: "2019-06-07 17:51:09 bushj"
;;
;; ----------------------------------------------------------------------
;;                                                                how-tos
;; ----------------------------------------------------------------------
;;
;; Q How can I reload .emacs after changing it? [2]
;; A You can use the command load-file (M-x load-file, then press return
;; twice to accept the default filename, which is the current file being
;; edited).
;; A ou can also just move the point to the end of any sexp and press
;; C-xC-e to execute just that sexp.
;; 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 '(make-backup-files t)
 '(package-selected-packages
   (quote
    (geeknote magit markdown-mode w3m orgit magit-gh-pulls magit-filenotify json-mode flycheck-plantuml awk-it))))
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
;;(load-file "~/.emacs.d/lisp/gabrielelanaro-emacs-for-python-2f284d1/epy-init.el")

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

;; GIT (and MAGIT) ------------------------------------------------------
;
;; 20150515 - @WorkMac does not have the git.el file on it anywhere. So
;;          d/l the two files from
;;          http://git.kernel.org/cgit/git/git.git/tree/contrib/emacs/
;;          See http://www.emacswiki.org/emacs/Git
;;          See http://alexott.net/en/writings/emacs-vcs/EmacsGit.html#sec3
(require 'git)
(require 'git-blame)
;; 20151224 adding magit
(global-set-key (kbd "C-x g") 'magit-status)

;; Package management ---------------------------------------------------
;
;; http://melpa.org/#/ package.el now includes a mechanism to upgrade
;; packages. After running package-list-packages, type U (mark
;; Upgradable packages) and then x (eXecute the installs and
;; deletions). When it’s done installing all the packages it will ask
;; if you want to delete the obsolete packages and so you can hit y
;; (Yes).
;;
;; Note that you'll need to run M-x package-refresh-contents or M-x
;; package-list-packages to ensure that Emacs has fetched the MELPA
;; package list before you can install packages with M-x package-
;; install or similar. QV http://melpa.org/#/getting-started

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
(setq calendar-latitude 35.7524351)
(setq calendar-longitude -79.1774241)
(setq calendar-location-name "Clowderwood, Chatham County, NC")


;; EVERNOTE MODE --------------------------------------------------------
;; Geeknote via https://github.com/jeffkowalski/geeknote
;; To work on a local machine need to
;;     > brew install --HEAD https://raw.githubusercontent.com/jeffkowalski/geeknote/master/geeknote.rb
;;     > pip install --upgrade pytest    
;;     > 

;;     > ln -s ~/Documents/PublicGitHubRepository/back2commandline/Dot_geeknote ~/.geeknote

;; mv .geeknote/ ~/Documents/PublicGitHubRepository/back2commandline/Dot_geeknote
;; bushj-2mbaho:~ bushj$ ln -s ~/Documents/PublicGitHubRepository/back2commandline/Dot_geeknote .geeknote

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


;; 20150621 Sunrise-set
(setq org-agenda-sunrise-sunset t)
;; 20150614 http://orgmode.org/worg/org-faq.html#orgheadline140
(setq org-agenda-todo-ignore-scheduled t)
;; https://emacs.stackexchange.com/questions/2668/is-there-a-way-to-set-the-global-agenda-sorting
(setq org-agenda-sorting-strategy
      '((agenda time-up category-up)
	(todo priority-down category-up)
	(tags priority-down category-keep)
	(search category-keep)))
(setq org-catch-invisible-edits t)
;; from http://writequit.org/org/settings.html
;; Separate drawers for clocking and logs 20150521
(setq org-drawers `("PROPERTIES" "CLOCK" "LOGBOOK" "HIDDEN" "RESULTS"))
;; 20150613 default is 14
(setq org-deadline-warning-days 8)
;; 20150608 http://stackoverflow.com/questions/30688204/task-dependency-in-org-mode
(setq org-enforce-todo-dependencies t)
;; 201506`3 took out soume of the non-functioning check box stuff
(setq org-html-checkbox-type 'html)
;;          timestamps on "done" C-c C-t
(setq org-log-done t)
;; 20160109 https://www.gnu.org/software/emacs/manual/html_node/org/Workflow-states.html
(setq org-todo-keywords
      '((sequence "TODO" "|" "DONE" "PUNT" "PAUS" "OBSL")))
;; PUNT: failed to complete this, no longer intend to work on it.
;; PAUSe: i may wish to return to this, but not now
;; OBSoLete: this is no longer relevant due to external issues

;; 20150522 - http://stackoverflow.com/questions/30312638/is-there-a-package-or-setting-to-show-an-org-mode-link-under-cursor-destinatio
(defun org-link-message ()
  "Show org-mode link destination under cursor in the mode line: by John Kitchin"
  (let ((object (org-element-context)))
    (when (eq (car object) 'link)
      (message "%s"
	       (org-element-property :raw-link object)))))

;; PlantUML -------------------------------------------------------------
;; 20151020 see https://github.com/skuro/puml-mode
;; NOW see https://github.com/skuro/plantuml-mode
;; Enable puml-mode for PlantUML files
;; C-c C-c  renders a PlantUML diagram from the current buffer in the best supported format
;; 20161123 added .iuml & flycheck
;; 20190604 updated path name per https://github.com/skuro/plantuml-mode/issues/43
(setq plantuml-jar-path "~/.emacs.d/lisp/plantuml.jar")
(add-to-list 'auto-mode-alist
	     '("\\.puml\\'" . plantuml-mode)
	     '("\\.iuml\\'" . plantuml-mode))
;;	     '("\\.plantuml\\'" . plantuml-mode))

(with-eval-after-load 'flycheck
  (require 'flycheck-plantuml)
  (flycheck-plantuml-setup))

;; 20161223 Fixed mode definition

;; PYTHON MODE ----------------------------------------------------------
;; 20150521 - http://stackoverflow.com/questions/10241279/how-do-i-run-a-python-interpreter-in-emacs
;;(setq python-shell-interpreter "/usr/local/bin/python3")



;; ----------------------------------------------------------------------
;;                                                              resources
;; ----------------------------------------------------------------------

;; [1] http://dotfiles.github.io/
;; [2] https://stackoverflow.com/questions/2580650/how-can-i-reload-emacs-after-changing-it

