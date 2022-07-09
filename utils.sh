
_in_pacman_is_installed() {
    package="$1";
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

_in_pacman_install() {
    package="$1";
    
    # If the package IS installed:
    if [[ $(_in_pacman_is_installed "${package}") == 0 ]]; then
        echo "${package} is already installed.";
        return;
    fi;
    
    # If the package is NOT installed:
    if [[ $(_in_pacman_is_installed "${package}") == 1 ]]; then
        sudo pacman -S "${package}";
    fi;
}

install_ubuntu_zsh(){
    sudo apt-get install fonts-powerline -y
    sudo apt-get install zsh -y
}

install_local_kitty(){
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
    sed -i "s/Icon\=kitty/Icon\=\/home\/$USER\/.local\/kitty.app\/share\/icons\/hicolor\/256x256\/apps\/kitty.png/g" ~/.local/share/applications/kitty.desktop
    sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator ~/.local/bin/kitty 50
    # FIN opcion 2
}
install_kitty(){
    export PATH="$HOME/.local/bin:$PATH"
    [ -d ~/.local/bin ] || mkdir -p ~/.local/bin
    
    # Opcion 2. No kitty en repos
    echo "Do you wish to install with apt?  ONLY ubuntu 20.04"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) sudo apt-get install kitty -y ; break;;  # si ubuntu 20.04 o superior
            No ) install_local_kitty ; break;;
        esac
    done
    
    #git clone --depth 1 git@github.com:dexpota/kitty-themes.git ~/.config/kitty/kitty-themes # not ok si no hay ssh
    git clone --depth 1 https://github.com/dexpota/kitty-themes.git ~/.config/kitty/kitty-themes
    # Si se tiene el fichero se copia, de momento son solo dos lineas xd
    
    #echo " ew" >> "$HOME"/.config/kitty/kitty.conf
    printf "\ninclude ./theme.conf" >> "$HOME"/.config/kitty/kitty.conf
    printf "map kitty_mod+plus change_font_size all +2.0" >> "$HOME"/.config/kitty/kitty.conf
    cd "$HOME"/.config/kitty || return
    ln -s ./kitty-themes/themes/Dracula.conf ~/.config/kitty/theme.conf
    sudo apt-get install fzf
    git clone https://github.com/lemnos/theme.sh.git
    cd theme.sh || return
    
    cp theme.sh ~/.local/bin
    echo "Elegir terminal por defecto. (Recomendado: Kitty)"
    
    
    sudo update-alternatives --config x-terminal-emulator
}

install_menlo(){
    git clone https://github.com/abertsch/Menlo-for-Powerline.git
    cd Menlo-for-Powerline || return
    sudo find . -type f -name "* *" -exec mv {} /usr/share/fonts \;
}
install_ubuntu_basics(){
    
    sudo apt-get install -y git xclip exuberant-ctags ncurses-term curl ranger tree
    
}




install_zsh_plugins(){
    # Install plugins for zsh
    cd "$ZDOTDIR"/plugins || return
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    echo "#Highlighting" >> "$ZDOTDIR"/.zshrc
    echo "source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$ZDOTDIR"/.zshrc
    
    git clone https://github.com/bobthecow/git-flow-completion.git
    echo "#Git-flow-completion" >> "$ZDOTDIR"/.zshrc
    echo "source $ZDOTDIR/plugins/git-flow-completion/git-flow-completion.zsh" >> "$ZDOTDIR"/.zshrc
    
    git clone https://github.com/supercrabtree/k.git
    echo "#K: Directory listing" >> "$ZDOTDIR"/.zshrc
    echo "source $ZDOTDIR/plugins/k/k.sh" >> "$ZDOTDIR"/.zshrc
}




prezto.sh(){
    # Get prezto
    git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
    
    # Backup zsh config if it exists
    if [ -f ~/.zshrc ];
    then
        mv ~/.zshrc ~/.zshrc.backup
    fi
    
    # Create links to zsh config files
    ln -s ~/.zprezto/runcoms/zlogin ~/.zlogin
    ln -s ~/.zprezto/runcoms/zlogout ~/.zlogout
    ln -s ~/.zprezto/runcoms/zpreztorc ~/.zpreztorc
    ln -s ~/.zprezto/runcoms/zprofile ~/.zprofile
    ln -s ~/.zprezto/runcoms/zshenv ~/.zshenv
    ln -s ~/.zprezto/runcoms/zshrc ~/.zshrc
}