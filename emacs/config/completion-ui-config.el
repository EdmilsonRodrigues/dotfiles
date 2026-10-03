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
  ;; Emacs 31 Bonus: Show documentation in a side-popup
  (corfu-popupinfo-mode 1)
  (setq corfu-popupinfo-delay 0.5))

(use-package nerd-icons
  :init
  (when (member "Symbols Nerd Font Mono" (font-family-list))
    (set-fontset-font t 'unicode (font-spec :family "Symbols Nerd Font Mono") nil 'append))
  :config
  (require 'nerd-icons))

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
  :hook (eglot-managed-mode . eldoc-box-hover-mode))

(provide 'completion-ui-config)
