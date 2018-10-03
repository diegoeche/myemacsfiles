(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 0.01)
 '(ac-delay 0.01)
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "open")
 '(case-fold-search t)
 '(current-language-environment "ASCII")
 '(explicit-bash-args (quote ("--noediting" "-i" "-l")))
 '(g-xslt-program "iconv -ct utf-8 | xsltproc")
 '(global-font-lock-mode t nil (font-lock))
 '(js-indent-level 2)
 '(jsx-indent-level 2)
 '(mouse-wheel-mode t nil (mwheel))
 '(package-selected-packages
   (quote
    (kotlin-mode yaml-mode go-mode ponylang-mode company jedi web-mode solarized-theme scss-mode rust-mode org omnisharp monokai-theme monokai-alt-theme markdown-mode lua-mode jsx-mode haxe-mode haml-mode git-link gist flycheck-haskell f erlang ensime draft-mode color-theme-solarized cider alchemist)))
 '(python-environment-virtualenv
   (quote
    ("/usr/local/bin/virtualenv" "--system-site-packages" "--quiet")))
 '(show-paren-mode t nil (paren))
 '(standard-indent 2)
 '(transient-mark-mode t)
 '(visible-bell nil)
 '(web-mode-attr-indent-offset 2)
 '(web-mode-block-padding 2)
 '(web-mode-code-indent-offset 2)
 '(web-mode-css-indent-offset 2)
 '(web-mode-markup-indent-offset 2)
 '(web-mode-script-padding 2))


(display-time)
(column-number-mode 1)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; Autofill
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; ;; stuff
(setq search-highlight t)
(setq query-replace-highlight t)
(setq default-fill-column 85)
(setq next-line-add-newlines nil)

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; This should fix the clipboard
(setq x-select-enable-clipboard t)
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)

;; OSX remapping
(setq mac-command-modifier 'meta)
(setq ring-bell-function 'ignore)


;; ;; Other
(global-set-key [(meta g)] 'goto-line)
(define-key global-map "\M-4" 'query-replace)

;; ;; Show the trailing whitespace
(setq-default show-trailing-whitespace t)

;; ;; Automatically clean up bad whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; ;; Enable this commands
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Using the f keys creatively
(global-set-key [f3] 'shell)
(global-set-key [f4] 'locate)
(global-set-key [f5] 'align-regexp)

(global-auto-revert-mode t)

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(load-theme 'monokai t)
;; 5mof
(set-default-font "Inconsolata 24")

(when (not package-archive-contents)
  (package-refresh-contents))

;; Don't ask for confirmation to delete marked buffers
(setq ibuffer-expert t)
