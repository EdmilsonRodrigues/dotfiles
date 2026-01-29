;; -*- lexical-binding: t -*-

(use-package web-mode
  :mode ("\\.phtml\\'" "\\.html?\\'" "\\.js[x]\\'" "\\.ts[x]\\'")
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-css-indent-offset 2))

(use-package emmet-mode
  :hook (css-mode-hook sgml-mode-hook web-mode-hook)
  :config (setq emmet-expand-at-paired-tag t))

(use-package simple-httpd)
(use-package impatient-mode)

(provide 'web-config)
