# First run 

install homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/null
```


Run brewInstall.sh

```bash
cd homebrewSetup/
sh brewInstall.sh
```


# Symbolic link

```bash
ln -nfs ~/dotfilesOSX/zsh/.zshrc ~/.zshrc
```

```bash
ln -nfs ~/dotfilesOSX/zsh/.zprofile ~/.zprofile
```

<!-- ```bash
ln -nfs ~/dotfilesOSX/karabiner.json ~/.config/karabiner/karabiner.json
``` -->

```bash
ln -s ~/bin/dotfiles/ZSH_THEME/mrp.zsh-theme ~/.oh-my-zsh/custom/themes/mrp.zsh-theme\
```

```bash
ln -nfs ~/dotfilesOSX/.yabairc ~/.yabairc
```


```open new Iterm session```

```bash
stow karabiner
stow sketchybar
stow zsh
```


# Symbolic link

```ln -nfs ~/dotfilesOSX/.zshrc ~/.zshrc```

```ln -nfs ~/dotfilesOSX/.zprofile ~/.zprofile```

```ln -nfs ~/dotfilesOSX/karabiner.json ~/.config/karabiner/karabiner.json```

```ln -s ~/bin/dotfiles/ZSH_THEME/mrp.zsh-theme ~/.oh-my-zsh/custom/themes/mrp.zsh-theme\```

```ln -nfs ~/dotfilesOSX/.yabairc ~/.yabairc```

stow karabiner

stow sketchybar

stow zsh

