#!/bin/bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/utils.sh"


############################
##   Constantes Colores   ##
############################
amarillo="\033[1;33m"
azul="\033[1;34m"
blanco="\033[1;37m"
cyan="\033[1;36m"
gris="\033[0;37m"
magenta="\033[1;35m"
rojo="\033[1;31m"
verde="\033[1;32m"
############################i

# super + shift arrow cool to move between monitors



# Usefull commands that you will forgett

# List fonts: fc-list


readonly DOTFILES_PATH=/home/$USER/.dotfiles/

readonly GIT_BACKUP_PATH="${DOTFILES_PATH}"git_backup
readonly ZSH_BACKUP_PATH="${DOTFILES_PATH}"zsh_backup



configure_gitconfig(){
    # Secure current .gitconfig
    mkdir -p "${GIT_BACKUP_PATH}"
    [ -f "${HOME}".gitconfig ] && cp "${HOME}".gitconfig "${GIT_BACKUP_PATH}"

    # Create a link to dotfiles .gitconfig.
    ln -s "${DOTFILES_PATH}"git_config/.gitconfig $HOME
}



configure_zsh(){
    # .zshenv - Should only contain user’s environment variables.
    # .zprofile - Can be used to execute commands just after logging in.
    # .zshrc - Should be used for the shell configuration and for executing commands.
    # .zlogin - Same purpose than .zprofile, but read just after .zshrc.
    # .zlogout - Can be used to execute commands when a shell exit.
    

    # Secure current .zsh
    mkdir -p "${ZSH_BACKUP_PATH}"
    cp "${HOME}".zshrc "${ZSH_BACKUP_PATH}"


    cp -r "${DOTFILES_PATH}"zsh "$HOME"/.config
    cp zsh/.zshenv "$HOME"
    export ZDOTDIR="${DOTFILES_PATH}"zsh
    [ -f ~/.zshrc ] && cp .zshrc .zshrc.backup
    [ -f ~/.zshrc ] && rm -f .zshrc
}



manjaro_config(){

    # Git
    configure_gitconfig

    # ZSH
    # i like manjaro default zsh confi
    # package="zsh";
    # _in_pacman_install "${package}";
    # configure_zsh

    # logitech
    # install logiops look arch wiki
    # just copy logid.cfg to /etc/logid.cfg

    
}
main() {
    manjaro_config
}
main "$@"
