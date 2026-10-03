;; -*- lexical-binding: t -*-

(use-package mason
  :config
  (mason-setup)
  (dolist (pkg '("zuban" "marksman" "ltex-ls" "typos-lsp"
                 "shellcheck" "gopls" "qmlls" "rust-analyzer"
                 "yaml-language-server" "haskell-language-server"
                 "clangd" "intelephense" "typescript-language-server"
                 "java-language-server" "protols" "ruby-lsp"
                 "docker-language-server" "angular-language-server"
                 "sqlls" "sqlfluff" "sql-formatter" "terraform-ls"
                 "nomicfoundation-solidity-language-server" "perlnavigator"
                 "graphql-language-service-cli"))
      (unless (mason-installed-p pkg)
        (ignore-errors (mason-install pkg)))))

(use-package eglot
  :ensure nil
  :defer t
  :hook (((python-mode python-ts-mode go-mode go-ts-mode
           rust-mode rust-ts-mode ruby-mode ruby-ts-mode
           crystal-mode crystal-ts-mode js-mode js-jsx-mode js-ts-mode
           sh-mode sh-ts-mode bash-mode bash-ts-mode php-mode php-ts-mode
           typescript-mode typescript-ts-mode c-mode c-ts-mode
           c++-mode c++-ts-mode haskell-mode haskell-ts-mode
           yaml-mode yaml-ts-mode sql-mode markdown-mode org-mode
           solidity-mode solidity-ts-mode perl-mode perl-ts-mode
           ts-mode tsx-ts-mode terraform-mode terraform-ts-mode
           graphql-mode) . eglot-ensure)
         (python-ts-mode . (lambda () (set-fill-column 79))))
  :config
  (setq eglot-server-programs
        '(((python-mode python-ts-mode)         . ("rass" "python"))
          ((markdown-mode)                      . ("rass" "markdown"))
          ((go-mode go-ts-mode)                 . ("rass" "go"))
          ((sql-mode)                           . ("rass" "sql"))
          ((bash-mode bash-ts-mode sh-mode sh-ts-mode) . ("rass" "bash"))
          ((php-mode php-ts-mode)               . ("rass" "php"))
          ((rust-mode rust-ts-mode)             . ("rass" "rust"))
          ((typescript-mode typescript-ts-mode ts-mode tsx-ts-mode) . ("rass" "typescript"))
          ((c-mode c-ts-mode)                   . ("rass" "c"))
          ((c++-mode c++-ts-mode)               . ("rass" "c"))
          ((haskell-mode haskell-ts-mode)       . ("rass" "haskell"))
          ((yaml-mode yaml-ts-mode)             . ("rass" "yaml"))
          ((solidity-mode solidity-ts-mode)     . ("rass" "solidity"))
          ((perl-mode perl-ts-mode)             . ("rass" "perl"))
          ((terraform-mode terraform-ts-mode)   . ("rass" "terraform"))
          ((graphql-mode)                       . ("rass" "graphql"))
          ((org-mode)                           . ("rass" "org"))))
  (setq-default
   eglot-workspace-configuration
   '(:ltex
     (:language ["pt-BR" "en-US"]
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
