(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "ASCII")
 '(global-font-lock-mode t nil (font-lock))
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

(require 'cc-mode)
(load "font-lock")

;; Inicio

(setq default-major-mode 'c++-mode) 
(setq inhibit-startup-message t)	
(setq make-backup-files nil) 
(setq user-mail-address "diegoeche@gmail.com")
(setq user-full-name "Diego Echeverri")
(global-set-key [(meta g)] 'goto-line) 
(define-key global-map "\M-4" 'query-replace) 
(server-mode)

;; Identacion
(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-style "k&r")
            (setq c-basic-offset 4)))

;;; Modes

;;; Shell mode
(setq ansi-color-names-vector ; better contrast colors
      ["black" "red4" "green4" "yellow4"
       "blue3" "magenta4" "cyan4" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)



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



;; Jabber

(add-to-list 'load-path "~/lib/emacs-jabber-0.7.1/")
(require 'jabber)

(if (and (boundp 'window-system) window-system)
    (when (string-match "XEmacs" emacs-version)
       	(if (not (and (boundp 'mule-x-win-initted) mule-x-win-initted))
            (require 'sym-lock))
       	(require 'font-lock)))


(setq load-path (cons "~/lib/haskell-mode-2.3" load-path))
(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.[hg]s$"  . haskell-mode)
                ("\\.hi$"     . haskell-mode)
                ("\\.l[hg]s$" . literate-haskell-mode))))
(autoload 'haskell-mode "haskell-mode"
  "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
  "Major mode for editing literate Haskell scripts." t)


(add-hook 'haskell-mode-hook 'turn-on-haskell-font-lock)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)

(setq load-path (cons "~/lib" load-path))
(setq load-path (cons "~/lib/themes" load-path))
(setq load-path (cons "~/lib/ruby" load-path))
(load "lib")
(load "color-theme")
(load "color-theme-autoloads")
(load "color-theme-library")

;;(require 'ruby-mode)
(load "inf-ruby")
(load "rubydb3x")

(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode)))

(autoload 'ruby-mode "ruby-mode" "Ruby editing mode." t)
(add-to-list 'auto-mode-alist '("\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;; Colores

(color-theme-comidia)
;; Stuff

(setq search-highlight t)
(setq query-replace-highlight t)

(setq default-fill-column 77)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'c++-mode-hook 'turn-on-auto-fill)
(add-hook 'c-mode-hook 'turn-on-auto-fill)
(add-hook 'ruby-mode-hook 'turn-on-auto-fill)

(setq next-line-add-newlines nil)

; Para que se marquen los paréntesis y 
; y las llaves
(require 'paren)  

(setq c-tab-always-indent "other") 
 
(setq-default indent-tabs-mode nil) ; Espacios en vez de tabuladores

;; Coloreado automático de sintaxis para todos los modos reconocidos
(global-font-lock-mode t)
(setq font-lock-support-mode 'lazy-lock-mode)
(setq font-lock-maximum-size nil)       
(require 'font-lock)
(require 'lazy-lock)

(setq auto-mode-alist
        (append '(
		  ("configure.in" . m4-mode)
		  ("\\.m4\\'" . m4-mode)
		  ("\\.am\\'" . makefile-mode))
		  auto-mode-alist))

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

(set-default-font "Consolas-14")
(set-fontset-font (frame-parameter nil 'font)
                  'han '("cwTeXHeiBold" . "unicode-bmp"))

;; This should fix the clipboard 
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)
(global-set-key [f3] 'shell)
(global-set-key [f4] 'find-file)
(global-set-key [f5] 'compile)
(global-set-key [f6] 'goto-line)
