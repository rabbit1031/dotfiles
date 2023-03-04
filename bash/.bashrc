# vim:set ts=2 sts=2 sw=2:
#
# ~/.bashrc
#

PLATFORM=$(uname -s)

# prompt
PS1='\[\e[0;32m\]\u@\h \[\e[0;37m\][\t]: \[\e[0;36m\]\w\n\[\e[0;37m\]\$\[\e[00m\] '

# bash_history
export HISTSIZE=100000
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT='%F %T '
export HISTIGNORE='cd:ls:[fb]g:exit:source'
function sync_history {
  history -a
  history -c
  history -r
}
PROMPT_COMMAND='sync_history'
shopt -u histappend

# disable less history
export LESSHISTFILE=/dev/null

# bash_completion
if [ $PLATFORM = "Darwin" ] && [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
  . $(brew --prefix)/share/bash-completion/bash_completion
fi

# aliases
alias mv='mv -iv'
alias cp='cp -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

alias less='less -M'
alias grep='grep -n --color=auto'

alias vi='vim'
alias clang='clang -Wall'
alias clang++='clang++ -Wall'

# colorized ls
if [ $PLATFORM = "Darwin" ]; then
  export LSCOLORS='gxfxcxdxbxegedabagacad' # default: exfxcxdxbxegedabagacad
  alias ls='ls -AhFG'
elif [ $PLATFORM = "Linux" ]; then
  alias ls='ls -AhF --color=auto'
fi

# tmux
if  [ -x "$(which fish)" ]; then
  alias tmux='SHELL=$(which fish) tmux'
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
