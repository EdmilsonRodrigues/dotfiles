EMACS_FOLDER=~/.emacs.d
CONFIG_FOLDER=~/.config

.PHONY: install-emacs
install-emacs:
	[ -d ${EMACS_FOLDER} ] || mkdir ${EMACS_FOLDER}
	stow --target ${EMACS_FOLDER} emacs
	cp emacs/.emacs ~

.PHONY: install-zshrc
install-zshrc:
	stow --target ~ zshrc

.PHONY: install-rassumfrassum
install-rassumfrassum: ensure-config
	stow --target ${CONFIG_FOLDER} rassumfrassum

.PHONY: ensure-config
ensure-config:
	[ -d ${CONFIG_FOLDER} ] || mkdir ${CONFIG_FOLDER}

