;;
;; Back to the command line ~JEB 20150515
;;
;; Time-stamp: "2015-05-15 18:31:05 bushj"
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


;; 20150515 - http://www.emacswiki.org/emacs/LoadPath 
     (add-to-list 'load-path "~/.emacs.d/lisp/")
;; 20150515 - http://www.emacswiki.org/emacs/TimeStamp
     (add-hook 'before-save-hook 'time-stamp)
     (setq time-stamp-pattern nil)

;; ----------------------------------------------------------------------
;;                                              tools in alphabetic order
;; ----------------------------------------------------------------------


;; GIT ------------------------------------------------------------------

;;
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


;; MARKDOWN MODE --------------------------------------------------------

;;
;; 20150515 - adding markdown mode 
;;          Getting  
;;            File mode specification error: (error "Unknown keyword :safe")
;;          upon file opening. 20150515

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

;; ORG  MODE --------------------------------------------------------

;;
;; 20150515 - org-mode changes
;;

     (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;;   Choose key bindings

     (define-key global-map "\C-cl" 'org-store-link)
     (define-key global-map "\C-ca" 'org-agenda)

;;   Activate `font-lock-mode' in org-mode buffers, functionality depends on font-locking being active.
     ;; (global-font-lock-mode 1)                     ; for all buffers
     (add-hook 'org-mode-hook 'turn-on-font-lock)  ; org-mode buffers only

;; ----------------------------------------------------------------------
;;                                                              resources
;; ----------------------------------------------------------------------

;; [1] http://dotfiles.github.io/
