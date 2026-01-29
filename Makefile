EMACS_FOLDER=~/.emacs.d

.PHONY: install-emacs
install-emacs:
	[ -d ${EMACS_FOLDER} ] || mkdir ${EMACS_FOLDER}
	stow --target ${EMACS_FOLDER} emacs

.PHONY: install-rassaufrassum
install-rassumfrassum:
	stow --target ~/.config rassumfrassum

.PHONY: install-zshrc
install-zshrc:
	stow --target ~ zshrc
