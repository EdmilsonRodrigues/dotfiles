;; -*- lexical-binding: t -*-

(use-package project
  :ensure nil
  :bind (("C-c p p" . project-switch-project)
         ("C-c p f" . project-find-file)
         ("C-c p g" . project-find-regexp)
         ("C-c p d" . project-dired)
         ("C-c p e" . project-eshell))
  :config
  ;; Tell project.el where your projects live so it can "discover" them
  (setq project-vc-extra-root-markers '(".git" ".project" "pyproject.toml" "go.mod"))

  ;; Make the project switcher use a more useful menu
  (setq project-switch-commands
        '((project-find-file "Find file")
          (project-find-regexp "Find regexp")
          (project-dired "Dired")
          (project-vc-dir "VC-Dir")
          (project-eshell "Eshell"))))

;; --- Dashboard ---
(use-package dashboard
  :config
  (setq dashboard-items '((recents . 5)
			              (projects . 5)
			              (bookmarks . 5)
			              (agenda . 5))
	    dashboard-banner-logo-title "Meu Dashboard!"
	    dashboard-startup-banner 'logo
	    dashboard-set-file-icons t
	    dashboard-icon-type 'all-the-icons
	    dashboard-projects-backend 'project-el
	    dashboard-set-init-info nil
	    dashboard-center-content t)

  (dashboard-setup-startup-hook)
  (setq dashboard-item-names '(("Recent Files:"               . "Arquivos recentes:")
			                   ("Projects:"                   . "Projetos")
                               ("Agenda for the coming week:" . "Agenda:"))))

;; --- Recent Files ---
(use-package recentf
  :ensure nil ;; Built-in
  :config
  (add-to-list 'recentf-exclude "~/.elfeed/*")
  (add-to-list 'recentf-exclude "~/.emacs.d/*")
  (add-to-list 'recentf-exclude "~/todos.org")
  (recentf-mode 1))

(provide 'projects-config)
