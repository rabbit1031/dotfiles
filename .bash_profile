#
# ~/.bash_profile
#

# bashrc
if [ -f "${HOME}/.bashrc" ]; then
	source "${HOME}/.bashrc"
fi

# user bin
if [ -d "${HOME}/bin" ]; then
	PATH="${PATH}:${HOME}/bin"
fi
