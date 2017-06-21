#
# ~/.bash_profile
#

# bashrc
test -r ${HOME}/.bashrc && source ${HOME}/.bashrc

# user bin
test -d ${HOME}/bin && PATH="${HOME}/bin:$PATH"
export PATH=${PATH}
