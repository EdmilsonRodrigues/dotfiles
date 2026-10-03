;; -*- lexical-binding: t -*-
(require 'magit)
(require 'project)

(defun my/cursor-agent-start ()
  "Start the Cursor Agent CLI in a split window at the project root."
  (let* ((proj (project-current t))
         (root (project-root proj))
         (default-directory root))
    (make-comint-in-buffer "Cursor Agent" "*Cursor Agent*" "cursor-agent" nil "")
    (pop-to-buffer "*Cursor Agent*")
    (comint-mode)
    (message "Cursor Agent started in %s" root)))

(defun my/cursor-agent-entry ()
  "Entry point bound to C-x M-c.
Checks for unstaged changes, handles staging, shows diff against HEAD,
or falls back to magit-status if no commits exist yet."
  (interactive)
  (let* ((proj (project-current t))
         (root (project-root proj))
         (default-directory root)
         (proceed t))

    ;; 1. Check for unstaged changes first
    (when (magit-anything-unstaged-p)
      (if (y-or-n-p "Unstaged changes exist. Stage them all with Magit? ")
          (progn
            (magit-stage-modified t)
            (message "Staged all unstaged changes."))
        (setq proceed nil))
      (condition-case nil
          (progn
            (magit-diff-range "HEAD")
            (if (y-or-n-p "Proceed to start Cursor Agent with these changes? ")
                (message "Cursor Agent start cancelled.")
              (setq proceed t)))
        (error
         (message "No commits found or diff failed. Opening Magit Status...")
         (magit-status root))))

    ;; 2. If cleared, show diff range and handle first-commit fallback
    (when proceed
      (my/cursor-agent-start))))

;; Bind to C-x M-c globally
(global-set-key (kbd "C-x M-c") #'my/cursor-agent-entry)

(provide 'llm-config)
