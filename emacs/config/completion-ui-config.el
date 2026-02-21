;; -*- lexical-binding: t -*-

(use-package corfu
  :ensure t
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
  :config
  (require 'nerd-icons))

(add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
  ;; Your custom mapping logic
  (setq nerd-icons-corfu-mapping
        '((array :style "cod" :icon "symbol_array" :face font-lock-type-face)
          (boolean :style "cod" :icon "symbol_boolean" :face font-lock-builtin-face)
          (file :fn nerd-icons-icon-for-file :face font-lock-string-face)
          (t :style "cod" :icon "code" :face font-lock-warning-face))))
;; The Custom interface is also supported for tuning the variable above.

(use-package eldoc-box
  ;; :config
  ;; ;; Customizing the look
  ;; (setq eldoc-box-max-pixel-width 600
  ;;       eldoc-box-max-pixel-height 400)
  :hook (eglot-managed-mode . eldoc-box-hover-mode))

(provide 'completion-ui-config)
