function command_exists() {
	command -v "$@" >/dev/null 2>&1
}

if command_exists docker; then
    echo "docker already installed"
else
    echo "Install Docker"
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker $USER 
fi 

if command_exists docker-compose; then
    echo "docker-compose already installed"
else
    echo "Install docker-compose"
    sudo apt install -y docker-compose
fi

if (whiptail --title "Restart Required" --yesno "It is recommended that you restart your device now. Select yes to do so now" 20 78); then
	sudo reboot
fi