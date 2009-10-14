(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-firefox))
 '(case-fold-search t)
 '(current-language-environment "ASCII")
 '(global-font-lock-mode t nil (font-lock))
 '(hs-lint-command "~/.cabal/bin/hlint")
 '(jabber-connection-type (quote ssl))
 '(jabber-network-server "talk.google.com")
 '(jabber-nickname "Diegoeche")
 '(jabber-password nil)
 '(jabber-server "gmail.com")
 '(jabber-username "diegoeche")
 '(mouse-wheel-mode t nil (mwheel))
 '(show-paren-mode t nil (paren))
 '(standard-indent 4)
 '(transient-mark-mode t)
 '(visible-bell t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(display-time)
(line-number-mode 1)
(column-number-mode 1)
(setq scroll-bar-mode nil)
;; Inicio

(setq inhibit-startup-message t)	
(setq make-backup-files nil) 
(setq user-mail-address "diegoeche@gmail.com")
(setq user-full-name "Diego Echeverri")
(server-mode)
(global-linum-mode 1)

;;; Modes

;;; Shell mode
(setq ansi-color-names-vector ; better contrast colors
      ["black" "red4" "green4" "yellow4"
       "blue3" "magenta4" "cyan4" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; w3mc
(add-to-list 'load-path "~/lib/emacs-w3m/")
(require 'w3m-load)
(setq w3m-use-cookies t)

;; C-Sharp

(setq auto-mode-alist
      (cons '("\\.cs$" . c++-mode) auto-mode-alist))

;; F-Sharp
(setq load-path (cons "~/lib/fsharp" load-path))
(setq auto-mode-alist
      (cons '("\\.fs[iylx]?$" . fsharp-mode) auto-mode-alist))
(autoload 'fsharp-mode "fsharp" "Major mode for editing F# code." t)
(autoload 'run-fsharp "inf-fsharp" "Run an inferior F# process." t)

(setq inferior-fsharp-program "~/lib/fsharp/fsi.sh")
(setq fsharp-compiler "~/lib/fsharp/fsc.sh")
(add-hook 'fsharp-mode-hook (lambda () (outline-minor-mode)
                              (setq outline-regexp " *\\(let ..\\|type .\\|module\\)"))) 

;; Scala
(setq load-path (cons "~/lib/scala-mode" load-path))
(require 'scala-mode-auto)

(add-to-list 'load-path "~/lib/yasnippet-0.6.0c")
(require 'yasnippet)
(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
			     yas/ido-prompt
			     yas/completing-prompt))

(setq yas/root-directory "~/lib/yasnippet-0.6.0c/snippets/")
(yas/load-directory yas/root-directory)
(yas/load-directory "~/lib/scala-mode/contrib/yasnippet/snippets")

;; js2

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; Jabber
(add-to-list 'load-path "~/lib/emacs-jabber-0.7.1/")
(require 'jabber)

;; Haskell Customizations
(load "~/lib/haskell-mode-2.4/haskell-site-file")
(add-hook 'haskell-mode-hook 
          '(lambda () (setq haskell-program-name "~/lib/haskell-mode-2.4/ghci-no-tty.sh")))

;; autofill
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Small function for evaluating selected code 
(defun inferior-haskell-eval-region (start end)
  "Send the current region to the inferior fsharp process."
  (interactive "r")
  (save-excursion
    (goto-char end)
    (inferior-haskell-send-command (inferior-haskell-process) (buffer-substring start end))))
(load "~/lib/haskell-mode-2.4/hs-lint")

(require 'hs-lint)
(defun my-haskell-mode-hook ()
  (local-set-key "\C-c\C-r" 'inferior-haskell-eval-region)
  (local-set-key "\C-cl" 'hs-lint))
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)

;; Other legacy stuff

(setq load-path (cons "~/lib" load-path))
(setq load-path (cons "~/lib/themes" load-path))
(load "lib")
(load "color-theme")
(load "color-theme-autoloads")
(load "color-theme-library")
(set-default-font "Consolas-14") 

;; Gist
(require 'gist)

;; Colors
(color-theme-comidia)

;; Stuff
(setq search-highlight t)
(setq query-replace-highlight t)
(setq default-fill-column 85)
(setq next-line-add-newlines nil)


;; Parens
(require 'paren)  
(setq c-tab-always-indent "other") 

;; Tabs replacement
(setq-default indent-tabs-mode nil) 

(defun google-region (beg end)
  "Google the selected region."
  (interactive "r")
  (browse-url (concat "http://www.google.com/search?ie=utf-8&oe=utf-8&q=" (buffer-substring beg end))))

;; Syntax highlighting
;; (global-font-lock-mode t)
;; (setq font-lock-support-mode 'lazy-lock-mode)
;; (setq font-lock-maximum-size nil)       
;; (require 'font-lock)
;; (require 'lazy-lock)
;; (setq auto-mode-alist
;;         (append '(
;; 		  ("configure.in" . m4-mode)
;; 		  ("\\.m4\\'" . m4-mode)
;; 		  ("\\.am\\'" . makefile-mode))
;; 		  auto-mode-alist))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; (set-fontset-font (frame-parameter nil 'font)
;;                   'han '("cwTeXHeiBold" . "unicode-bmp"))

;; This should fix the clipboard 
(setq x-select-enable-clipboard t)
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)

;; Other
(global-set-key [(meta g)] 'goto-line) 
(define-key global-map "\M-4" 'query-replace) 


;; Toggle fullscreen

(defvar my-fullscreen-p t "Check if fullscreen is on or off")

(defun my-non-fullscreen ()
  (interactive)
  (if (fboundp 'w32-send-sys-command)
	  ;; WM_SYSCOMMAND restore #xf120
	  (w32-send-sys-command 61728)
	(progn (set-frame-parameter nil 'width 82)
		   (set-frame-parameter nil 'fullscreen 'fullheight))))

(defun my-fullscreen ()
  (interactive)
  (if (fboundp 'w32-send-sys-command)
	  ;; WM_SYSCOMMAND maximaze #xf030
	  (w32-send-sys-command 61488)
	(set-frame-parameter nil 'fullscreen 'fullboth)))

(defun my-toggle-fullscreen ()
  (interactive)
  (setq my-fullscreen-p (not my-fullscreen-p))
  (if my-fullscreen-p
	  (my-non-fullscreen)
	(my-fullscreen)))


;; Using the f keys creatively
(global-set-key [f3] 'shell)
(global-set-key [f4] 'find-file)
(global-set-key [f5] 'compile)
(global-set-key [f6] 'align-regexp)
(global-set-key [f11] 'my-toggle-fullscreen)

(put 'downcase-region 'disabled nil)

(put 'upcase-region 'disabled nil)
