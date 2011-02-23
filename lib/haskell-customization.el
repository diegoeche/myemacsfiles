

;; Haskell Customizations
(add-to-list 'load-path "~/lib/haskell-mode-2.6/")
(load "~/lib/haskell-mode-2.6/haskell-site-file")
(add-hook 'haskell-mode-hook
          '(lambda () (setq haskell-program-name "~/lib/haskell-mode-2.6/ghci-no-tty.sh")))

;; Small function for evaluating selected code
(defun inferior-haskell-eval-region (start end)
  "Send the current region to the inferior haskell process."
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

;; if you want to use flymake always, then add the following hook.
(add-hook
 'haskell-mode-hook
 '(lambda ()
    (if (not (null buffer-file-name)) (flymake-mode))))

;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)



