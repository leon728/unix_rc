export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export TERM=xterm-256color


# https://github.com/zsh-users/zsh-syntax-highlighting/issues/240
# https://gist.github.com/magicdude4eva/2d4748f8ef3e6bf7b1591964c201c1ab
### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes


#source .ohmyzshrc
#ANTIGEN_LOG=$HOME/antigen.log
source ~/antigen.zsh
antigen init $HOME/.antigenrc

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

# Keypad: 0 . Enter 1 2 3 4 5 6 7 8 9 + - * /
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"

########

setopt shwordsplit

#############################################################
## from .bashrc
#############################################################

#export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"

#source ~/.git-completion.bash
#source ~/.git-prompt.sh       # enable this if used in cygwin

export EDITOR=vim
export PAGER=less
export LESS=-iR

export HISTCONTROL=ignoredups
export HISTSIZE=1000
export HISTFILESIZE=10000

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
#alias df='df -BM'
#alias vmstat='vmstat -SM 2'
#alias free='free -m'

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
  sed -r -e "s/.* (error:|Error|cannot find|undefined reference) .*/$ccError&$ccReset/g" \
         -e "s/.* warning: .*/$ccWarn&$ccReset/g" \
		 -e "s/.*gcc .*/$ccGcc&$ccReset/g"
  return ${PIPESTATUS[0]}
}
#fi

#alias make=colormake
#PATH=~/bin:$PATH

alias iesrc=". ~/workspace/ies.leon/ies.rc"
alias glcrc=". ~/workspace/glc.leon/glc.rc"
alias ponrc="cd ~/workspace/xgpon/sdk/OCTEONTX-SDK && source t81.leon && cd -"

#export DISPLAY=172.23.44.5:0.0
export DISPLAY=$(echo $SSH_CLIENT | awk '{print $1}'):0.0

## for NPM
## install -g to user home
## http://stackoverflow.com/questions/10081293/install-npm-into-home-directory-with-distribution-nodejs-package-ubuntu

# NPM packages in homedir
#export NPM_PACKAGES="$HOME/.npm-packages"
#mkdir -p "$NPM_PACKAGES"
#echo "prefix = $NPM_PACKAGES" > ~/.npmrc

# Tell our environment about user-installed node tools
export PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
#unset MANPATH  # delete if you already modified MANPATH elsewhere in your configuration
#export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Tell Node about these packages
#export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

#export GOROOT=/usr/lib/go-1.10
export GOROOT=$HOME/workspace/openolt/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

#export APT_CONFIG=~/apt_proxy.conf
# without this, yor can still use: sudo apt-get -c ~/apt_proxy.conf update

#export http_proxy="http://172.23.85.77:8081"
#export https_proxy="http://172.23.85.77:8081"

#export FZF_DEFAULT_COMMAND="fd -I"
export FZF_DEFAULT_OPTS="-e"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
