# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="leon"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
 DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump colored-man-pages colorize copydir command-not-found history sublime zsh-syntax-highlighting)
#plugins+=(zsh-completions)
#autoload -U compinit && compinit

# User configuration

  export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#### set key binding ####
autoload zkbd
#file_kbd=~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
file_kbd=~/.zkbd/$TERM
#[[ ! -f ${file_kbd} ]] && zkbd
 [[   -f ${file_kbd} ]] && source ${file_kbd}

typeset -g -A key
key[Backspace]='^H'
key[Insert]='^[[2~'
key[Home]='^[[1~'
key[PageUp]='^[[5~'
key[Delete]='^[[3~'
key[End]='^[[4~'
key[PageDown]='^[[6~'
key[Up]='^[[A'
key[Left]='^[[D'
key[Down]='^[[B'
key[Right]='^[[C'

[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
########

setopt shwordsplit

#############################################################
## from .bashrc
#############################################################

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US:en"

#source ~/.git-completion.bash
#source ~/.git-prompt.sh       # enable this if used in cygwin

export EDITOR=vim
export PAGER=less
export LESS=-iR
#export DISPLAY=172.23.44.5:0.0

export HISTCONTROL=ignoredups
export HISTSIZE=500
export HISTFILESIZE=5000

alias ls='ls --color=auto'
alias grep='grep --colour=auto'

alias ll='ls -Al'
alias lg='ls -l --group-directories-first'
alias la='ls -l'
alias g='grep -i'
alias ns='netstat'
alias t='telnet'
alias tig='tig --all'

alias tmd='tmux detach -P ; tmux a -d || tmux new'
alias scrd='screen -RD'

#source /usr/share/autojump/autojump.sh
#[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh

## >> highlight warning and error when make
#if [ ]; then
mymake() {
  #ccError=$(echo -e "\033[41m")
  #ccWarn=$(echo -e "\033[33m")
  ccError=$(echo -e "\033[31;07m")
  ccWarn=$(echo -e "\033[33;07m")
  ccGcc=$(echo -e "\033[35m")
  ccReset=$(echo -e "\033[0m")
  /usr/bin/make "$@" 2>&1 | \
  sed -E -e "s/.* (error:|Error|cannot find|undefined reference) .*/$ccError&$ccReset/g" \
         -e "s/.* warning: .*/$ccWarn&$ccReset/g" \
		 -e "s/.*gcc .*/$ccGcc&$ccReset/g"
  return ${PIPESTATUS[0]}
}
#fi

#alias make=colormake
#PATH=~/bin:$PATH

alias iesrc=". ~/workspace/ies.leon/ies.rc"
alias glcrc=". ~/workspace/glc.leon/glc.rc"


## for NPM
## install -g to user home
## http://stackoverflow.com/questions/10081293/install-npm-into-home-directory-with-distribution-nodejs-package-ubuntu

# NPM packages in homedir
export NPM_PACKAGES="$HOME/.npm-packages"
#mkdir -p "$NPM_PACKAGES"
#echo "prefix = $NPM_PACKAGES" > ~/.npmrc

# Tell our environment about user-installed node tools
export PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH  # delete if you already modified MANPATH elsewhere in your configuration
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Tell Node about these packages
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

