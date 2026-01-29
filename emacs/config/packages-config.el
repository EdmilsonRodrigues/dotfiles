;; -*- lexical-binding: t -*-
(require 'package)

;; --- Disable Stadard Package Manager ---
(setq package-enable-at-startup nil)

;; --- Setup Repositories ---
(setq package-archives '(("melpa" . "https://melpa.org/packages/")))
                                 ;("elpa" . "http://elpa.gnu.org/packages/")
                                 ;("org" . "https://orgmode.org/elpa/")))

;; --- Setup Package Manager --- 
(package-initialize)  ; iniciar pacotes

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)

;; --- Package for tests ---
(use-package try)

(provide 'packages-config)
