;; -*- lexical-binding: t -*-

;; --- Use GNU Emacs as $EDITOR for child processes ---
(use-package with-editor)

;; --- Magit ---
(use-package magit
  :bind ("C-x g" . magit-status))

;; Diff Highlighting
(use-package diff-hl
  :config
  (global-diff-hl-mode)
  ;; This updates the fringe signs immediately after you stage changes in Magit
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(provide 'git-config)
