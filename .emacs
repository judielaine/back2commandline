;;
;; Back to the command line ~JEB 20150515
;;
;; Time-stamp: "2015-05-22 10:53:57 bushj"
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


;; ----------------------------------------------------------------------
;;                                mode customizations in alphabetic order
;; ----------------------------------------------------------------------

;; column-number-mode 20150521 omg not default.
(column-number-mode)


;; DIARY MODE -----------------------------------------------------------
;; REF: http://sunsite.univie.ac.at/textbooks/emacs/emacs_33.html
;; 20150517 - http://www.emacswiki.org/emacs/DiaryMode
(require 'calendar)  
(calendar-set-date-style 'iso)
;; 20150518 - sorted in order
(add-hook 'list-diary-entries-hook 'sort-diary-entries t)

;; 20150519
(setq org-agenda-include-diary t)
;; EVERNOTE MODE --------------------------------------------------------
;; 2015-05-17 http://emacs-evernote-mode.googlecode.com/svn/branches/0_41/doc/readme_en.html
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
;;          from http://www.emacswiki.org/emacs/OrgMode#toc19 
(defun sacha/org-html-checkbox (checkbox)
  "Format CHECKBOX into HTML."
  (case checkbox (on "<span class=\"check\">&#x2611;</span>") ; checkbox (checked)
	(off "<span class=\"checkbox\">&#x2610;</span>")
	(trans "<code>[-]</code>")
	(t "")))
(defadvice org-html-checkbox (around sacha activate)
    (setq ad-return-value (sacha/org-html-checkbox (ad-get-arg 0))))
;;          from http://stackoverflow.com/questions/22988092/emacs-org-mode-export-markdown
(eval-after-load "org"
  '(require 'ox-md nil t))

;; 20150521 - reading the org-mode manual systematically
(setq org-catch-invisible-edits t
      ;; from http://writequit.org/org/settings.html
      ;; Separate drawers for clocking and logs 20150521
      org-drawers `("PROPERTIES" "CLOCK" "LOGBOOK" "HIDDEN" "RESULTS")
      ;; timestamps on "done" C-c C-t 20150515-17
      org-log-done t)

;; 20150522 - http://stackoverflow.com/questions/30312638/is-there-a-package-or-setting-to-show-an-org-mode-link-under-cursor-destinatio
(defun org-link-message ()
  "Show org-mode link destination under cursor in the mode line: by John Kitchin"
  (let ((object (org-element-context)))
    (when (eq (car object) 'link)
      (message "%s"
	       (org-element-property :raw-link object)))))
;(add-hook 'post-command-hook 'org-link-message)


;; PYTHON MODE ----------------------------------------------------------
;; 20150521 - http://stackoverflow.com/questions/10241279/how-do-i-run-a-python-interpreter-in-emacs
(setq python-shell-interpreter "/usr/local/bin/python3")



;; ----------------------------------------------------------------------
;;                                                              resources
;; ----------------------------------------------------------------------

;; [1] http://dotfiles.github.io/
