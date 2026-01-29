;; -*- lexical-binding: t -*-

(use-package ergoemacs-mode
  :ensure t
  :init
  (setq ergoemacs-theme nil)
  (setq ergoemacs-keyboard-layout "pt")
  :config
  (ergoemacs-mode 1))

(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(global-set-key (kbd "C-<up>") 'move-line-up)
(global-set-key (kbd "C-<down>") 'move-line-down)
(global-set-key (kbd "C-º") 'execute-extended-command)

(use-package consult
  :bind (("C-f"     . consult-line)          ;; Replaces swiper
         ("C-x C-f" . find-file)             ;; Standard find-file works great with Vertico
         ("M-y"     . consult-yank-pop)      ;; Better kill-ring
         ("C-c k"   . consult-ripgrep)       ;; Replaces counsel-ag/grep
         ("C-x l"   . consult-locate)        ;; Replaces counsel-locate
         ;; Help replacements
         ("<f1> f"  . describe-function)     ;; Vertico + Marginalia makes these 
         ("<f1> v"  . describe-variable)     ;; better than Counsel
         ("<f1> l"  . find-library)))

(provide 'keybindings-config)
