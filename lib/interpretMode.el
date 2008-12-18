(require 'comint)

(defgroup inferior-fsharp
  nil
  "Mode to interact with a Fsharp interpreter."
  :group 'fsharp
  :tag "Inferior Fsharp")

(defcustom fsharp-interpreter "mono /home/diegoeche/Desktop/FSharp-1.9.6.2/bin/fsi.exe --no-gui"
	  "The interpreter that `run-fsharp' should run. This should
	 be a program in your PATH or the full pathname of the fsharp interpreter."
	  :type 'string)
	
(defconst fsharp-inf-buffer-name "*inferior-fsharp*")

(defun fsharp-interpreter-running ()
  ;; True iff a Fsharp interpreter is currently running in a buffer.
  (comint-check-proc fsharp-inf-buffer-name))

(defun left-trim (s)
  (string-match "^[\t\r\n ]*" s)
  (replace-match "" nil nil s)
  )

(defun right-trim (s)
  (string-match "[\t\r\n ]*$" s)
  (replace-match "" nil nil s)
  )

(defun trim (s)
  (right-trim (left-trim s))
  )

(defun fsharp-eval-region (start end)
  "Send current region to Fsharp interpreter."
  (interactive "r")
  (fsharp-interpreter-running)
  (comint-send-string fsharp-inf-buffer-name 
                      (concat 
                       (trim                       
                        (buffer-substring-no-properties start end))
                       ";;\n")))

(defun fsharp-switch-to-interpreter ()
  "Switch to buffer containing the interpreter"
  (interactive)
  (fsharp-interpreter-running)
  (switch-to-buffer fsharp-inf-buffer-name))

(local-set-key (kbd "M-<return>") 'fsharp-eval-region)

(defun run-fsharp (cmd-line)
  "Run a Fsharp interpreter in an Emacs buffer"
  (interactive (list (if current-prefix-arg
                         (read-string "Fsharp interpreter: " fsharp-interpreter)
                       fsharp-interpreter)))
  (unless (fsharp-interpreter-running)
    (setq fsharp-interpreter cmd-line)
    (let ((cmd/args (split-string cmd-line)))
      (set-buffer
       (apply 'make-comint "inferior-fsharp" (car cmd/args) nil (cdr cmd/args))))
    (pop-to-buffer fsharp-inf-buffer-name)))