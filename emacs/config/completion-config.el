;; -*- lexical-binding: t -*-
;; Vertico
(use-package vertico
  :custom
  (vertico-count 20)
  (vertico-cycle t)
  :init
  (vertico-mode)
  :config
  ;; Everforest UI Injection for Vertico
  (let ((bg-hover      "#3a454a")
        (accent-green  "#a7c080"))
    (custom-set-faces
     `(vertico-current ((t (:background ,bg-hover :foreground ,accent-green :weight bold)))))))

(use-package savehist
  :init (savehist-mode))

(use-package vertico-directory
  :straight nil
  :after vertico
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil)
  (completion-pcm-leading-wildcard t))

(use-package consult
  :bind (("C-o" . consult-file)
         ("C-x d" . consult-dir)
         ("C-x b" . consult-buffer)
         ("C-c f" . consult-line)
         ("C-c C-l" . consult-goto-line))
  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format
        completion-in-region-function #'consult-completion-in-region)
  :config
  (setq consult-narrow-key "<")
  (autoload 'consult-project-buffer "consult"))

(use-package emacs
  :bind ("C-º" . execute-extended-command)
  :custom
  (context-menu-mode t)
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

(use-package consult-dir
  :bind (:map vertico-map
              ("C-d" . consult-dir)
              ("C-j" . consult-dir-jump-file)))

(use-package marginalia
  :init (marginalia-mode))

(use-package treesit-auto
  :custom (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package origami
  :hook (prog-mode . origami-mode)
  :bind (:map origami-mode-map
              ("<backtab>" . origami-toggle-node)
              ("C-<iso-lefttab>" . origami-toggle-all-nodes)))

(use-package yasnippet
  :init (yas-global-mode 1))

(provide 'completion-config)
