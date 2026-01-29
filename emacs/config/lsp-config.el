;; -*- lexical-binding: t -*-

(use-package mason
  :config
  (mason-setup)
  (dolist (pkg '("zuban" "ruff" "marksman" "ltex-ls" "typos-lsp"
                 "shellcheck" "gopls" "qmlls" "rust-analyzer"
                 "yaml-language-server" "haskell-language-server"
                 "clangd" "intelephense" "typescript-language-server"
                 "java-language-server" "protols" "ruby-lsp"
                 "docker-language-server" "angular-language-server"
                 "sqlls" "sqlfluff" "sql-formatter"
                 "nomicfoundation-solidity-language-server"))
      (unless (mason-installed-p pkg)
        (ignore-errors (mason-install pkg)))))

(use-package eglot
  :defer t
  :hook ((python-mode . eglot-ensure)
         (python-ts-mode . eglot-ensure)
         (go-mode . eglot-ensure)
         (go-ts-mode . eglot-ensure)
         (rust-mode . eglot-ensure)
         (rust-ts-mode . eglot-ensure)
         (ruby-mode . eglot-ensure)
         (ruby-ts-mode . eglot-ensure)
         (crystal-mode . eglot-ensure)
         (crystal-ts-mode . eglot-ensure)
         (bash-mode . eglot-ensure)
         (bash-ts-mode . eglot-ensure)
         (php-mode . eglot-ensure)
         (php-ts-mode . eglot-ensure)
         (typescript-mode . eglot-ensure)
         (typescript-ts-mode . eglot-ensure)
         (c-mode . eglot-ensure)
         (c-ts-mode . eglot-ensure)
         (c++-mode . eglot-ensure)
         (c++-ts-mode . eglot-ensure)
         (haskell-mode . eglot-ensure)
         (haskell-ts-mode . eglot-ensure)
         (yaml-mode . eglot-ensure)
         (yaml-ts-mode . eglot-ensure)
         (sql-mode . eglot-ensure)
         (markdown-mode . eglot-ensure)
         (org-mode . eglot-ensure)
         (solidity-mode . eglot-ensure)
         (solidity-ts-mode . eglot-ensure)
         (python-ts-mode . (lambda () (set-fill-column 79))))
  :config
  (setq eglot-server-programs
        '(((python-mode python-ts-mode)         . ("rass" "python"))
          ((markdown-mode)                      . ("rass" "markdown"))
          ((go-mode go-ts-mode)                 . ("rass" "go"))
          ((sql-mode)                           . ("rass" "sql"))
          ((bash-mode bash-ts-mode)             . ("rass" "bash"))
          ((php-mode php-ts-mode)               . ("rass" "php"))
          ((rust-mode rust-ts-mode)             . ("rass" "rust"))
          ((typescript-mode typescript-ts-mode) . ("rass" "typescript"))
          ((c-mode c-ts-mode)                   . ("rass" "c"))
          ((c++-mode c++-ts-mode)               . ("rass" "c"))
          ((haskell-mode haskell-ts-mode)       . ("rass" "haskell"))
          ((yaml-mode yaml-ts-mode)             . ("rass" "yaml"))
          ((solidity-mode solidity-ts-mode)     . ("rass" "solidity"))
          ((org-mode)                           . ("rass" "org"))))
  (setq-default
   eglot-workspace-configuration
   '(
     :ltex
     (:language "pt-BR" ;["pt-BR" "en-US"]
      :additionalRules (:enablePickyRules t
			:motherTongue "pt-BR")
      :disabledRules (:pt-BR ["PT_SMART_QUOTES" "ELLIPSIS"])
      :completionEnabled t))))

(use-package flycheck
 :diminish flycheck-mode
 :init
 (setq
   flycheck-check-syntax-automatically '(save new-line)
   flycheck-idle-change-delay 5.0
   flycheck-display-errors-delay 0.9
   flycheck-highlighting-mode 'symbols
   flycheck-indication-mode 'left-fringe
   flycheck-standard-error-navigation t
   flycheck-deferred-syntax-check nil))

(use-package flycheck-eglot
  :after (flycheck eglot)
  :config (global-flycheck-eglot-mode 1))

(use-package flycheck-inline
  :hook (flycheck-mode . flycheck-inline-mode))

(provide 'lsp-config)
