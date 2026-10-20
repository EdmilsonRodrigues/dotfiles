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

## LightDM

This machine uses **slick-greeter** (`90-slick-greeter.conf`). The repo ships
`lightdm/etc/lightdm/slick-greeter.conf` (Everforest colors + wallpaper) and an
optional **gtk-greeter** profile if you switch greeters.

Install greeter config and a system-readable copy of the login wallpaper:

``` shell
sudo make install-lightdm
```

## Sway / Google Meet screen sharing (Firefox)

On Sway, Firefox needs **xdg-desktop-portal-wlr**, portal preferences, and
Wayland/PipeWire capture prefs. `make install-sway` installs portal config via
`install-portal` (includes `MOZ_ENABLE_WAYLAND=1` for the graphical session).

For the **Firefox snap**, install the WebRTC prefs into your default profile:

``` shell
make install-firefox
```

Restart Firefox completely, then in Meet use **Share screen** (not the static
screenshot option). Slurp is configured for **monitors only** (`-o`): click
the **monitor outline**, not an app window inside it, or Firefox often shares a
single frozen frame.

If screencast still freezes after one frame, rebuild **xdg-desktop-portal-wlr**
from current git (0.9.x includes PipeWire buffer fixes for Firefox/WebRTC):

``` shell
git clone https://github.com/emersion/xdg-desktop-portal-wlr.git
cd xdg-desktop-portal-wlr && meson setup build && ninja -C build
sudo ninja -C build install
systemctl --user restart xdg-desktop-portal-wlr.service xdg-desktop-portal.service
```

Reload Sway (`$mod+Shift+c`) or log out and back in after changing portal config.
In `about:support`, **Window Protocol** should read `wayland`.

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

My configuration is meant for GNU Emacs 32 or later.
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
