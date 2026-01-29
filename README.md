# My Dotfiles

This repo is meant to store and organize all my dotfiles. If you want to use any configuration here, be welcome. If you make a change, that you think 
improves any of these configurations, please, open a PR. (I advise that these configurations only work on GNU Linux as far as I know, maybe MacOS).


Here I'll put instructions to use my configurations:

## Zshrc

This is the easier one, just call `make install-zshrc`, and it will go to your zshrc.

## Rassumfrassum

This is the application used to manage my LSPs. It is a python application, and, so, the first step, is to install pipx:

``` shell
# If in a Debian based distro
sudo apt install pipx

# If in a RedHat based distro
sudo dnf install pipx
# Or
python3 -m pip install --user pipx

# If in an arch based distro
sudo pacman -Syy python-pipx

# After installing pipx, ensure its binaries are in $PATH:
pipx ensurepath
```

Then, just needs to install the rassumfrassum

``` shell
pipx install rassumfrassum
```

Now, finally, call `make install-rassumfrassum` to configure it.

Now, to use it, just run `rass ${language}`.

If you want to add any language, or change the configuration, just change it in this repo, running in a ${language}.py file. 
Look how the others are to get inspiration.

## GNU Emacs

If you want to use my GNU Emacs Config, you will need to do the rassumfrassum first.
After configuring rassumfrassumm, install GNU Emacs.

My configuration is meant for GNU Emacs 31 or later. 
The snap package from the edge channel is in this version, I recommend installing from there:

``` shell
sudo snap install --channel=latest/edge --classic
```

Then, after installing it, call `make install-emacs`. This will setup all configuration files.

Finally, open GNU Emacs for the first time. 
When you do it, it will be almost completely configured.



