# My Dotfiles

This repo is meant to store and organize all my dotfiles. If you want to use any configuration here, be welcome. If you make a change, that you think 
improves any of these configurations, please, open a PR. (I advise that these configurations only work on GNU Linux as far as I know, maybe MacOS).

Before beginning, install the GNU Stow, the tool I am using to manage my config:

``` shell
# If in a Debian based distro
sudo apt install stow

# If in a RedHat based distro
# Maybe you need to add the Extra Packages for Enterprise Linux first.
# sudo dnf install epel-release -y
sudo dnf install stow

# If in a SUSE based distro
sudo zypper install stow

# If in an arch based distro
sudo pacman -Syy stow
```

Here I'll put instructions to use my configurations:



## Zshrc

This is the easier one, just call `make install-zshrc`, and it will go to your zshrc.

## Rassumfrassum

This is the application used to manage my LSPs. It is a python application, and, so, the first step, is to install pipx:

``` shell
# If in a Debian based distro
sudo apt install pipx

# If in a RedHat based distro
# Maybe you need to add the Extra Packages for Enterprise Linux first.
# sudo dnf install epel-release -y
sudo dnf install pipx
# Or
python3 -m pip install --user pipx

# If in a SUSE based distro
sudo zypper install python3-pipx

# If in an arch based distro
sudo pacman -Syy python-pipx
```

After installing pipx, ensure its binaries are in $PATH:
``` shell
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

Finally, open GNU Emacs for the first time: `emacs`.

When you do it, it will install all dependencies and, when finish, be almost completely configured.

Now, in order to finish the configuration, open the file in `~/.emacs.d/config/gui-config.el`, line 36.
Uncomment this line, and in the end of it, run C-x C-e. It will download the icons for files navigation.

Then, go to `~/.emacs.d/config/gui-config.el` and, in the final of the line 33, run C-x C-e.
It will install all LSPs.

Some LSPs might fail. Some of them will probably fail. This happens. If the LSP you want to use was not installed. Install it manually
and let it available in the PATH. They are all already configured, just needed to be installed. If you want the best experience, 
install them all. I cherry-picked them specially for this.

Check which were successfully installed at `~/.emacs.d/mason/bin`.

Also, add this to your shell rc file (.bashrc, .zshrc, whatever), so the LSPs will be available in $PATH:

``` shell
export PATH="/home/familia/.emacs.d/mason/bin:$PATH"
```

export PATH="/home/familia/.emacs.d/mason/bin:$PATH"`

Now, just to wrap everything up, notice that, when it's the first time opening a type of file, it will be asked to download the
tree-sitter for that file kind. Just say yes. It will improve the performance of parsing of the file.
