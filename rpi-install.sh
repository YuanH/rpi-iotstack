#!/bin/bash
function command_exists() {
	command -v "$@" >/dev/null 2>&1
}

function install() {
    if command_exists $@; then
    echo $@" already installed"
    upgrade $@
else
    echo "Install " $@
    sudo apt install -y $@
fi
}

function upgrade() {
    read -p "would you like to upgrade? [Y/n]" yn
    case $yn in
        [Yy]* ) sudo apt upgrade $@;;
        [Nn]* ) ;;
        * ) echo "Please answer y or n.";;
    esac
}


#CONFIGURE TIMEZONE AND LOCALE WITH raspi-config

while true; do
    read -p "Would you like to configure your raspberry pi? (i.e. locale / TimeZone) [Y/n]" yn
    case $yn in
        [Yy]* ) sudo raspi-config; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

install git
install npm
install vim


#sudo apt-get upgrade
#sudo apt-get install git
#sudo apt-get install npm
#sudo apt-get install vim
