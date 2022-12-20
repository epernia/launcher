#!/bin/bash

set -e
set -x

# sudo add-apt-repository --yes ppa:beineri/opt-qt593-trusty
sudo add-apt-repository --yes ppa:ubuntu-toolchain-r/test
echo "deb http://pkg.mxe.cc/repos/apt bionic main" \
    | sudo tee /etc/apt/sources.list.d/mxeapt.list
#echo 'APT::Get::AllowUnauthenticated "true";' \
##    | sudo tee /etc/apt/apt.conf.d/99myown

sudo apt-get update -qq --allow-unauthenticated --allow-insecure-repositories

sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

sudo wget https://raw.githubusercontent.com/martinribelotta/pydeployqt/master/deploy.py -O /usr/bin/pydeployqt
sudo chmod a+x /usr/bin/pydeployqt

MXE=mxe-i686-w64-mingw32.static-

sudo apt-get install  -y --no-install-recommends -o Dpkg::Options::="--force-overwrite" --allow-unauthenticated \
	gcc-8 g++-8 build-essential \
	qt59base qt59tools qt59svg qt59imageformats qt59x11extras libglu1-mesa-dev \
	wget fuse ${MXE}gcc ${MXE}g++ ${MXE}qtbase

gcc --version
# sudo update-alternatives --remove-all gcc
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 90 --slave /usr/bin/g++ g++ /usr/bin/g++-8
gcc --version

cd /tmp/
wget -c "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage"
sudo cp linuxdeployqt-continuous-x86_64.AppImage /usr/bin/linuxdeployqt
sudo chmod a+x /usr/bin/linuxdeployqt
cd -
