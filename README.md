## steps

```
export PATH="$(python3 -m site --user-base)/bin:$PATH"
```

```
sign in to icloud
```

```
sign in to app store
```

```bash
xcode-select --install
```

```
sudo pip3 install --upgrade pip
```

```
pip3 install ansible
```

```
ansible-playbook ansible-install-os-packages.yml --ask-become-pass

```

```

```

# Symbolic link

`ln -nfs ~/dotfilesOSX/.zshrc ~/.zshrc`

`ln -nfs ~/dotfilesOSX/.zprofile ~/.zprofile`

`ln -nfs ~/dotfilesOSX/karabiner.json ~/.config/karabiner/karabiner.json`

`ln -s ~/bin/dotfiles/ZSH_THEME/mrp.zsh-theme ~/.oh-my-zsh/custom/themes/mrp.zsh-theme\`

`ln -nfs ~/dotfilesOSX/.yabairc ~/.yabairc`

`ln -nfs ~/dotfilesOSX/.fzf.zsh ~/.fzf.zsh`

stow karabiner

stow sketchybar

stow --target=$HOME yabai

stow zsh

stow lsd

stow borders

stow -t "$HOME/Library/Application Support/" Alfred/

stow warp

stow starship

stow alacritty

stow --target=$HOME obs-studio

```shell
# verifies if the symlink is done or not
ls -l ~/Library/Application\ Support/obs-studio

```

<!-- cd nvim
stow -t "$HOME/" CoreNvim --verbose  -->

sh ./nvim/VSCodeNeovim-sokhuong/installer.sh

### stop sketchybar

`brew services stop sketchybar`
