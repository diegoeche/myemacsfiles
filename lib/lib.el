;;
;; Never understood why Emacs doesn't have this function.
;;
(defun rename-file-and-buffer (new-name)
 "Renames both current buffer and file it's visiting to NEW-NAME." 
 (interactive "sNew name: ")
 (let ((name (buffer-name))
       (filename (buffer-file-name)))
   (if (not filename)
       (message "Buffer '%s' is not visiting a file!" name)
     (if (get-buffer new-name)
	 (message "A buffer named '%s' already exists!" new-name)
       (progn (rename-file name new-name 1) 
              (rename-buffer new-name) 
              (set-visited-file-name new-name) 
              (set-buffer-modified-p nil))))))

;; Mueve el buffer al directorio seleccionado
(defun move-buffer-file (dir)
 "Moves both current buffer and file it's visiting to DIR." (interactive "DNew directory: ")
 (let* ((name (buffer-name))
	 (filename (buffer-file-name))
	 (dir
	 (if (string-match dir "\\(?:/\\|\\\\)$")
	 (substring dir 0 -1) dir))
	 (newname (concat dir "/" name)))
   (if (not filename)
       (message "Buffer '%s' is not visiting a file!" name)
     (progn (copy-file filename newname 1) 	
            (delete-file filename) 	
            (set-visited-file-name newname)	
            (set-buffer-modified-p nil) t))))

;; Date Insertion
(defun date (arg)
  (interactive "P")
  (insert (if arg
              (format-time-string "%d.%m.%Y")
            (format-time-string "%Y-%m-%d"))))

(defun timestamp ()
  (interactive)
  (insert (format-time-string "%Y-%m-%dT%H:%M:%S")))

;; Useful functions to generate sequential numbers.
(defun clear-number ()
  (interactive)
  (setq a 0))

(defun new-number ()
  (interactive)
  (insert (number-to-string a))
  (setq a (+ a 1)))

;; Google region
(defun google-region (beg end)
  "Google the selected region."
  (interactive "r")
  (browse-url (concat
               "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
               (buffer-substring beg end))))

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
