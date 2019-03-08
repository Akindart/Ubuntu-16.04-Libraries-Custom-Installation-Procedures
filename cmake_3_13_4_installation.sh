#!/bin/bash

echo "CMake 3.13.4 installation by Akindart"
 
prefix=cmake

#Specify CMake version
version="3.13.4-Linux-x86_64"

folder="/home/$USER/CMake"

if [ ! -d "$folder" ]; then
	mkdir "$folder"
fi

cd $folder

echo "Verifying for existance of CMake 3.14.4 source folder"
if [ ! -d "$prefix"-"$version" ]; then
	echo ""
	echo "CMake 3.13.4 not found."
	echo "Downloading binaries from https://github.com/Kitware/CMake/releases/download/v3.13.4/cmake-3.13.4-Linux-x86_64.tar.gz"
	echo ""
	wget https://github.com/Kitware/CMake/releases/download/v3.13.4/cmake-3.13.4-Linux-x86_64.tar.gz
	tar -xvzf cmake-3.13.4-Linux-x86_64.tar.gz
fi

echo "UPDATING CMAKE VALUES IN LOCAL VARIABLES IN /home/$USER/.bash_profile FILE"

echo ""

echo "Updating CMAKE_3_13_4_ROOT variable to:"
echo "------------->CMAKE_3_13_4_ROOT=$folder/$prefix-$version-installation"
sed -i -e "/CMAKE_3_13_4_ROOT=$folder\/$prefix-$version-installation/d" /home/"$USER"/.bash_profile
echo "CMAKE_3_13_4_ROOT=$folder/$prefix-$version-installation" >>/home/"$USER"/.bash_profile

echo ""

echo "Updating CMAKE_3_13_4_BIN variable to:"
echo '------------->CMAKE_3_13_4_BIN=$CMAKE_3_13_4_ROOT/bin'
sed -i -e '/CMAKE_3_13_4_BIN=$CMAKE_3_13_4_ROOT\/bin/d' /home/"$USER"/.bash_profile
echo 'CMAKE_3_13_4_BIN=$CMAKE_3_13_4_ROOT/bin' >>/home/"$USER"/.bash_profile

echo ""

echo "Updating PATH variable to:"
echo '------------->PATH=$CMAKE_3_13_4_BIN:$PATH'
sed -i -e '/PATH=$CMAKE_3_13_4_BIN:$PATH/d' /home/"$USER"/.bash_profile
echo 'PATH=$CMAKE_3_13_4_BIN:$PATH' >>/home/"$USER"/.bash_profile

echo '' >>/home/"$USER"/.bash_profile

echo ""

echo "Exporting PATH variable:"
echo '------------->export PATH'
sed -i '/^export.*PATH/d' /home/"$USER"/.bash_profile
echo 'export PATH' >>/home/"$USER"/.bash_profile

echo ""

echo "Exporting LD_LIBRARY_PATH variable:"
echo '------------->export LD_LIBRARY_PATH'
sed -i '/^export.*LD_LIBRARY_PATH/d' /home/"$USER"/.bash_profile
echo 'export LD_LIBRARY_PATH' >>/home/"$USER"/.bash_profile

echo ""

echo "Exporting LIBRARY_PATH variable:"
echo '------------->export LIBRARY_PATH=$LD_LIBRARY_PATH'
sed -i '/^export.*LIBRARY_PATH=$LD_LIBRARY_PATH/d' /home/"$USER"/.bash_profile
echo 'export LIBRARY_PATH=$LD_LIBRARY_PATH' >>/home/"$USER"/.bash_profile

echo ""

echo "Exporting CMAKE_MODULE_PATH variable:"
echo '------------->export CMAKE_MODULE_PATH'
sed -i '/^export.*CMAKE_MODULE_PATH/d' /home/"$USER"/.bash_profile
echo 'export CMAKE_MODULE_PATH' >>/home/"$USER"/.bash_profile

echo ""

echo "Exporting PKG_CONFIG_PATH variable:"
echo '------------->export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig'
sed -i '/^export.*PKG_CONFIG_PATH=$PKG_CONFIG_PATH:\/usr\/local\/lib\/pkgconfig\/d' /home/"$USER"/.bash_profile
echo 'export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig' >>/home/"$USER"/.bash_profile

