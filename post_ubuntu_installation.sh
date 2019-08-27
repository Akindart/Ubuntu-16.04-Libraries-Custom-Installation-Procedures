!#/bin/bash

echo "Installing dkms, linux-headers for this distribution and build essential tools"

apt install --assume-yes cmake dkms linux-headers-$(uname -r) build-essential	

echo "Now installing libraries to help compile cuda samples"

#mokutil to add stuff to secure boot
apt install --assume-yes mokutil

#install doxygen
apt install --assume-yes doxygen-*

#things to help cuda
apt install --assume-yes freeglut3-dev libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx libglu1-mesa libglu1-mesa-dev libglfw3-dev libgles2-mesa-dev

#install libraries for chrome
apt install --assume-yes libxss1 libappindicator1 libindicator7
dpkg -i /home/spades/Downloads/google-chrome-stable_current_amd64.deb

#install unity-tweak-tools
apt install --assume-yes unity-tweak-tool

#intalling sublime3

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt-get update
apt install --assume-yes sublime-text

#installing spotify

# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# 3. Update list of available packages
apt-get update

# 4. Install Spotify
apt install spotify-client
