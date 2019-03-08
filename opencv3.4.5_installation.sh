#!/bin/bash

echo "OpenCV 3.4.5 installation"
 
prefix=opencv

#Specify OpenCV version
version="3.4.5"

folder="/home/$USER/OpenCV"

if [ ! -x "$(command -v cmake)" ]; then
	sudo apt -y cmake
fi

## Install basic dependencies
sudo apt -y install build-essential checkinstall pkg-config yasm
sudo apt -y install git

# Verify the existence of cmake in the system
if [ ! -d "$folder" ]; then
	mkdir "$folder"
fi

cd $folder

echo "Verifying for existance of OpenCV 3.4.5 source folder"
if [ ! -d "$prefix"-"$version" ]; then
	echo "OpenCV 3.4.5 not found."
	echo "Clonning from git repository clone https://github.com/opencv/opencv.git"
	git clone https://github.com/opencv/opencv.git
	mv opencv opencv-"$version"-test
	sha1_commit=8f1356c3c5b16721349582db461a2051653059e8
	cd opencv-"$version"-test
	git reset --hard $sha1_commit
fi

cd $folder

echo "Verifying for existance of OpenCV_contrib 3.4.5 source folder"
if [ ! -d "$prefix"_contrib-"$version" ]; then
	echo "OpenCV_contrib 3.4.5 not found."
	echo "Clonning from git repository clone https://github.com/opencv/opencv_contrib.git"
	git clone https://github.com/opencv/opencv_contrib.git
	mv opencv_contrib opencv_contrib-"$version"
	sha1_commit=7292df62624ded8af8035231435dfd17c93e1a80
	cd opencv_contrib-"$version"
	git reset --hard $sha1_commit
fi

cd $folder

# Clean build directories
rm -rf "$prefix"-"$version"/build
rm -rf "$prefix"-"$version"-installation

# Create directory for installation
mkdir "$prefix"-"$version"/build
mkdir "$prefix"-"$version"-installation

# Save current working directory
cwd=$(pwd)

sudo apt -y update	
sudo apt -y upgrade

sudo apt -y remove x264 libx264-dev
 
## Install dependencies	
sudo apt -y install gfortran
sudo apt -y install libjpeg8-dev libjasper-dev libpng12-dev
 
sudo apt -y install libtiff5-dev
 
sudo apt -y install libtiff-dev
 
sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
sudo apt -y install libxine2-dev libv4l-dev
cd /usr/include/linux
sudo ln -s -f ../libv4l1-videodev.h videodev.h
cd $cwd
 
sudo apt -y install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
sudo apt -y install libgtk2.0-dev libtbb-dev qt5-default
sudo apt -y install libatlas-base-dev
sudo apt -y install libfaac-dev libmp3lame-dev libtheora-dev
sudo apt -y install libvorbis-dev libxvidcore-dev
sudo apt -y install libopencore-amrnb-dev libopencore-amrwb-dev
sudo apt -y install libavresample-dev
sudo apt -y install x264 v4l-utils
 
# # Optional dependencies
sudo apt -y install libprotobuf-dev protobuf-compiler
sudo apt -y install libgoogle-glog-dev libgflags-dev
sudo apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

sudo apt -y install python3-dev python3-pip python3-venv
sudo -H pip3 install -U pip numpy
sudo apt -y install python3-testresources

cd "$prefix"-"$version"/build

cmake .. -D CMAKE_BUILD_TYPE=RELEASE \
         -D CMAKE_INSTALL_PREFIX=$folder/"$prefix"-"$version"-installation \
         -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON \
         -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON \
         -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON \
         -D WITH_QT=ON -D WITH_OPENGL=ON -D ENABLE_FAST_MATH=1 \
         -D CUDA_FAST_MATH=1 -D WITH_CUDA=ON \
         -D BUILD_opencv_cudacodec=OFF \
         -D OPENCV_EXTRA_MODULES_PATH=$folder/"$prefix"_contrib-"$version"/modules $folder/"$prefix"-"$version"

make -j 4
make install

sed -i -e "/OPENCV_3_ROOT=$folder\/$prefix-$version-installation/d" /home/"$USER"/.bash_profile
echo "OPENCV_3_ROOT=$folder/$prefix-$version-installation" >>/home/"$USER"/.bash_profile

sed -i -e '/OPENCV_BIN=$OPENCV_3_ROOT\/bin/d' /home/"$USER"/.bash_profile
echo 'OPENCV_BIN=$OPENCV_3_ROOT/bin' >>/home/"$USER"/.bash_profile

sed -i -e '/OPENCV_INCLUDE=$OPENCV_3_ROOT\/include/d' /home/"$USER"/.bash_profile
echo 'OPENCV_INCLUDE=$OPENCV_3_ROOT/include' >>/home/"$USER"/.bash_profile

sed -i -e '/OPENCV_LIB=$OPENCV_3_ROOT\/lib/d' /home/"$USER"/.bash_profile
echo 'OPENCV_LIB=$OPENCV_3_ROOT/lib' >>/home/"$USER"/.bash_profile

sed -i -e '/OPENCV_PKG_CONFIG=$OPENCV_LIB\/pkgconfig/d' /home/"$USER"/.bash_profile
echo 'OPENCV_PKG_CONFIG=$OPENCV_LIB/pkgconfig' >>/home/"$USER"/.bash_profile

sed -i -e '/OPENCV_CMAKE_FILES=$OPENCV_3_ROOT\/share\/OpenCV/d' /home/"$USER"/.bash_profile
echo 'OPENCV_CMAKE_FILES=$OPENCV_3_ROOT/share/OpenCV' >>/home/"$USER"/.bash_profile

echo '' >>/home/"$USER"/.bash_profile

sed -i -e '/PATH=$OPENCV_BIN:$PATH/d' /home/"$USER"/.bash_profile
echo 'PATH=$OPENCV_BIN:$PATH' >>/home/"$USER"/.bash_profile

sed -i -e '/INCLUDE=$OPENCV_INCLUDE:$INCLUDE/d' /home/"$USER"/.bash_profile
echo 'INCLUDE=$OPENCV_INCLUDE:$INCLUDE' >>/home/"$USER"/.bash_profile

sed -i -e '/LD_LIBRARY_PATH=$OPENCV_LIB:$LD_LIBRARY_PATH/d' /home/"$USER"/.bash_profile
echo 'LD_LIBRARY_PATH=$OPENCV_LIB:$LD_LIBRARY_PATH' >>/home/"$USER"/.bash_profile

sed -i -e '/PKG_CONFIG_PATH=$OPENCV_PKG_CONFIG:$PKG_CONFIG_PATH/d' /home/"$USER"/.bash_profile
echo 'PKG_CONFIG_PATH=$OPENCV_PKG_CONFIG:$PKG_CONFIG_PATH' >>/home/"$USER"/.bash_profile

sed -i -e '/CMAKE_MODULE_PATH=$OPENCV_CMAKE_FILES:$CMAKE_MODULE_PATH/d' /home/"$USER"/.bash_profile
echo 'CMAKE_MODULE_PATH=$OPENCV_CMAKE_FILES:$CMAKE_MODULE_PATH' >>/home/"$USER"/.bash_profile

echo '' >>/home/"$USER"/.bash_profile

sed -i '/^export.*PATH/d' /home/"$USER"/.bash_profile
echo 'export PATH' >>/home/"$USER"/.bash_profile

sed -i '/^export.*LD_LIBRARY_PATH/d' /home/"$USER"/.bash_profile
echo 'export LD_LIBRARY_PATH' >>/home/"$USER"/.bash_profile

sed -i '/^export.*LIBRARY_PATH=$LD_LIBRARY_PATH/d' /home/"$USER"/.bash_profile
echo 'export LIBRARY_PATH=$LD_LIBRARY_PATH' >>/home/"$USER"/.bash_profile

sed -i '/^export.*CMAKE_MODULE_PATH/d' /home/"$USER"/.bash_profile
echo 'export CMAKE_MODULE_PATH' >>/home/"$USER"/.bash_profile

sed -i '/^export.*PKG_CONFIG_PATH=$PKG_CONFIG_PATH:\/usr\/local\/lib\/pkgconfig\/d' /home/"$USER"/.bash_profile
echo 'export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig' >>/home/"$USER"/.bash_profile