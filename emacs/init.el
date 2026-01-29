;; -*- lexical-binding: t -*-

;; Load my configuration path
(add-to-list 'load-path "~/.emacs.d/config/")
(add-to-list 'load-path "~/.emacs.d/config/languages")

;; Load my configurations
(require 'packages-config)
(require 'keybindings-config)
(require 'gui-config)
(require 'completion-config)
(require 'completion-ui-config)
(require 'main-languages-config)
(require 'other-languages-config)
(require 'tooling-languages-config)
(require 'projects-config)
(require 'git-config)
(require 'lsp-config)
(require 'org-config)
(require 'web-config)

;; melpa stuff

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279"
     "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e"
     "7334f761edfccfa87893211f651220a0899bb206f042b856393b7af22b0413e2"
     default))
 '(package-selected-packages
   '(ac-php ace-window alchemist all-the-icons bazel centaur-tabs
            cfn-mode company-anaconda company-dict company-emoji
            company-erlang company-fuzzy company-go company-irony
            company-math company-nginx company-shell company-web
            consult consult-dir corfu corfu-terminal
            counsel-projectile crystal-mode cython-mode dashboard
            diff-hl dockerfile-mode dpkg-dev-el editorconfig ein
            eldoc-box emmet-mode emojify ergoemacs-mode flycheck-cfn
            flycheck-credo flycheck-eglot flycheck-golangci-lint
            flycheck-haskell flycheck-inline flycheck-mypy go-eldoc
            impatient-mode ini-mode jedi js2-mode kind-icon lazy-ruff
            lsp-ivy lsp-ui magit marginalia mason neotree
            nerd-icons-corfu orderless org-bullets org-download
            org-project-capture org-roam org-superstar origami
            protobuf-mode robe rust-mode shell-pop simple-httpd
            solidity-flycheck solidity-mode spaceline sphinx-doc
            sqlformat tide toc-org toml-mode treesit-auto try
            typescript-mode vertico vertico-directory web-mode
            yaml-mode))
 '(safe-local-variable-directories '("/home/familia/Documents/Work/sipub/"))
 '(shell-pop-shell-type
   '("ansi-term" "*shell-pop-ansi-term*"
     (lambda nil (ansi-term shell-pop-term-shell))))
 '(shell-pop-term-shell "/bin/bash")
 '(shell-pop-universal-key "C-'")
 '(shell-pop-window-position "bottom")
 '(shell-pop-window-size 30))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
