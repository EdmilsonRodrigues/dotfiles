;; -*- lexical-binding: t -*-

;; --- Table of Contents ---
(use-package toc-org
  :hook (org-mode . toc-org-mode)
  :hook (markdown-mode . toc-org-mode)
  :bind (:map markdown-mode-map ("C-c C-o" . toc-org-markdown-follow-thing-at-point)))

;; --- Org GUI ---
(use-package org-superstar
  :hook (org-mode . org-superstar-mode))

;; --- Projects ---
(use-package org-project-capture
  :bind (("C-c n p" . org-project-capture-project-todo-completing-read))
  :ensure t
  :config
  (progn
    (setq org-project-capture-backend
          (make-instance 'org-project-capture-projectile-backend))  ; Replace with your backend of choice
    (setq org-project-capture-projects-file "~/org/projects.org")
    (org-project-capture-single-file)))

;; (use-package org-roam
;;   :ensure t)

(use-package org-download)

;; --- Keys recommended by the orgguide ---
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; --- Key bindings for org ---
(use-package org
  :bind (:map org-mode-map
         ("C-c <left>" . org-do-promote)
         ("C-c <right>" . org-do-demote)
         ("C-c <up>" . org-move-subtree-up)
         ("C-c <down>" . org-move-subtree-down)
         ("C-S-<iso-lefttab>" . org-cycle)
         ("C-c C-<up>" . org-move-item-up)
         ("C-c C-<down>" . org-move-item-down)))

(provide 'org-config)
