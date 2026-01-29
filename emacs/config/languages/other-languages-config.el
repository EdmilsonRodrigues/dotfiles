;; -*- lexical-binding: t -*-

;; --- Rust ---
(use-package rust-mode
  :mode "\\.rs\\'"
  :init
  (setq rust-format-on-save t)
  :config
  (add-hook 'rust-mode-hook #'prettify-symbols-mode))

;; --- Ruby ---
(use-package robe
  :hook (ruby-mode . robe-mode))

;; --- PHP ---
(use-package php-mode
  :mode "\\.php\\'")

;; --- Elixir ---
(use-package elixir-mode)
(use-package flycheck-credo
  :after flycheck
  :config (flycheck-credo-setup))

;; --- Erlang & Others ---
(use-package erlang)
(use-package solidity-mode)
(use-package crystal-mode)

(provide 'other-languages-config)
