;; -*- lexical-binding: t -*-

;; --- Startup && Backups ---
(setq inhibit-startup-message t
      initial-buffer-choice  nil
      initial-scratch-message nil
      auto-save-default nil
      make-backup-files nil
      display-warning-minimum-level :error)

;; --- UI Elements ---
(menu-bar-mode +1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(setopt display-fill-column-indicator-column 80)

;; --- Modes ---
(ido-mode 0)
(cua-mode 1)
(display-time-mode 1)
(add-hook 'prog-mode-hook #'hs-minor-mode)

;; --- Icons ---
(use-package all-the-icons
  :config
  (let ((new-icons '(("plx"  all-the-icons-alltheicon "perl"     :face all-the-icons-lorange)
                     ("bash" all-the-icons-alltheicon "terminal" :face all-the-icons-green)
                     ("toml" all-the-icons-octicon    "settings" :face all-the-icons-lorange)
                     ("qml"  all-the-icons-faicon     "file-code-o" :face all-the-icons-yellow)
                     ("pyx"  all-the-icons-alltheicon "python"   :face all-the-icons-blue))))
    (dolist (icon new-icons)
      (add-to-list 'all-the-icons-extension-icon-alist icon))))

;; Run this function if setting for the first time
;; (all-the-icons-install-fonts)

;; --- Navigation && Windows ---
(use-package ace-window
  :bind (("C-x o" . ace-window)))

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
	centaur-tabs-height 32)
  (centaur-tabs-change-fonts (face-attribute 'default :font) 110)
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
  :bind ("C-\\". 'neotree-toggle)
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)
        neo-autorefresh t
        neo-smart-open t
        neo-show-hidden-files t))

;; --- Modeline & Aesthetics ---
;(use-package spaceline)

(use-package spaceline-config
  :ensure spaceline
  :config (spaceline-emacs-theme))

(use-package emojify
  :hook (after-init . global-emojify-mode))

;; --- Shell --- 
(use-package shell-pop
  :bind (("C-'" . shell-pop))
  :config
  (setq shell-pop-shell-type '("shell" "*shell*" (lambda () (shell))))
  (setq shell-file-name "/bin/zsh")
  (setenv "SHELL" "/bin/zsh")
  (setq shell-pop-window-position "bottom"))


;; --- Global Editor Settings
(setq-default indent-tabs-mode nil
              tab-width 4)
(setq indent-line-function 'insert-tab)

;; --- Theme && Fonts ---
(load-theme 'tango-dark)
(set-face-attribute 'default nil :height 140 :family "Ubuntu Sans Mono" )

(provide 'gui-config)

(defun print-formatted-all-the-icons ()
  (let ((associations all-the-icons-extension-icon-alist)
        (associations-as-strings nil))
    ;; Convert each association list to a readable string
    (setq associations-as-strings (mapcar 'prin1-to-string associations))

    ;; Join the strings with newlines
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
