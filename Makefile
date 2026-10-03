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

.PHONY: install-htop
install-htop: ensure-config
	stow --target ${CONFIG_FOLDER} htop

.PHONY: install-kitty
install-kitty: ensure-config
	stow --target ${CONFIG_FOLDER} kitty

.PHONY: install-nautilus
install-nautilus: ensure-config
	stow --target ${CONFIG_FOLDER} nautilus

.PHONY: install-nemo
install-nemo: ensure-config
	stow --target ${CONFIG_FOLDER} nemo

.PHONY: install-sway
install-sway: ensure-config
	stow --target ${CONFIG_FOLDER} sway

.PHONY: install-waybar
install-waybar: ensure-config
	stow --target ${CONFIG_FOLDER} waybar

.PHONY: install-wofi
install-wofi: ensure-config
	stow --target ${CONFIG_FOLDER} wofi

.PHONY: install-eww
install-eww: ensure-config
	stow --target ${CONFIG_FOLDER} eww

.PHONY: ensure-config
ensure-config:
	[ -d ${CONFIG_FOLDER} ] || mkdir ${CONFIG_FOLDER}
