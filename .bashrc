export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US:en"

#source ~/.git-completion.bash
#source ~/.git-prompt.sh       # enable this if used in cygwin

export EDITOR=vim
export PAGER=less
export LESS=-iR
#export PAGER=most
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

# Use colors for less, man, etc.
[[ -f ~/.less_termcap ]] && . ~/.less_termcap

#source /usr/share/autojump/autojump.sh
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh

# cd commands, e.g. .., ..., ..2, ..3, .3, .4, d, ~, -, 1, 2, 3
[[ -f ~/.cdcmds.sh ]] && . ~/.cdcmds.sh

#export PS1='\[\e[1;33m\]\u\[\e[1;34m\]@\[\e[1;35m\]\H\[\e[0m\] \[\e[1;31m\]!\!\[\e[0m\] \[\e[1;32m\]\t\[\e[0m\] \[\e[1;37m\]\w\[\e[0m\]\n\[\e[1;37m\]\$\[\e[0m\] '
#export PS1='\[\e[0;90m\]\t \[\e[0;36m\]\u@\h \[\e[0;33m\]\w \[\e[0;37m\]\$\[\e[0m\] '
#export PS1='\[\e[0;37m\]\t \[\e[0;33m\]\w\n\[\e[0;97m\]\$\[\e[0m\] '

source ~/.colorrc
#PROMPT_COMMAND="PS1='${IBlack}\t ${Cyan}\u@\h ${Yellow}\w ${White}\$${Color_Off} '; "
PROMPT_COMMAND="PS1='${White}\t ${Yellow}\w\n${IWhite}\$${Color_Off} '; "

## >> git prompt
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1     # disable this if used in cygwin (bad performance)
export GIT_PS1_SHOWSTASHSTATE=1     # disable this if used in cygwin (bad performance)
export GIT_PS1_SHOWUNTRACKEDFILES=1 # disable this if used in cygwin (bad performance)
#export GIT_PS1_DESCRIBE_STYLE="branch"
#export GIT_PS1_SHOWUPSTREAM="auto git"
#PROMPT_COMMAND='__git_ps1 "${IBlack}\t ${Cyan}\u@\h${Color_Off}" " ${Yellow}\w ${White}\$${Color_Off} "'
PROMPT_COMMAND='__git_ps1 "${White}\t${Color_Off}" " ${Yellow}\w\n${IWhite}\$${Color_Off} "'

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

