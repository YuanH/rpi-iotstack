#!/bin/bash
# Only run this script after hassio is installed
# This is a modifciation to # curl -sfSL https://hacs.xyz/install | bash -

if [ -z "$(command -v wget)" ]; then
    echo "wget is not installed"
    exit
fi

if [ -z "$(command -v unzip)" ]; then
    echo "unzip is not installed"
    exit
fi

cd /home/pi/rpi-iotstack/version3/hassio_config

echo "Trying to find the correct directory"

if [ -f "$PWD/home-assistant.log" ]; then
    echo "Current directory is correct"

elif [ -f "/config/home-assistant.log" ]; then
    echo "Changing directory to /config"
    cd /config || exit

elif [ -f "$HOME/.homeassistant/home-assistant.log" ]; then
    echo "Changing directory to $HOME/.homeassistant"
    cd "$HOME/.homeassistant" || exit

elif [ -f "$HOME/homeassistant/home-assistant.log" ]; then
    echo "Changing directory to $HOME/homeassistant"
    cd "$HOME/homeassistant" || exit

elif [ -f "/usr/share/hassio/homeassistant/home-assistant.log" ]; then
    echo "Changing directory to /usr/share/hassio/homeassistant"
    cd /usr/share/hassio/homeassistant || exit

else
    echo "Could not find the directory for Home Assistant."
    echo "Manually change the directory to the root of your Home Assistant configuration"
    echo "With the user that is running Home Assistant"
    echo "and run the script again"
    exit
fi

if [ ! -d "$PWD/custom_components" ]; then
    echo "Creating custom_components directory"
    mkdir custom_components
fi

echo "Changing to the custom_components directory"
cd custom_components || exit

echo "Downloading HACS"
wget "https://github.com/hacs/integration/releases/latest/download/hacs.zip"

if [ -d "$PWD/hacs" ]; then
    echo "HACS directory already exists, cleaning up"
    rm -R hacs
fi

echo "Creating HACS directory"
mkdir hacs

echo "Unpacking HACS"
unzip hacs.zip -d hacs

echo "Removing HACS zip file"
rm hacs.zip
echo "Installation completed"
echo
echo "Remember to restart Home Assistant before you configure it"