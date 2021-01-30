#
# ~/.zshrc
#

PLATFORM=$(uname -s)

path=(
  /usr/local/opt/ruby/bin(N-/)
  $path
)

[[ -r ${HOME}/.zshrc.${PLATFORM} ]] && source ${HOME}/.zshrc.${PLATFORM}

zmodload zsh/zpty

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
zstyle ':vcs_info:git:*'  stagedstr         "%F{green}+%f"
zstyle ':vcs_info:git:*'  unstagedstr       "%F{red}+%f"
zstyle ':vcs_info:git:*'  formats           "%F{202}(%b%f%c%u%F{202})%f"
zstyle ':vcs_info:git:*'  actionformats     "%F{202}(%b%f%a%c%u%F{202})%f"

# prompt
precmd() { vcs_info }
setopt prompt_subst

if [[ -z "${SSH_CONNECTION}" ]]; then
  PROMPT="%F{green}[%n@%m%f (%*)%F{green}]%f: "
else
  PROMPT="%F{yellow}[%n@%m%f (%*)%F{yellow}]%f: "
fi
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

setopt hist_ignore_space

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

alias pip-update="pip3 list --outdated --format json | jq -r '.[].name' | xargs -p pip3 install -U"

if command nvim --version > /dev/null 2>&1; then
  alias vi='nvim'
  alias vim='nvim'
  export EDITOR='nvim'
  export DIFFPROG='nvim -d'
elif command vim --version > /dev/null 2>&1; then
  alias vi='vim'
  export EDITOR='vim'
  export DIFFPROG='vimdiff'
fi

# google-cloud-sdk
[[ -s "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ]] && source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
[[ -s "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ]] && source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

