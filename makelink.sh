#! /bin/bash

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
  ln ${ln_options[*]} ${DOTFILES_DIR}/bash/.bash_profile ${HOME}/.bashrc
  ln ${ln_options[*]} ${DOTFILES_DIR}/bash/.bashrc ${HOME}/.bashrc
}

function link_zshfiles() {
  ln ${ln_options[*]} ${DOTFILES_DIR}/.zshrc ${HOME}/.zshrc
}

function link_vimfiles() {
  ln ${ln_options[*]} ${DOTFILES_DIR}/.vimrc ${HOME}/.vimrc
}

function link_atomfiles() {
  ln ${ln_options[*]} ${DOTFILES_DIR}/atom/config.cson ${HOME}/.atom/config.cson
  ln ${ln_options[*]} ${DOTFILES_DIR}/atom/github.cson ${HOME}/.atom/github.cson
  ln ${ln_options[*]} ${DOTFILES_DIR}/atom/init.coffee ${HOME}/.atom/init.coffee
  ln ${ln_options[*]} ${DOTFILES_DIR}/atom/keymap.cson ${HOME}/.atom/keymap.cson
  ln ${ln_options[*]} ${DOTFILES_DIR}/atom/snippets.cson ${HOME}/.atom/snippets.cson
  ln ${ln_options[*]} ${DOTFILES_DIR}/atom/styles.less ${HOME}/.atom/styles.less
}

link_bashfiles
link_zshfiles
link_vimfiles
link_atomfiles
