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
(setq use-package-always-ensure t)

(use-package try)

(provide 'packages-config)
