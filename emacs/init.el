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
