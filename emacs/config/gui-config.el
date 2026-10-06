;; -*- lexical-binding: t -*-

;; --- Startup && Backups ---
(setq inhibit-startup-message t
      initial-buffer-choice  nil
      initial-scratch-message nil
      auto-save-default nil
      make-backup-files nil
      display-warning-minimum-level :error)

;; --- UI Elements ---
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(setopt display-fill-column-indicator-column 80)

;; --- Modes ---
(ido-mode 0)
(cua-mode 1)
(display-time-mode 1)
(add-hook 'prog-mode-hook #'hs-minor-mode)
(add-hook 'prog-mode-hook #'hl-line-mode)

;; --- Theme && Fonts (Enchanted Forest Injection) ---
(set-face-attribute 'default nil :height 135 :family "Maple Mono")
(setq ring-bell-function 'ignore)

(straight-use-package
 '(everforest :type git :host github :repo "Theory-of-Everything/everforest-emacs"))

(load-theme 'everforest-hard-dark t)

;; --- Icons ---
(use-package all-the-icons
  :if (display-graphic-p))

;; --- Navigation && Windows ---
(use-package ace-window
  :bind (("C-x o" . ace-window))
  :custom
  (aw-keys '(?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8 ?9)))

(global-set-key (kbd "C-<tab>") 'other-window)

;; --- Tabs ---
(global-unset-key (kbd "C-x <prior>"))
(global-unset-key (kbd "C-x <next>"))

(use-package centaur-tabs
  :demand
  :config
  (setq centaur-tabs-style "bar"
        centaur-tabs-set-bar 'over
        centaur-tabs-set-modified-marker t
        centaur-tabs-modified-marker "*"
        centaur-tabs-set-icons t
        centaur-tabs-height 32
        centaur-tabs-gray-out-icons 'buffer)
  (centaur-tabs-headline-match)
  (centaur-tabs-mode t)
  :bind
  (("C-x <prior>" . centaur-tabs-backward)
   ("C-x <next>" . centaur-tabs-forward))
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  (vterm-mode . centaur-tabs-local-mode))

;; --- Sidebar ---
(use-package neotree
  :bind ("C-\\" . neotree-toggle)
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)
        neo-autorefresh t
        neo-smart-open t
        neo-window-width 30
        neo-show-hidden-files t))

;; --- Modeline ---
(use-package spaceline
  :demand t
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme))

;; --- Shell ---
;; --- Emacs Advanced Terminal (Eat) ---
(use-package eat
  :hook (eshell-load . eat-eshell-mode)
  :custom
  (eat-kill-buffer-on-exit t)
  :config
  ;; Inject Everforest ANSI colors into Eat's rendering engine
  ;; This ensures visual apps like htop, vim, or fzf match your Emacs theme
  (let ((ansi-black   "#475258")
        (ansi-red     "#e67e80")
        (ansi-green   "#a7c080")
        (ansi-yellow  "#dbbc7f")
        (ansi-blue    "#7fbbb3")
        (ansi-magenta "#d699b6")
        (ansi-cyan    "#83c092")
        (ansi-white   "#d3c6aa"))
    (custom-set-faces
     `(eat-term-color-0 ((t (:foreground ,ansi-black :background ,ansi-black))))
     `(eat-term-color-1 ((t (:foreground ,ansi-red :background ,ansi-red))))
     `(eat-term-color-2 ((t (:foreground ,ansi-green :background ,ansi-green))))
     `(eat-term-color-3 ((t (:foreground ,ansi-yellow :background ,ansi-yellow))))
     `(eat-term-color-4 ((t (:foreground ,ansi-blue :background ,ansi-blue))))
     `(eat-term-color-5 ((t (:foreground ,ansi-magenta :background ,ansi-magenta))))
     `(eat-term-color-6 ((t (:foreground ,ansi-cyan :background ,ansi-cyan))))
     `(eat-term-color-7 ((t (:foreground ,ansi-white :background ,ansi-white))))
     ;; Bright variants (mapped to the same soft Everforest colors)
     `(eat-term-color-8 ((t (:foreground ,ansi-black :background ,ansi-black))))
     `(eat-term-color-9 ((t (:foreground ,ansi-red :background ,ansi-red))))
     `(eat-term-color-10 ((t (:foreground ,ansi-green :background ,ansi-green))))
     `(eat-term-color-11 ((t (:foreground ,ansi-yellow :background ,ansi-yellow))))
     `(eat-term-color-12 ((t (:foreground ,ansi-blue :background ,ansi-blue))))
     `(eat-term-color-13 ((t (:foreground ,ansi-magenta :background ,ansi-magenta))))
     `(eat-term-color-14 ((t (:foreground ,ansi-cyan :background ,ansi-cyan))))
     `(eat-term-color-15 ((t (:foreground ,ansi-white :background ,ansi-white)))))))

;; --- Eshell Configuration & Popup ---
(use-package eshell
  :straight nil ;; Built into Emacs
  :bind (("C-'" . my-toggle-eshell))
  :config
  ;; 1. Force Eshell to render at the bottom, exactly like shell-pop
  (add-to-list 'display-buffer-alist
               '("\\*eshell\\*"
                 (display-buffer-reuse-window display-buffer-at-bottom)
                 (window-height . 0.3)
                 (reusable-frames . visible)))

  ;; 2. Custom toggle function to replicate shell-pop behavior
  (defun my-toggle-eshell ()
    "Toggle Eshell window at the bottom of the frame."
    (interactive)
    (let ((window (get-buffer-window "*eshell*")))
      (if window
          (delete-window window)
        (eshell))))

  ;; 3. Eshell quality-of-life improvements
  (setq eshell-scroll-to-bottom-on-input 'all
        eshell-error-if-no-glob t
        eshell-hist-ignoredups t
        eshell-save-history-on-exit t
        eshell-prefer-lisp-functions nil
        eshell-destroy-buffer-when-process-dies t))

(use-package eshell-prompt-extras
  :after eshell
  :config
  (with-eval-after-load "esh-opt"
    (setq eshell-highlight-prompt nil
          eshell-prompt-function 'epe-theme-lambda))

  ;; Everforest theme injection for Eshell prompt
  (let ((accent-green  "#a7c080")
        (accent-teal   "#7fbbb3")
        (accent-yellow "#dbbc7f")
        (accent-red    "#e67e80"))
    (custom-set-faces
     `(epe-dir-face ((t (:foreground ,accent-teal :weight bold))))
     `(epe-git-face ((t (:foreground ,accent-yellow))))
     `(epe-symbol-face ((t (:foreground ,accent-green :weight bold))))
     `(epe-status-face ((t (:foreground ,accent-red)))))))

;; --- Global Editor Settings ---
(setq-default indent-tabs-mode nil
              tab-width 4)
(setq indent-line-function 'insert-tab)

(provide 'gui-config)

(defun print-formatted-all-the-icons ()
  (let ((associations all-the-icons-extension-icon-alist)
        (associations-as-strings nil))
    (setq associations-as-strings (mapcar 'prin1-to-string associations))

    (let ((formatted-output (string-join associations-as-strings "\n")))
      (with-current-buffer (get-buffer-create "*scratch*")
        (erase-buffer)
        (insert ";; All-the-icons Extension Icon Alist\n\n")
        (insert formatted-output)
        (emacs-lisp-mode)
        (goto-char (point-min))
        (display-buffer (current-buffer))))))

;;(print-formatted-all-the-icons)  ; Run if wants to check the others to add
                                   ;; a new icon
