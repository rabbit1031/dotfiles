#
# ~/.bashrc
#

# prompt
PS1='\[\e[0;32m\]\u@\h \[\e[0;37m\][\t]: \[\e[0;36m\]\w\n\[\e[0;37m\]\$\[\e[00m\] '

# bash_history
export HISTSIZE=100000
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT='%F %T '
function sync_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='sync_history'
shopt -u histappend

# bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# LSCOLORS (default: exfxcxdxbxegedabagacad)
export LSCOLORS='gxfxcxdxbxegedabagacad'

# aliases
alias mv='mv -iv'
alias cp='cp -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

alias ls='ls -AhFG'
alias less='less -M'
alias grep='grep --color'
