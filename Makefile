EMACS_FOLDER=~/.emacs.d
RASSUMFRASSUM_FOLDER=~/.config

.PHONY: install-emacs
install-emacs:
	[ -d ${EMACS_FOLDER} ] || mkdir ${EMACS_FOLDER}
	stow --target ${EMACS_FOLDER} emacs

.PHONY: install-rassaufrassum
install-rassumfrassum:
	[ -d ${RASSUMFRASSUM_FOLDER} ] || mkdir ${RASSUMFRASSUM_FOLDER}
	stow --target ${RASSUMFRASSUM_FOLDER} rassumfrassum

.PHONY: install-zshrc
install-zshrc:
	stow --target ~ zshrc
