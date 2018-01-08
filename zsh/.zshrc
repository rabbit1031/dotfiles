# vim:set ts=2 sts=2 sw=2:
#
# ~/.zshrc
#

# platform
PLATFORM=$(uname -s)

# WORDCHARS
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# LSCOLORS (https://geoff.greer.fm/lscolors/)
export LSCOLORS='gxfxcxdxbxegedabagacad' # default: exfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# prompt setting
autoload -Uz colors && colors
setopt prompt_subst

PROMPT="%{$fg[green]%}[%n@%m]%{$reset_color%} (%*): %{$fg[cyan]%}%~%{$reset_color%}"$'\n'"%# "

# completion settings
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit && compinit

setopt globdots # for dotfiles

zstyle ':completion:*' verbose yes
zstyle ':completion:*' format %B%d%b
zstyle ':completion:*' group-name ''

zstyle ':completion:*' menu yes select=2

# color
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# case-insensitive
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

# history settings
HISTFILE=${HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=100000

setopt append_history

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history

# aliases
alias mv='mv -iv'
alias cp='cp -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'
alias chmod='chmod -c'
alias chown='chown -c'

alias diff='diff -s'
alias grep='grep -n --color=auto'
alias less='less -M'
alias vi='vim'

# colorized ls
if [ $PLATFORM = "Darwin" ]; then
  alias ls='ls -AhFG'
elif [ $PLATFORM = "Linux" ]; then
  alias ls='ls -AhF --color=auto'
fi
