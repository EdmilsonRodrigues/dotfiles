;; -*- lexical-binding: t -*-

;; -----------------------------------------------------------------------------
;; EPUB reader (keep first: later packages must not block .epub mode setup)
;; -----------------------------------------------------------------------------
(use-package nov
  :ensure t
  :demand t
  :init
  ;; Built-in `auto-mode-alist' maps .epub to `doc-view-mode-maybe' first; nov
  ;; must be at the front of the alist to win.
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

;; -----------------------------------------------------------------------------
;; Matrix Client
;; -----------------------------------------------------------------------------
(use-package ement
  :bind (("C-x w 1" . ement-connect)))

;; -----------------------------------------------------------------------------
;; Email Client (mu4e with Multi-Account Contexts)
;; -----------------------------------------------------------------------------
(let ((brew-mu4e-path "/home/linuxbrew/.linuxbrew/share/emacs/site-lisp/mu/mu4e"))
  (when (file-directory-p brew-mu4e-path)
    (add-to-list 'load-path brew-mu4e-path)))

(use-package mu4e
  :ensure nil
  :straight nil
  :bind (("C-x w 5" . mu4e))
  :config
  (setq mu4e-maildir "~/Mail"
        mu4e-get-mail-command "mbsync -a"
        mu4e-update-interval 300
        mu4e-context-policy 'pick-first
        mu4e-compose-context-policy 'ask)

  (setq send-mail-function 'message-send-mail-with-sendmail
        message-send-mail-function 'message-send-mail-with-sendmail
        sendmail-program (executable-find "msmtp")
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from"))

  (setq mu4e-contexts
        (list
         (make-mu4e-context
          :name "Pessoal"
          :match-func (lambda (msg) (when msg (string-prefix-p "/gmail-edmilson-pessoal" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address  . "edmilson.rodriguesn38@gmail.com")
                  (user-full-name     . "Edmilson Rodrigues")
                  (mu4e-drafts-folder . "/gmail-edmilson-pessoal/[Gmail]/Drafts")
                  (mu4e-sent-folder   . "/gmail-edmilson-pessoal/[Gmail]/Sent Mail")
                  (mu4e-trash-folder  . "/gmail-edmilson-pessoal/[Gmail]/Trash")
                  (mu4e-refile-folder . "/gmail-edmilson-pessoal/Archive")))

         (make-mu4e-context
          :name "Profissional"
          :match-func (lambda (msg) (when msg (string-prefix-p "/gmail-edmilson-profissional" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address  . "edmilson.monteiro.rodrigues@gmail.com")
                  (user-full-name     . "Edmilson Rodrigues")
                  (mu4e-drafts-folder . "/gmail-edmilson-profissional/[Gmail]/Drafts")
                  (mu4e-sent-folder   . "/gmail-edmilson-profissional/[Gmail]/Sent Mail")
                  (mu4e-trash-folder  . "/gmail-edmilson-profissional/[Gmail]/Trash")
                  (mu4e-refile-folder . "/gmail-edmilson-profissional/Archive")))

         (make-mu4e-context
          :name "Voltbras"
          :match-func (lambda (msg) (when msg (string-prefix-p "/gmail-edmilson-voltbras" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address  . "edmilson.rodrigues@voltbras.com.br") ; Adjust if address differs
                  (user-full-name     . "Edmilson Rodrigues")
                  (mu4e-drafts-folder . "/gmail-edmilson-voltbras/[Gmail]/Drafts")
                  (mu4e-sent-folder   . "/gmail-edmilson-voltbras/[Gmail]/Sent Mail")
                  (mu4e-trash-folder  . "/gmail-edmilson-voltbras/[Gmail]/Trash")
                  (mu4e-refile-folder . "/gmail-edmilson-voltbras/Archive")))

         (make-mu4e-context
          :name "PlanetaE"
          :match-func (lambda (msg) (when msg (string-prefix-p "/gmail-planetae" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address  . "planetaedevelopment@gmail.com")
                  (user-full-name     . "Edmilson Rodrigues")
                  (mu4e-drafts-folder . "/gmail-planetae/[Gmail]/Drafts")
                  (mu4e-sent-folder   . "/gmail-planetae/[Gmail]/Sent Mail")
                  (mu4e-trash-folder  . "/gmail-planetae/[Gmail]/Trash")
                  (mu4e-refile-folder . "/gmail-planetae/Archive"))))))

;; -----------------------------------------------------------------------------
;; RSS Client
;; -----------------------------------------------------------------------------
(use-package elfeed
  :straight (:host github :repo "skeeto/elfeed" :type git)
  :bind (("C-x w 4" . elfeed))
  :config
  (setq elfeed-feeds
        '(;; Emacs + Free Software
          ("https://sachachua.com/blog/category/emacs/feed/" emacs free-software)
          ("https://www.gnu.org/software/emacs/emacs.rss" emacs)
          ("https://www.fsf.org/blogs/rss.xml" free-software fsf)
          ("https://nullprogram.com/feed/" blog emacs)

          ;; Linux
          ("http://rss.gmane.org/gmane.linux.debian.user.news" debian linux)
          ("https://www.redhat.com/en/rss/blog/channel/red-hat-news" redhat linux)
          ("https://ubuntu.com/blog/feed" canonical ubuntu linux)
          ("https://www.linux.com/feed/" linux)

          ;; Work
          ("https://blog.python.org/feeds/posts/default?alt=rss" python)
          ("https://go.dev/blog/feed.atom" go)
          ("https://nodejs.org/en/feed.xml" nodejs javascript)
          ("https://kubernetes.io/feed.xml" kubernetes devops))))

;; -----------------------------------------------------------------------------
;; IRC Client (Circe)
;; -----------------------------------------------------------------------------
(use-package circe
  :bind (("C-x w 6" . circe))
  :config
  (setq circe-network-options
        '(("Libera Chat"
           :nick "edmilson"
           :channels ("#podman" "#emacs")))))

(provide 'connectivity-config)
