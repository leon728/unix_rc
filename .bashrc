export EDITOR=vim
export PAGER=less
export LESS=-iR

export HISTCONTROL=ignoredups

alias ll='ls -lF'
alias lg='ls -lF --group-directories-first'
alias la='ls -AlF'
alias g='grep -i'
alias ns='netstat'
alias t='telnet'

#export PS1='\[\e[1;33m\]\u\[\e[1;34m\]@\[\e[1;35m\]\H\[\e[0m\] \[\e[1;31m\]!\!\[\e[0m\] \[\e[1;32m\]\t\[\e[0m\] \[\e[1;37m\]\w\[\e[0m\]\n\[\e[1;37m\]\$\[\e[0m\] '
#export PS1='\[\e[0;90m\]\t \[\e[0;36m\]\u \[\e[0;33m\]\w\n\[\e[0;37m\]\$\[\e[0m\] '

source ~/.colorrc
#PROMPT_COMMAND="PS1='${On_Blue}\t ${Yellow}\w\n${White}\$${Color_Off} '; "

## >> git prompt
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
#export GIT_PS1_SHOWSTASHSTATE=1
#export GIT_PS1_SHOWUNTRACKEDFILES=1
#export GIT_PS1_DESCRIBE_STYLE="branch"
#export GIT_PS1_SHOWUPSTREAM="auto git"
PROMPT_COMMAND='__git_ps1 "${On_Blue}\t${Color_Off}" " ${Yellow}\w\n${White}\$${Color_Off} "'

## >> highlight warning and error when make
make() {
  ccError=$(echo -e "\033[41m")
  ccWarn=$(echo -e "\033[33m")
  ccReset=$(echo -e "\033[0m")
  /usr/bin/make "$@" 2>&1 | \
  sed -E -e "s/.* (error:|Error|cannot find|undefined reference) .*/$ccError&$ccReset/g" \
       -e "s/.* warning: .*/$ccWarn&$ccReset/g"
  return ${PIPESTATUS[0]}
}
