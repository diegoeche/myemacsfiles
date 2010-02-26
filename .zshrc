# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/diegoeche/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Fix for emacs
[[ $EMACS = t ]] && unsetopt zle

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias l='ls -CF'
    alias la='ls -A'
    alias ll='ls -l'
fi

export PROMPT="%n@%m:%~% %h %# "
