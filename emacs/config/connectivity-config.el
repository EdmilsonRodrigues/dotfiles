;; -*- lexical-binding: t -*-

;; Matrix Client
(use-package ement
  :bind (("C-x w 1" . ement-connect)))

;; Email Client
(let ((brew-mu4e-path "/home/linuxbrew/.linuxbrew/share/emacs/site-lisp/mu/mu4e"))
  (when (file-directory-p brew-mu4e-path)
    (add-to-list 'load-path brew-mu4e-path)))

(use-package mu4e
  :ensure nil
  :straight nil
  :bind (("C-x w 5" . mu4e)))

(setq mu4e-maildir "~/Mail"
      mu4e-get-mail-command "mbsync gmail-edmilson-profissional"
      mu4e-update-interval 300)

(setq mu4e-drafts-folder "/gmail-edmilson-profissional/[Gmail]/Drafts"
      mu4e-sent-folder   "/gmail-edmilson-profissional/[Gmail]/Sent Mail"
      mu4e-trash-folder  "/gmail-edmilson-profissional/[Gmail]/Trash"
      mu4e-refile-folder "/gmail-edmilson-profissional/Archive")

(setq send-mail-function 'sendmail-send-it
      sendmail-program (executable-find "msmtp"))

;; RSS Client

(use-package elfeed
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
          ("https://news.ycombinator.com/rss" tech news)
          ("https://kubernetes.io/feed.xml" kubernetes devops))))

;; IRC
(use-package circe)

(provide 'connectivity-config)
