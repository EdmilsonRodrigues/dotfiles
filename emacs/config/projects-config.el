;; -*- lexical-binding: t -*-

(defun my/ripgrep--argv (args)
  "Flatten ARGS into separate ripgrep argv strings (Projectile joins flags)."
  (let (out)
    (dolist (item (or args '()))
      (if (stringp item)
          (setq out (append out (split-string item "[ \t]+" t)))
        (setq out (append out (list item)))))
    out))

(defun my/ripgrep-regexp-shell-safe (regexp directory &optional args)
  "Like `ripgrep-regexp', but shell-quote every token (zsh-safe `--glob=!*')."
  (interactive
   (list (read-from-minibuffer "Ripgrep search for: "
                               (thing-at-point 'symbol))
         (read-directory-name "Directory: ")))
  (let* ((default-directory directory)
         (parts
          (append (list ripgrep-executable)
                  (my/ripgrep--argv ripgrep-arguments)
                  (my/ripgrep--argv args)
                  ripgrep--base-arguments
                  (when ripgrep-highlight-search '("--color=always"))
                  (when (and case-fold-search
                             (isearch-no-upper-case-p regexp t))
                    '("--ignore-case"))
                  '("--")
                  (list regexp)
                  '(".")))
         (command (mapconcat #'shell-quote-argument parts " ")))
    (compilation-start command 'ripgrep-search-mode)))

(use-package ripgrep
  :ensure t
  :config
  (when-let ((rg (or (executable-find "rg")
                      (executable-find "ripgrep"))))
    (setq ripgrep-executable rg))
  (advice-add #'ripgrep-regexp :override #'my/ripgrep-regexp-shell-safe))

(use-package projectile
  :ensure t
  :init
  ;; Must be set before `projectile-mode-map' is built (see `projectile-keymap-prefix').
  (setq projectile-keymap-prefix "C-c p"
        projectile-completion-system 'default
        projectile-project-search-path '("~/Documents/Projects/")
        projectile-sort-order 'recentf
        projectile-index-files-lighter nil
        projectile-project-root-files
        '(".git"          ; git
          ".project"      ; Emacs project marker
          "go.mod"
          "pyproject.toml"
          "Cargo.toml"
          "package.json"
          "Gemfile"
          "composer.json"
          "mix.exs"
          "project.clj"
          "deps.edn"
          "build.boot"
          "pom.xml"
          "build.sbt"))
  :bind
  ;; Top-level shortcuts (same prefix as before, now backed by Projectile).
  ("C-c p p" . projectile-switch-project)
  ("C-c p f" . projectile-find-file)
  ("C-c p g" . projectile-ripgrep)
  ("C-c p d" . projectile-dired)
  ("C-c p e" . projectile-run-eshell)
  ("C-c p b" . projectile-switch-to-buffer)
  :config
  (projectile-mode 1)
  (projectile-discover-projects-in-search-path)
  ;; Match your previous project.el ergonomics inside `C-c p …`.
  (define-key projectile-command-map (kbd "f") #'projectile-find-file)
  (define-key projectile-command-map (kbd "g") #'projectile-ripgrep)
  (define-key projectile-command-map (kbd "e") #'projectile-run-eshell))

;; Built-in project.el still backs eglot, magit, and consult-project-buffer.
(use-package project
  :ensure nil
  :straight nil
  :after projectile
  :config
  (setq project-vc-extra-root-markers
        '(".git" ".project" "pyproject.toml" "go.mod")))

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
        dashboard-projects-backend 'projectile
        dashboard-set-init-info nil
        dashboard-center-content t)
  (dashboard-setup-startup-hook)
  (setq dashboard-item-names '(("Recent Files:" . "Arquivos recentes:")
                               ("Projects:" . "Projetos")
                               ("Agenda for the coming week:" . "Agenda:"))))

(use-package recentf
  :ensure nil
  :straight nil
  :config
  (add-to-list 'recentf-exclude "~/.elfeed/*")
  (add-to-list 'recentf-exclude "~/.emacs.d/*")
  (add-to-list 'recentf-exclude "~/todos.org")
  (recentf-mode 1))

(provide 'projects-config)
