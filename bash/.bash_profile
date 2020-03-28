#
# ~/.bash_profile
#

# bashrc
test -r ${HOME}/.bashrc && source ${HOME}/.bashrc

# user bin
test -d ${HOME}/bin && PATH="${HOME}/bin:$PATH"
export PATH=${PATH}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"
