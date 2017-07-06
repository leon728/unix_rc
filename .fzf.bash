# Setup fzf
# ---------
if [[ ! "$PATH" == */home/leon/workspace/fzf/bin* ]]; then
  export PATH="$PATH:/home/leon/workspace/fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/leon/workspace/fzf/man* && -d "/home/leon/workspace/fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/leon/workspace/fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/leon/workspace/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/leon/workspace/fzf/shell/key-bindings.bash"

