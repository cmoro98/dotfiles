export PATH="$HOME/.local/bin:$PATH"

. $ZDOTDIR/.alias
# zsh completion system
autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files
source $ZDOTDIR/completion.zsh


# +--------+
# | PROMPT |
# +--------+

# the prompt theme
fpath=($ZDOTDIR/theme $fpath)
autoload -Uz agnoster.zsh-theme; agnoster.zsh-theme


# zsh directory Stack
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.


# +-----+
# | VIM |
# +-----+

# Vi mode
bindkey -v
bindkey '^R' history-incremental-search-backward

export KEYTIMEOUT=1

# CURSOR... nO hay nada de momento


# vim mapping, no se si me gusta

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history


#Plugins






