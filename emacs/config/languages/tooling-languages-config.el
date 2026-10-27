;; -*- lexical-binding: t -*-

(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(use-package protobuf-mode
  :config
  (defconst my-protobuf-style
    '((c-basic-offset . 4)
      (indent-tabs-mode . t)))
  (add-hook 'protobuf-mode-hook
            (lambda () (c-add-style "my-style" my-protobuf-style t))))

(use-package bazel)

(use-package editorconfig
  :config (editorconfig-mode 1))

;; Tree-sitter handles YAML, but we keep the mode for non-TS fallbacks
(use-package yaml-mode
  :mode ("\\.ya?ml\\'" "user-data\\'"))

(use-package toml-mode)
(use-package ini-mode
  :mode "\\.ini\\'")

(use-package conf-mode
  :ensure nil
  :straight nil
  :mode ("\\.conf\\'" "\\.cfg\\'" "\\..*ignore\\'" "\\.env[\\..*]?\\'" "\\.lock\\'"))

(use-package cfn-mode)

(use-package flycheck-cfn)

(use-package terraform-mode)

(flycheck-cfn-setup)

(use-package jsonnet-mode
  :mode "\\.jsonnet\\'"
  :config
  ;; Automatically format buffer on save using jsonnetfmt (optional)
  (add-hook 'jsonnet-mode-hook
            (lambda ()
              (add-hook 'before-save-hook #'jsonnet-reformat-buffer nil t))))

(use-package logview)

(defconst my/zeal-executable "/snap/bin/zeal"
  "Zeal binary from the snap package (see `snap install zeal').")

(defun my/zeal-executable ()
  "Return a usable Zeal executable, preferring the snap install."
  (or (and (file-executable-p my/zeal-executable) my/zeal-executable)
      (executable-find "zeal")))

(defun my/zeal--version (zeal)
  (when-let* ((output (with-temp-buffer
                        (call-process zeal nil t nil "--version")
                        (buffer-string))))
    (when (string-match "Zeal \\([[:digit:]\\.]+\\)" output)
      (match-string 1 output))))

(defun my/zeal-at-point-run-search (search)
  (if-let ((zeal (my/zeal-executable)))
      (start-process "Zeal" nil zeal search)
    (user-error "Zeal not found (expected `%s' or `zeal' on PATH)"
                my/zeal-executable)))

(use-package zeal-at-point
  :ensure t
  :init
  (add-to-list 'exec-path "/snap/bin" t)
  :bind
  (("C-c z z" . zeal-at-point)
   ("C-c z s" . zeal-at-point-set-docset))
  :config
  (advice-add #'zeal-at-point-run-search :override #'my/zeal-at-point-run-search)
  (when-let* ((zeal (my/zeal-executable)))
    (setq zeal-at-point-zeal-version (my/zeal--version zeal)))
  (dolist (entry '((go-ts-mode . "go")
                   (python-ts-mode . "python3")
                   (js-ts-mode . "javascript")
                   (js-jsx-mode . "javascript")
                   (typescript-mode . "typescript")
                   (typescript-ts-mode . "typescript")
                   (ts-mode . "typescript")
                   (tsx-ts-mode . "typescript")
                   (rust-ts-mode . "rust")
                   (perl-ts-mode . "perl")
                   (php-ts-mode . "php")
                   (c-ts-mode . "c")
                   (c++-ts-mode . "cpp")
                   (bash-ts-mode . "bash")
                   (sh-ts-mode . "bash")
                   (haskell-ts-mode . "haskell")
                   (yaml-ts-mode . "yaml")
                   (terraform-mode . "terraform")
                   (terraform-ts-mode . "terraform")
                   (graphql-mode . "graphql")
                   (solidity-mode . "solidity")
                   (crystal-mode . "crystal")))
    (add-to-list 'zeal-at-point-mode-alist entry)))

(provide 'tooling-languages-config)
