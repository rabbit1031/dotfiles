#! /bin/bash

PLATFORM=$(uname -s)

DOTFILES_DIR=$(cd `dirname $0`; pwd)
echo "DOTFILES_DIR: ${DOTFILES_DIR}"

declare -a ln_options=( -s -v )

for option in "$@"; do
  case "$option" in
    -* )
      if [[ "$option" =~ "f" ]]; then
        ln_options+=( -f )
      fi
      shift
      ;;
  esac
done

function safe_link_dir() {
  local src="$1"
  local dest="$2"
  
  if [ -L "${dest}" ]; then
    # Remove if it is already a symlink
    rm -f "${dest}"
  elif [ -d "${dest}" ]; then
    # Backup if it is a standard directory
    echo "Warning: ${dest} is an existing standard directory. Backing it up to ${dest}.bak"
    mv "${dest}" "${dest}.bak"
  elif [ -e "${dest}" ]; then
    # Remove if it exists as another type of file
    rm -f "${dest}"
  fi
  
  ln ${ln_options[*]} -sn "${src}" "${dest}"
}

function link_bashfiles() {
  ln ${ln_options[*]} ${DOTFILES_DIR}/bash/.bash_profile ${HOME}/.bash_profile
  ln ${ln_options[*]} ${DOTFILES_DIR}/bash/.bashrc ${HOME}/.bashrc
}

function link_zshfiles() {
  ln ${ln_options[*]} ${DOTFILES_DIR}/zsh/.zshrc ${HOME}/.zshrc
  if [ -r ${DOTFILES_DIR}/zsh/.zshrc.${PLATFORM} ]; then
    ln ${ln_options[*]} ${DOTFILES_DIR}/zsh/.zshrc.${PLATFORM} ${HOME}/.zshrc.${PLATFORM}
  fi
}

function link_neovimfiles() {
  ! test -d ${HOME}/.config && mkdir -pv ${HOME}/.config
  safe_link_dir "${DOTFILES_DIR}/nvim" "${HOME}/.config/nvim"
}

function link_starshipfiles() {
  ln ${ln_options[*]} ${DOTFILES_DIR}/starship.toml ${HOME}/.config/starship.toml
}

function link_gitfiles() {
  ln ${ln_options[*]} ${DOTFILES_DIR}/git/.gitconfig ${HOME}/.gitconfig
  ln ${ln_options[*]} ${DOTFILES_DIR}/git/.gitignore_global ${HOME}/.gitignore_global
}

function link_geminifiles() {
  ln ${ln_options[*]} ${DOTFILES_DIR}/agents/gemini/settings.json ${HOME}/.gemini/settings.json
  ln ${ln_options[*]} ${DOTFILES_DIR}/agents/AGENTS.md ${HOME}/.gemini/GEMINI.md
  safe_link_dir "${DOTFILES_DIR}/agents/gemini/policies" "${HOME}/.gemini/policies"
}

function link_claudefiles() {
  ! test -d ${HOME}/.claude && mkdir -pv ${HOME}/.claude
  ln ${ln_options[*]} ${DOTFILES_DIR}/agents/AGENTS.md ${HOME}/.claude/CLAUDE.md
  ln ${ln_options[*]} ${DOTFILES_DIR}/agents/claude/settings.json ${HOME}/.claude/settings.json
  ! test -d ${HOME}/.config/ccstatusline && mkdir -pv ${HOME}/.config/ccstatusline
  ln ${ln_options[*]} ${DOTFILES_DIR}/agents/claude/ccstatusline-settings.json ${HOME}/.config/ccstatusline/settings.json
  safe_link_dir "${DOTFILES_DIR}/agents/claude/commands" "${HOME}/.claude/commands"
  safe_link_dir "${DOTFILES_DIR}/agents/claude/plugins/notion-workflow/skills" "${HOME}/.claude/skills"
}

function link_npmfiles() {
  ln ${ln_options[*]} ${DOTFILES_DIR}/.npmrc ${HOME}/.npmrc
}

function link_ghosttyfiles() {
  ! test -d ${HOME}/.config/ghostty && mkdir -pv ${HOME}/.config/ghostty
  ln ${ln_options[*]} ${DOTFILES_DIR}/config.ghostty ${HOME}/.config/ghostty/config.ghostty
}

link_bashfiles
link_zshfiles
link_neovimfiles
link_starshipfiles
link_gitfiles
link_geminifiles
link_claudefiles
link_npmfiles
link_ghosttyfiles

