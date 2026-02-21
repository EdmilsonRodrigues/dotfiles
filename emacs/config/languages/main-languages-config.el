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
  :mode "\\.ts\\'")

;; --- Lisp ---
(when (file-exists-p "~/.quicklisp/slime-helper.el")
  (load (expand-file-name "~/.quicklisp/slime-helper.el"))
  (setq inferior-lisp-program "sbcl"))

(provide 'main-languages-config)
