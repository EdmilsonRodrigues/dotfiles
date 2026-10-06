;; -*- lexical-binding: t -*-
(require 'package)

;; --- Disable Standard Package Manager Startup ---
(setq package-enable-at-startup nil)

;; --- Setup Repositories ---
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa"  . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(package-initialize)

(require 'use-package)
;; straight.el installs packages (see `straight-use-package-by-default' in
;; init.el); package.el must not also try to, or startup aborts on features
;; that are not standalone packages (e.g. vertico-directory).
(setq use-package-always-ensure nil)

(use-package try)

(provide 'packages-config)
