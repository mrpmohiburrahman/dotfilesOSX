# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="mrp"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# eval "$(starship init zsh)"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# For Android Studio
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

export PATH=$PATH:$HOME/.maestro/bin

# Mega CMD
export PATH=/Applications/MEGAcmd.app/Contents/MacOS:$PATH
# source /Applications/MEGAcmd.app/Contents/MacOS/megacmd_completion.sh

eval "$(zoxide init --cmd cd zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias cat='bat'
alias vim='nvim'

# lsd The next gen ls command https://github.com/lsd-rs/lsd

alias ls='eza --icons'
# issue: lsd -la takes a long time
# alias ls='lsd'
# alias l='ls -l'
# alias la='ls -a'
# alias lla='ls -la'
# alias lt='ls --tree'

# bun completions
[ -s "/Users/mrp/.bun/_bun" ] && source "/Users/mrp/.bun/_bun"

alias nvim_okwasniewski_rn="XDG_CONFIG_HOME=~/dotfilesOSX/nvim/nvim-okwasniewski-rn nvim"
alias nvim_unphased="XDG_CONFIG_HOME=~/dotfilesOSX/nvim/nvim-by-unphased nvim"
alias nvim_alex_courtis="XDG_CONFIG_HOME=~/dotfilesOSX/nvim/alex-courtis nvim"
alias nvim_folky="XDG_CONFIG_HOME=~/dotfilesOSX/nvim/folky_nvim nvim"
alias nvim_ide="XDG_CONFIG_HOME=~/dotfilesOSX/nvim/nvim-ide nvim"
alias nvim_starter_kickstart="XDG_CONFIG_HOME=~/dotfilesOSX/nvim/starter-kickstart-nvim nvim"
alias nvim_starter_lazyvim="XDG_CONFIG_HOME=~/dotfilesOSX/nvim/starter-lazy-vim nvim"
alias nvim_starter_nvchad="XDG_CONFIG_HOME=~/dotfilesOSX/nvim/starter-nv-chad nvim"
alias nvim_nvchad="XDG_CONFIG_HOME=~/dotfilesOSX/nvim/NvChad nvim"
alias nvim_nvchad_j="XDG_CONFIG_HOME=~/dotfilesOSX/nvim/customized-by-josean nvim"
alias nvim_nvchad_m="XDG_CONFIG_HOME=~/dotfilesOSX/nvim/customized-by-mgastonportillo nvim"
alias nvim_lazyvim="XDG_CONFIG_HOME=~/dotfilesOSX/nvim/lazyvim nvim"
alias nvim_core_nvim="XDG_CONFIG_HOME=~/dotfilesOSX/nvim/CoreNvim/.config nvim"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

eval "$(direnv hook zsh)"

# pnpm
export PNPM_HOME="/Users/mrp/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
work() {
  # usage: work 10m, work 60s etc. Default is 20m
  timer "${1:-20m}" && terminal-notifier -message 'Pomodoro' \
    -title 'Work Timer is up! Take a Break 😊' \
    -sound Crystal
}

rest() {
  # usage: rest 10m, rest 60s etc. Default is 5m
  timer "${1:-5m}" && terminal-notifier -message 'Pomodoro' \
    -title 'Break is over! Get back to work 😬' \
    -sound Crystal
}
PATH=~/.console-ninja/.bin:$PATH
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mrp/Documents/0-Inbox/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mrp/Documents/0-Inbox/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mrp/Documents/0-Inbox/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mrp/Documents/0-Inbox/google-cloud-sdk/completion.zsh.inc'; fi
if [ -r "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi
