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
  :ensure t
  :config (editorconfig-mode 1))

;; Tree-sitter handles YAML, but we keep the mode for non-TS fallbacks
(use-package yaml-mode
  :mode "\\.ya?ml\\'")

(use-package toml-mode)
(use-package ini-mode
  :mode "\\.ini\\'")

(use-package cfn-mode)

(use-package flycheck-cfn)

(flycheck-cfn-setup)

(provide 'tooling-languages-config)
