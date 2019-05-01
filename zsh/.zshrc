#
# ~/.zshrc
#

PLATFORM=$(uname -s)

path=(
  ${HOME}/.jenv/bin(N-/)
  $path
)

fpath=(
  /usr/local/share/zsh-completions(N-/)
  $fpath
)

test -r ${HOME}/.zshrc.${PLATFORM} && source ${HOME}/.zshrc.${PLATFORM}

test -x /usr/local/bin/jenv && eval "$(jenv init -)"

# ##############################
# Look and Feel
# ##############################
# colors
autoload -Uz colors; colors

# https://geoff.greer.fm/lscolors/
export LSCOLORS="gxfxcxdxbxegedabagacad" # default: exfxcxdxbxegedabagacad
export LS_COLORS="di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# vcs info
autoload -Uz vcs_info

zstyle ':vcs_info:git:*'  check-for-changes true
zstyle ':vcs_info:git:*'  stagedstr         "%F{yellow}+%f"
zstyle ':vcs_info:git:*'  unstagedstr       "%F{red}+%f"
zstyle ':vcs_info:git:*'  formats           "%F{202}(%b%f%c%u%F{202})%f"
zstyle ':vcs_info:git:*'  actionformats     "%F{202}(%b%f%a%c%u%F{202})%f"

function _vcs_git_inside_tree() {
  if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]]; then
    return 0
  else
    return 1
  fi
}

function _vcs_git_untracked() {
  if _vcs_git_inside_tree && \
     (command git status --porcelain 2> /dev/null | command grep '^??' > /dev/null 2>&1); then
    return 0
  else
    return 1
  fi
}

# prompt
precmd() { vcs_info }
setopt prompt_subst

PROMPT="%F{green}[%n@%m%f (%*)%F{green}]%f: "
PROMPT+="%F{cyan}%~%f"$'\n'"%# "

RPROMPT='${vcs_info_msg_0_}'

# word separator
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# ##############################
# completion
# ##############################
autoload -Uz compinit && compinit

# for dotfiles
setopt globdots

zstyle ':completion:*' verbose yes
zstyle ':completion:*' format "%F{yellow}(・ω・)つ %B%d%b%f"
zstyle ':completion:*' group-name ''

zstyle ':completion:*' menu yes select=2

# color
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# case-insensitive
zstyle ':completion:*' matcher-list "m:{[:lower:]}={[:upper:]}"

# enable cache
zstyle ':completion:*' use-cache true

# ##############################
# history
# ##############################
HISTFILE=${HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=100000

# share history
setopt append_history
setopt share_history

# history with timestamp
setopt extended_history
alias history="history -t '%F %T'"

# ignore "history" command
setopt hist_no_store

# ignore duplicates
setopt hist_ignore_all_dups

# ignore extra blanks
setopt hist_reduce_blanks

# disable less history
export LESSHISTFILE=/dev/null

# ##############################
# aliases
# ##############################
alias mv='mv -iv'
alias cp='cp -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

alias type="type -a"

alias diff='diff -s'
alias grep='grep --color=auto'
alias less='less -M'

if [ $PLATFORM = "Darwin" ]; then
  alias ls="command ls -AFGh"
elif [ $PLATFORM = "Linux" ]; then
  alias ls="command ls -AFh --color=auto"
else
  alias ls="command ls -AFh"
fi

if command nvim --version > /dev/null 2>&1; then
  alias vi='nvim'
  alias vim='nvim'
elif command vim --version > /dev/null 2>&1; then
  alias vi='vim'
fi

