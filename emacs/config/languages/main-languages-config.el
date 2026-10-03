;; -*- lexical-binding: t -*-

;; --- Golang ---
(defun go-setup-hook ()
  "My standard settings for all go buffers"
  (setq-default tab-width 4)
  (setq-local indent-tabs-mode t)
  (setq-local go-ts-mode-indent-offset 4)
  (setq-local standard-indent 4)

  (add-hook 'before-save-hook #'eglot-format-buffer nil t))

(use-package go-mode
  :mode "\\.go\\'"
  :hook (go-mode . go-setup-hook))

(use-package go-ts-mode
  :ensure nil
  :mode "\\.go\\'"
  :hook (go-ts-mode . go-setup-hook))


(use-package flycheck-golangci-lint
  :hook ((go-mode go-ts-mode) . flycheck-golangci-lint-setup))

;; --- Haskell ---
(use-package haskell-mode
  :hook (haskell-mode . interactive-haskell-mode))

(use-package flycheck-haskell
  :hook (haskell-mode . flycheck-haskell-setup))


;; --- Perl ---
(use-package perl-mode
  :ensure nil
  :mode ("\\.pl\\'" "\\.pm\\'" "\\.plx\\'"))

(use-package perl-ts-mode
  :mode ("\\.pl\\'" "\\.pm\\'" "\\.plx\\'")
  :config
  (add-to-list 'treesit-language-source-alist
	           '(perl . ("https://github.com/tree-sitter-perl/tree-sitter-perl" "release")))
  (add-to-list 'treesit-language-source-alist
	     '(pod . ("https://github.com/tree-sitter-perl/tree-sitter-pod" "release"))))

;; --- Python ---
(use-package sphinx-doc
  :hook ((python-mode python-ts-mode) . sphinx-doc-mode))

(use-package cython-mode)

;; --- SQL ---
(use-package sqlformat
  :config
  (setq sqlformat-command 'pgformatter
        sqlformat-args '("-T" "-g"))
  :hook (sql-mode . sqlformat-on-save-mode))

;; --- JavaScript & TypeScript ---
;; Emacs 31 has excellent built-in ts-modes.
;; js2-mode is still great for extra syntax checks.
(use-package js2-mode
  :mode "\\.jsx?\\'"
  :config (setq js2-basic-offset 2))

(use-package typescript-mode
  :mode "\\.tsx?\\'")

;; --- Lisp ---
(use-package slime)
(when (file-exists-p "~/.quicklisp/slime-helper.el")
  (load (expand-file-name "~/.quicklisp/slime-helper.el"))
  (setq inferior-lisp-program "sbcl")
  (require 'slime)
  (slime-setup '(slime-fancy)))

;; --- GraphQL ---
(use-package graphql)
(use-package graphql-mode)

;; -- Kubernetes --
(use-package go-template-mode
  :mode (("\\.gotmpl\\'" . go-template-mode)
         ("\\.tpl\\'" . go-template-mode)
         ("\\.tmpl\\'" . go-template-mode)))

(defun my/go-template-helper-enable ()
  "Enable go-template-helper-mode when appropriate.
  Activates `go-template-helper-mode' if the buffer's file is located in a
  templates/ directory and has a .yaml, .yml, or .tpl extension."
  (when (and buffer-file-name
             (string-match-p
              "/templates/.*\\(?:\\.ya?ml\\|\\.tpl\\)\\'"
              buffer-file-name))
    (require 'go-template-helper-mode)
    (go-template-helper-mode 1)))

(use-package go-template-helper-mode
  :load-path "~/.emacs.d/lisp/go-template-helper-mode"
  :hook (yaml-mode . my/go-template-helper-enable))

(use-package go-template-helper-mode
  :load-path "~/.emacs.d/lisp/go-template-helper-mode"
  :hook ((yaml-mode . my/go-template-helper-enable)
         (yaml-ts-mode . my/go-template-helper-enable)))

(use-package yaml-pro)

(provide 'main-languages-config)
