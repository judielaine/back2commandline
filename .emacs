;;
;; Back to the command line ~JEB 20150515
;;
;; Time-stamp: "2015-05-18 08:11:01 judielaine"
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

;; 20150517 - http://orgmode.org/worg/org-tutorials/orgtutorial_dto.html
(setq org-agenda-files (list "~/.emacs.d/PIM/Back2CommandLine.org"))


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


;; DIARY MODE -----------------------------------------------------------
;; REF: http://sunsite.univie.ac.at/textbooks/emacs/emacs_33.html
;; 20150517 - http://www.emacswiki.org/emacs/DiaryMode
(require 'calendar)  
(calendar-set-date-style 'iso)
;; 20150518 - sorted in order
(add-hook 'list-diary-entries-hook 'sort-diary-entries t)
(setq diary-file "~/.emacs.d/PIM/diary")

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
;;          timestamps on "done" C-c C-t
(setq org-log-done t)

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


;;           TBD
;;   Activate `font-lock-mode' in org-mode buffers, functionality depends
;;   on font-locking being active.
;     (add-hook 'org-mode-hook 'turn-on-font-lock)  ; org-mode buffers only

;; ----------------------------------------------------------------------
;;                                                              resources
;; ----------------------------------------------------------------------

;; [1] http://dotfiles.github.io/
