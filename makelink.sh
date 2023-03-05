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
  ! test -d ${HOME}/.config/nvim && mkdir -pv ${HOME}/.config/nvim
  ln ${ln_options[*]} ${DOTFILES_DIR}/vim/init.vim ${HOME}/.config/nvim/init.vim
  ln ${ln_options[*]} ${DOTFILES_DIR}/vim/plugins.toml ${HOME}/.config/nvim/plugins.toml
}

function link_starshipfiles() {
  ln ${ln_options[*]} ${DOTFILES_DIR}/starship.toml ${HOME}/.config/starship.toml
}

link_bashfiles
link_zshfiles
link_neovimfiles
link_starshipfiles

