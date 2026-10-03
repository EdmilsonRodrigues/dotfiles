;; -*- lexical-binding: t -*-

(use-package corfu
  :hook (prog-mode . corfu-mode)
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.1)
  (corfu-quit-at-boundary 'separator)
  (corfu-cycle t)
  (corfu-preselect 'prompt)
  :bind (:map corfu-map
              ("TAB" . corfu-next)
              ([tab] . corfu-next)
              ("S-TAB" . corfu-previous)
              ([backtab] . corfu-previous))
  :config
  (corfu-popupinfo-mode 1)
  (setq corfu-popupinfo-delay 0.5)

  (let ((bg-surface    "#232a2e")
        (bg-hover      "#3a454a")
        (fg-text       "#d3c6aa")
        (border-muted  "#2d3834")
        (accent-green  "#a7c080"))
    (custom-set-faces
     `(corfu-default ((t (:background ,bg-surface :foreground ,fg-text))))
     `(corfu-current ((t (:background ,bg-hover :foreground ,accent-green :weight bold))))
     `(corfu-border ((t (:background ,border-muted)))))))

(use-package nerd-icons
  :init
  (when (member "Symbols Nerd Font Mono" (font-family-list))
    (set-fontset-font t 'unicode (font-spec :family "Symbols Nerd Font Mono") nil 'append)))

(use-package nerd-icons-corfu
  :after corfu
  :init
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
  :config
  (setq nerd-icons-corfu-mapping
        '((array :style "cod" :icon "symbol_array" :face font-lock-type-face)
          (boolean :style "cod" :icon "symbol_boolean" :face font-lock-builtin-face)
          (file :fn nerd-icons-icon-for-file :face font-lock-string-face)
          (t :style "cod" :icon "code" :face font-lock-warning-face))))

(use-package eldoc-box
  :hook (eglot-managed-mode . eldoc-box-hover-mode)
  :config
  (set-face-attribute 'eldoc-box-border nil :background "#2d3834")
  (set-face-attribute 'eldoc-box-body nil :background "#232a2e" :foreground "#d3c6aa"))

(provide 'completion-ui-config)
