(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-firefox))
 '(case-fold-search t)
 '(current-language-environment "ASCII")
 '(global-font-lock-mode t nil (font-lock))
 '(haskell-font-lock-symbols t)
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

;; autofill
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Haskell Customizations
(add-to-list 'load-path "~/lib/haskell-mode-2.6/")
(load "~/lib/haskell-mode-2.6/haskell-site-file")
(add-hook 'haskell-mode-hook
          '(lambda () (setq haskell-program-name "~/lib/haskell-mode-2.6/ghci-no-tty.sh")))

;; Small function for evaluating selected code
(defun inferior-haskell-eval-region (start end)
  "Send the current region to the inferior fsharp process."
  (interactive "r")
  (save-excursion
    (goto-char end)
    (inferior-haskell-send-command (inferior-haskell-process) (buffer-substring start end))))
(load "~/lib/haskell-mode-2.6/hs-lint")

(require 'hs-lint)
(defun my-haskell-mode-hook ()
  (local-set-key "\C-c\C-r" 'inferior-haskell-eval-region)
  (local-set-key "\C-cl" 'hs-lint))
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)

(require 'flymake)

(defun flymake-Haskell-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-with-folder-structure nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-Haskell-cmdline))

(defun flymake-get-Haskell-cmdline (source base-dir)
  (list "flycheck_haskell.pl"
        (list source base-dir)))

(push '(".+\\.hs$" flymake-Haskell-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)

(push '(".+\\.lhs$" flymake-Haskell-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)
(push
 '("^\\(\.+\.hs\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)"
   1 2 3 4) flymake-err-line-patterns)

(defun credmp/flymake-display-err-minibuf () 
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 
                                   (flymake-find-err-info 
                                    flymake-err-info 
                                    line-no)))
         (count               (length line-err-info-list))
         )
    (while (> count 0)
      (when line-err-info-list
        (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file 
                (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)
          )
        )
      (setq count (1- count)))))

;; Display error in minibuffer
(add-hook
 'haskell-mode-hook
 '(lambda ()
    (define-key haskell-mode-map "\C-cd"
      'credmp/flymake-display-err-minibuf)))

;; optional setting
;; if you want to use flymake always, then add the following hook.
(add-hook
 'haskell-mode-hook
 '(lambda ()
    (if (not (null buffer-file-name)) (flymake-mode))))

;; Other legacy stuff

(setq load-path (cons "~/lib" load-path))
(setq load-path (cons "~/lib/themes" load-path))
(load "lib")
(load "color-theme")
(load "color-theme-autoloads")
(load "color-theme-library")

;; (set-default-font "Consolas-13")
(set-default-font "Dejavu Sans Mono 13")
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

;; Date Insertion

(defun date (arg)
  (interactive "P")
  (insert (if arg
              (format-time-string "%d.%m.%Y")
            (format-time-string "%Y-%m-%d"))))

(defun timestamp ()
  (interactive)
  (insert (format-time-string "%Y-%m-%dT%H:%M:%S")))


;; Tabs replacement
(setq-default indent-tabs-mode nil)

(defun google-region (beg end)
  "Google the selected region."
  (interactive "r")
  (browse-url (concat
               "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
               (buffer-substring beg end))))

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; This should fix the clipboard
(setq x-select-enable-clipboard t)
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)

;; Other
(global-set-key [(meta g)] 'goto-line)
(define-key global-map "\M-4" 'query-replace)

;; Show the trailing whitespace
(setq-default show-trailing-whitespace t)

;; Enable this commands
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; (setq starttls-use-gnutls t)

(setq send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials
      '(("smtp.gmail.com" 587 nil nil))
       smtpmail-auth-credentials
       (expand-file-name "~/.authinfo")
       smtpmail-default-smtp-server "smtp.gmail.com"
       smtpmail-smtp-server "smtp.gmail.com"
       smtpmail-smtp-service 587
       smtpmail-debug-info t)

(require 'smtpmail)

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


