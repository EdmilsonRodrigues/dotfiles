;; -*- lexical-binding: t -*-

;; --- Golang ---
(use-package go-mode
  :mode "\\.go\\'"
  :config
  (setq go-tab-width 4)
  ;; Eglot handles the LSP start, we handle the formatting:
  (add-hook 'before-save-hook #'eglot-format-buffer nil t))

(use-package flycheck-golangci-lint
  :hook ((go-mode go-ts-mode) . flycheck-golangci-lint-setup))

;; --- Haskell ---
(use-package haskell-mode
  :hook (haskell-mode . interactive-haskell-mode))

(use-package flycheck-haskell
  :hook (haskell-mode . flycheck-haskell-setup))

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
  :mode "\\.ts\\'")

;; --- Lisp ---
(when (file-exists-p "~/.quicklisp/slime-helper.el")
  (load (expand-file-name "~/.quicklisp/slime-helper.el"))
  (setq inferior-lisp-program "sbcl"))

(provide 'main-languages-config)
