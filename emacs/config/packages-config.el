;; -*- lexical-binding: t -*-
(require 'package)

;; --- Disable Standard Package Manager Startup ---
(setq package-enable-at-startup nil)

;; --- Setup Repositories ---
;; Preference: MELPA, then GNU ELPA, then NonGNU ELPA. straight.el is last.
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa"  . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(setq package-archive-priorities '(("melpa" . 20)
                                   ("elpa"  . 10)
                                   ("nongnu" . 5)))

(package-initialize)

(require 'use-package)
(require 'use-package-ensure)

(defvar my/package-refreshed-this-session nil
  "Whether `package-refresh-contents' already ran this Emacs session.")

(defun my/use-package-ensure-straight (pkg)
  "Install PKG with straight.el when it is not on MELPA/ELPA."
  (unless (fboundp 'straight-use-package)
    (error "Package %s is not on MELPA/ELPA and straight.el is not available" pkg))
  (message "Package %s not on MELPA/ELPA; installing with straight.el" pkg)
  (straight-use-package pkg)
  t)

(defun my/package-install-from-elpa (pkg no-refresh)
  "Install PKG from package.el archives. Return non-nil on success."
  (when (and (not no-refresh)
             (not (assq pkg package-archive-contents))
             (not my/package-refreshed-this-session))
    (setq my/package-refreshed-this-session t)
    (ignore-errors (package-refresh-contents)))
  (when (assq pkg package-archive-contents)
    (condition-case err
        (progn
          (package-install pkg)
          t)
      (error
       (display-warning 'use-package
                        (format "package.el failed to install %s: %s"
                                pkg (error-message-string err)))
       nil))))

(defun my/use-package-ensure-prefer-elpa (name args _state &optional no-refresh)
  "Install NAME from package.el (MELPA, then ELPA), else straight.el."
  (let* ((ensure (car args))
         (pkg (cond ((eq ensure t) name)
                    ((null ensure) nil)
                    ((symbolp ensure) ensure)
                    (t name))))
    (cond
     ((null pkg) t)
     ((eq pkg 'emacs) t)
     ((package-installed-p pkg) t)
     ((my/package-install-from-elpa pkg no-refresh) t)
     (t (my/use-package-ensure-straight pkg)))))

(setq use-package-always-ensure t
      use-package-ensure-function #'my/use-package-ensure-prefer-elpa)

(use-package try)

(provide 'packages-config)
