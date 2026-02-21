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

(provide 'init)
;; melpa stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil)
 '(safe-local-variable-values
   '((eval set (make-local-variable 'flycheck-go-build-tags)
           '("libsqlite3"))
     (go-test-args . "-tags libsqlite3 -timeout 120s"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
