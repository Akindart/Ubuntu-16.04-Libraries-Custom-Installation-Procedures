#!/bin/bash

echo "Eigen 3.3.7 installation by Akindart"
 
prefix=eigen

#Specify Eigen version
version="eigen-323c052e1731"

folder="/home/$USER/Eigen"

if [ ! -d "$folder" ]; then
	mkdir "$folder"
fi

cd $folder

# Verify the existence of cmake in the system
if [ ! -x "$(command -v cmake)" ]; then
	sudo apt -y cmake
fi

echo "Verifying for existance of Eigen 3.3.7 source folder"
if [ ! -d "$prefix"-"$version" ]; then
	echo ""
	echo "Eigen 3.3.7 not found."
	echo "Downloading binaries from http://bitbucket.org/eigen/eigen/get/3.3.7.tar.bz2"
	echo ""
	wget http://bitbucket.org/eigen/eigen/get/3.3.7.tar.bz2
	tar -xvjf eigen-eigen-323c052e1731.tar.bz2
fi

# Clean build directories
rm -rf "$prefix"-"$version"/build
rm -rf "$prefix"-"$version"-installation

# Create directory for installation
mkdir "$prefix"-"$version"/build
mkdir "$prefix"-"$version"-installation

cd "$prefix"-"$version"/build

cmake .. -D CMAKE_INSTALL_PREFIX="$folder"/"$prefix"-"$version"-installation

make -j 4
make install

echo "UPDATING EIGEN VALUES IN LOCAL VARIABLES IN /home/$USER/.bash_profile FILE"

echo ""

echo "Updating EIGEN_3_3_7_ROOT variable to:"
echo "------------->EIGEN_3_3_7_ROOT=$folder/$prefix-$version-installation"
sed -i -e "/EIGEN_3_3_7_ROOT=$folder\/$prefix-$version-installation/d" /home/"$USER"/.bash_profile
echo "EIGEN_3_3_7_ROOT=$folder/$prefix-$version-installation" >>/home/"$USER"/.bash_profile

echo ""

echo "Updating EIGEN_3_3_7_INCLUDE variable to:"
echo '------------->EIGEN_3_3_7_INCLUDE=$EIGEN_3_3_7_ROOT/include'
sed -i -e '/EIGEN_3_3_7_INCLUDE=$EIGEN_3_3_7_ROOT\/include/d' /home/"$USER"/.bash_profile
echo 'EIGEN_3_3_7_INCLUDE=$EIGEN_3_3_7_ROOT/include' >>/home/"$USER"/.bash_profile

echo ""

echo "Updating EIGEN_3_3_7_PKG_CONFIG variable to:"
echo '------------->EIGEN_3_3_7_PKG_CONFIG=$EIGEN_3_3_7_ROOT/share/pkgconfig'
sed -i -e '/EIGEN_3_3_7_PKG_CONFIG=$EIGEN_3_3_7_ROOT\/share\/pkgconfig/d' /home/"$USER"/.bash_profile
echo 'EIGEN_3_3_7_PKG_CONFIG=$EIGEN_3_3_7_ROOT/share/pkgconfig' >>/home/"$USER"/.bash_profile

echo ""

echo "Updating EIGEN_3_3_7_CMAKE_FILES variable to:"
echo '------------->EIGEN_3_3_7_CMAKE_FILES=$EIGEN_3_3_7_ROOT/share/eigen3/cmake'
sed -i -e '/EIGEN_3_3_7_INCLUDE=$EIGEN_3_3_7_ROOT\/share\/eigen3\/cmake/d' /home/"$USER"/.bash_profile
echo 'EIGEN_3_3_7_CMAKE_FILES=$EIGEN_3_3_7_ROOT/share/eigen3/cmake' >>/home/"$USER"/.bash_profile

echo ""

echo "Updating INCLUDE variable to:"
echo '------------->INCLUDE=$EIGEN_3_3_7_INCLUDE:$INCLUDE'
sed -i -e '/INCLUDE=$EIGEN_3_3_7_INCLUDE:$INCLUDE/d' /home/"$USER"/.bash_profile
echo 'INCLUDE=$EIGEN_3_3_7_INCLUDE:$INCLUDE' >>/home/"$USER"/.bash_profile

echo ""

echo "Updating PKG_CONFIG_PATH variable to:"
echo '------------->PKG_CONFIG_PATH=$EIGEN_3_3_7_PKG_CONFIG:$PKG_CONFIG_PATH'
sed -i -e '/PKG_CONFIG_PATH=$EIGEN_3_3_7_PKG_CONFIG:$PKG_CONFIG_PATH/d' /home/"$USER"/.bash_profile
echo 'PKG_CONFIG_PATH=$EIGEN_3_3_7_PKG_CONFIG:$PKG_CONFIG_PATH' >>/home/"$USER"/.bash_profile

echo ""

echo "Updating CMAKE_MODULE_PATH variable to:"
echo '------------->CMAKE_MODULE_PATH=EIGEN_3_3_7_CMAKE_FILES:$CMAKE_MODULE_PATH'
sed -i -e '/CMAKE_MODULE_PATH=EIGEN_3_3_7_CMAKE_FILES:$CMAKE_MODULE_PATH/d' /home/"$USER"/.bash_profile
echo 'CMAKE_MODULE_PATH=EIGEN_3_3_7_CMAKE_FILES:$CMAKE_MODULE_PATH' >>/home/"$USER"/.bash_profile

echo ""

echo '' >>/home/"$USER"/.bash_profile

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