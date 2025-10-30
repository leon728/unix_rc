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

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#---- oh-my-zsh
#source .ohmyzshrc
#ANTIGEN_LOG=$HOME/antigen.log

#---- plugin manager: antigen
source ~/antigen.zsh
antigen init $HOME/.antigenrc

#---- plugin manager: antidote
#source ~/.antidote/antidote.zsh
#antidote load
#source ~/.p10k.r3

#---- plugin manager: zgen
#source ~/.zgenrc

#---- plugin manager: zplug    NOTE: not working, history is broken
#if [[ ! -d ~/.zplug ]];then
#  # git clone --depth 1 https://github.com/zplug/zplug ~/.zplug
#  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
#fi
#source ~/.zplug/init.zsh
#source ~/.zplugrc

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

export EDITOR=vim
export PAGER=less
export LESS=-iR
export BLOCK_SIZE="'1"  # http://www.gnu.org/software/coreutils/manual/html_node/Block-size.html

export HISTCONTROL=ignoredups
export HISTSIZE=1000
export HISTFILESIZE=10000

# https://wiki.archlinux.org/title/Sudo#Passing_aliases
# https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Aliases
# If the last character of the alias value is a blank, then the next command word following the alias is also checked for alias expansion.
alias sudo='sudo '
alias ls='ls --color=auto'
alias grep='grep --colour=auto'

alias ll='ls -Al'
alias lg='ls -Al --group-directories-first'
alias la='ls -l'
alias g='grep -i'
alias ns='netstat'
alias t='telnet'
alias tig='tig --all'
alias ww='echo "$(whoami)@$(hostname)"'
alias fd='fd -I'

export PS_FORMAT='user,pid,ppid,pcpu,pmem,vsz,rss,tty,stat,stime,bsdtime,args'
alias pss='ps -eo user,pid,ppid,pcpu,pmem,vsz,rss,tty,stat,stime,bsdtime,comm'              # only command
alias psl='ps -eo user,pid,ppid,pcpu,pmem,vsz,rss,tty,stat,stime,bsdtime,args'              # command and arguments ('args' output is limited to terminal width)
alias psll='ps -eo user,pid,ppid,pcpu,pmem,vsz,rss,tty,stat,stime,bsdtime,args -ww'         # 'args' output is unlimited
alias psl3='ps -eo user,pid,ppid,pcpu,pmem,vsz,rss,tty,stat,stime,bsdtime,args --width 30'  # 'args' output is limited to 30 characters

alias tmd='tmux detach -P ; tmux a -d || tmux new'
alias scrd='screen -RD'
#alias df='df -BM'
#alias vmstat='vmstat -SM 2'
#alias free='free -m'
alias lynx='lynx -accept_all_cookies -nopause'
#alias vim='TERM=linux nvim'

#source /usr/share/autojump/autojump.sh
#[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh

## >> highlight warning and error when make
#if [ ]; then
function mymake() {
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

function mysvnclean() {
#  dirlist=$(find . -name .svn | sed 's#/.svn##g')
#  [[ -d .svn ]] || dirlist+=" ."
  
  dirlist=$@; [[ $# -eq 0 ]] && dirlist=.;    # default to . if no arguments
  dirlist="$dirlist $(printf '%s\n' $dirlist | xargs -r -I{} find {} -name .svn | sed 's#/.svn##g')"    # dirlist: input dirs and subdirs of them which contains .svn/
  dirlist=$(printf '%s\n' $dirlist | sort | uniq)    # remove duplicate
  
  for i in $dirlist; do
    svn revert -R $i
    svn cleanup --remove-unversioned --remove-ignored $i
  done
}

## https://github.com/romkatv/powerlevel10k#how-do-i-change-prompt-colors
## see also: apt install colortest
function mycolor256() {
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

#alias make=colormake
PATH=~/bin:$PATH

alias iesrc=". ~/workspace/ies.leon/ies.rc"
alias glcrc=". ~/workspace/glc.leon/glc.rc"
alias ponrc="cd ~/workspace/xgpon/sdk/OCTEONTX-SDK && source t81.leon && cd -"

#export DISPLAY=172.23.44.5:0.0
export DISPLAY=$(echo $SSH_CLIENT | awk '{print $1}'):0.0

# ## for NPM
# ## install -g to user home
# ## http://stackoverflow.com/questions/10081293/install-npm-into-home-directory-with-distribution-nodejs-package-ubuntu
# 
# # NPM packages in homedir
# export NPM_PACKAGES="$HOME/.npm-packages"
# #mkdir -p "$NPM_PACKAGES"
# #echo "prefix = $NPM_PACKAGES" > ~/.npmrc
# 
# # Tell our environment about user-installed node tools
# export PATH="$NPM_PACKAGES/bin:$PATH"
# # Unset manpath so we can inherit from /etc/manpath via the `manpath` command
# unset MANPATH  # delete if you already modified MANPATH elsewhere in your configuration
# export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# # Tell Node about these packages
# export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

# #export GOROOT=/usr/lib/go-1.10
# export GOROOT=$HOME/workspace/openolt/go
# export GOPATH=$HOME/go
# export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# # without this, yor can still use: sudo apt-get -c ~/apt_proxy.conf update
# export APT_CONFIG=~/apt_proxy.conf

#export http_proxy="http://172.23.85.77:8081"
#export https_proxy="http://172.23.85.77:8081"

# use -j1 so that the result will be more (but not fully) ordered
export FZF_CTRL_T_COMMAND="fd -I -j1"
#export FZF_CTRL_T_OPTS=""
bindkey "^N" fzf-file-widget
export FZF_ALT_C_COMMAND="fd -I -td -j1"
#export FZF_ALT_C_OPTS=""
bindkey "^O" fzf-cd-widget

_fzf_compgen_path() {
	command fd -I -tf -tl -j1
}

_fzf_compgen_dir() {
	command fd -I -td -j1
}

export FZF_DEFAULT_COMMAND="fd -I"
#export FZF_DEFAULT_OPTS="-e --height ${FZF_TMUX_HEIGHT:-40%} --color=16 -m --reverse +s"
#export FZF_DEFAULT_OPTS="-e --height ${FZF_TMUX_HEIGHT:-40%} --color=16 -m --reverse"
export FZF_DEFAULT_OPTS="-e --height ${FZF_TMUX_HEIGHT:-40%} --color=16 -m --reverse --bind='tab:down,btab:up'"
[ -f ~/.fzf.zsh -a -f ~/.antigen/bundles/junegunn/fzf/bin/fzf ] || ~/.antigen/bundles/junegunn/fzf/install --all
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fasd
# https://github.com/leon728/fasd (forked from https://github.com/clvv/fasd)
# description: history of recect files and directories, commands to list/filter/select between them
eval "$(fasd --init auto)"
# alias v='f -e vim'  # example of using -e
unalias d  # I prefer .antigen/bundles/robbyrussell/oh-my-zsh/lib/directories.zsh

# fz
# https://github.com/leon728/fz (forked from https://github.com/changyuheng/fz)
# description: feed fasd result into fzf, j for dir, k for file, jj/kk for dir/file under current directory
# e.g. j <TAB>, jj <TAB>, j test<TAB>

# fzf-z
# https://github.com/leon728/fzf-z (forked from https://github.com/andrewferrier/fzf-z)
# description: Ctrl-G, show fzf filter of recent directories, select and go
export FZFZ_RECENT_DIRS_TOOL=fasd
export FZFZ_SUBDIR_LIMIT=0
export FZFZ_UNIQUIFIER=cat
export FZFZ_PREVIEW_COMMAND='ls --color --group-directories-first {}'
#export FZFZ_PREVIEW_COMMAND='echo'

# https://github.com/zsh-users/zsh-syntax-highlighting
ZSH_HIGHLIGHT_MAXLENGTH=200

# https://github.com/zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=100
bindkey "^J" autosuggest-execute

# https://github.com/zdharma-continuum/fast-syntax-highlighting
# use this command to set my customized theme (once, it will be config and saved)
# > fast-theme ~/unix_rc/fsyh.ini

export RIPGREP_CONFIG_PATH=~/.ripgreprc
#zstyle ':fzf-tab:*' fzf-bindings 'ctrl-j:down' 'ctrl-k:up' 'tab:toggle'

#export GPG_TTY=$(tty)
export GPG_TTY=$TTY

export PATH="$HOME/.poetry/bin:$PATH"

export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
if [ -e $PYENV_ROOT/bin ]; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

DISABLE_AUTO_TITLE="true"
#ZSH_THEME_TERM_TITLE_IDLE="%~"

# Skip interactive setup for VS Code Copilot shell commands
if [[ "$TERM_PROGRAM" == "vscode" && ! -t 0 ]]; then
  return
fi
