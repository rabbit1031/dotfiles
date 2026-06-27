#
# ~/.zshrc
#

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

path=(
  ${HOME}/.antigravity-ide/antigravity-ide/bin(N-/)
  $path
)

# ##############################
# Utilities
# ##############################
function isLinux() {
  [[ "$OSTYPE" == linux* ]]
}

function isDarwin() {
  [[ "$OSTYPE" == darwin* ]]
}

if isLinux; then
  source ${HOME}/.zshrc.Linux
fi

zmodload zsh/zpty

# ##############################
# Look and Feel
# ##############################
# colors
autoload -Uz colors; colors

# https://geoff.greer.fm/lscolors/
export LSCOLORS="gxfxcxdxbxegedabagacad" # default: exfxcxdxbxegedabagacad
export LS_COLORS="di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# word separator
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# ##############################
# completion
# ##############################

fpath=(
  ${HOMEBREW_PREFIX}/share/zsh/site-functions(N-/)
  $fpath
)

autoload -Uz compinit && compinit

# match hidden files without explicit dot
setopt globdots

# completion styling and formatting
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format "%F{yellow}(・ω・)つ %B%d%b%f"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu yes select=2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# case-insensitive completion
zstyle ':completion:*' matcher-list "m:{[:lower:]}={[:upper:]}"

# enable completion caching
zstyle ':completion:*' use-cache true

# ##############################
# history
# ##############################
HISTFILE=${HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=100000

# share history across sessions and append instead of overwrite
setopt append_history share_history

# save timestamp and duration
setopt extended_history
alias history="history -t '%F %T'"

# history ignore rules:
# - hist_no_store: exclude 'history' command itself
# - hist_ignore_all_dups: keep only the latest instance of duplicates
# - hist_reduce_blanks: remove extra spaces
# - hist_ignore_space: ignore commands starting with a space
setopt hist_no_store hist_ignore_all_dups hist_reduce_blanks hist_ignore_space

# disable less history file
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

if isDarwin; then
  alias ls="command ls -AFGh"
elif isLinux; then
  alias ls="command ls -AFh --color=auto"
else
  alias ls="command ls -AFh"
fi

alias pip-update="pip3 list --outdated --format json | jq -r '.[].name' | xargs -p pip3 install -U"

if (( $+commands[nvim] )); then
  alias vi='nvim'
  alias vim='nvim'
  export EDITOR='nvim'
  export VISUAL='nvim'
  export DIFFPROG='nvim -d'
elif (( $+commands[vim] )); then
  alias vi='vim'
  export EDITOR='vim'
  export VISUAL='vim'
  export DIFFPROG='vimdiff'
fi

# starship
(( $+commands[starship] )) && eval "$(starship init zsh)"

# fzf
(( $+commands[fzf] )) && source <(fzf --zsh)

# mise
(( $+commands[mise] )) && eval "$(mise activate zsh)"

# zsh plugins (MUST be loaded last)
[[ -s "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -s "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
