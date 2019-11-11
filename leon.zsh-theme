function my_git_prompt() {
  tester=$(git rev-parse --git-dir 2> /dev/null) || return
  
  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""

  # is branch ahead?
  if $(echo "$(git log origin/$(git_current_branch)..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi

  # is anything staged?
  if $(echo "$INDEX" | command grep -E -e '^(D[ M]|[MARC][ MD]) ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
  fi

  # is anything unstaged?
  if $(echo "$INDEX" | command grep -E -e '^[ MARC][MD] ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
  fi

  # is anything untracked?
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi

  # is anything unmerged?
  if $(echo "$INDEX" | command grep -E -e '^(A[AU]|D[DU]|U[ADU]) ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
  fi

  if [[ -n $STATUS ]]; then
    STATUS=" $STATUS"
  fi

  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(my_current_branch)$STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function my_current_branch() {
  echo $(git_current_branch || echo "(no branch)")
}

function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "%{$fg[red]%}(ssh) "
  fi
}

#local ret_status="%(?:%{$fg[green]%}:%{$fg[red]%})[%?]"
#PROMPT=$'%{$fg[white]%}%* %{$fg[green]%}%n@%m$(my_git_prompt) %{$fg[yellow]%}%~\n${ret_status} %{$fg[white]%}%# %{$reset_color%}'
#PROMPT=$'%{$fg[white]%}%* %{$fg[green]%}%n@%m$(my_git_prompt) ${ret_status} %{$fg[white]%}%# %{$fg[yellow]%}%~%{$reset_color%}\n'

local ret_status2="%(?..%{$fg[red]%}[%?] )"
#PROMPT=$'%{$fg[white]%}%* %{$fg[green]%}%n@%m$(my_git_prompt) %{$fg[white]%}%# %{$fg[yellow]%}%~\n${ret_status2}%{$reset_color%}'
#PROMPT=$'%{$bg[blue]%}%{$fg[white]%}%* %{$fg[green]%}%n@%m%{$reset_color%}$(my_git_prompt) %{$fg[white]%}%# %{$fg[yellow]%}%~\n${ret_status2}%{$reset_color%}'
#PROMPT=$'%{$bg[blue]%}%{$fg[white]%}%* %{$fg[green]%}%n@%m%{$reset_color%} %{$fg[white]%}%# %{$fg[yellow]%}%~\n${ret_status2}%{$reset_color%}'
PROMPT=$'${ret_status2}%{$bg[blue]%}%{$fg[white]%}%* %{$fg[green]%}%n@%m%{$reset_color%} %{$fg[white]%}%# %{$fg[yellow]%}%~\n%{$reset_color%}'

ZSH_THEME_PROMPT_RETURNCODE_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" $fg[white](%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[magenta]%}↑"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}+" #●
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}*"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}?"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}✕"
ZSH_THEME_GIT_PROMPT_SUFFIX="$fg[white])%{$reset_color%}"
