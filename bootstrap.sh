#!/bin/bash

REPO_DIR=/home/vagrant/repos
DOWNLOAD_DIR=/opt/downloads

apt-get update

# Install various dependencies
apt-get install -y curl git cmake build-essential make gcc g++ libudev-dev

mkdir $DOWNLOAD_DIR

# Install nodejs
curl -L https://deb.nodesource.com/setup_6.x -o $DOWNLOAD_DIR/nodesource_setup.sh
chmod 755 $DOWNLOAD_DIR/nodesource_setup.sh
bash $DOWNLOAD_DIR/nodesource_setup.sh
apt-get -y install nodejs

# Install JLink
curl --data "accept_license_agreement=accepted" https://www.segger.com/downloads/jlink/JLink_Linux_V600i_x86_64.deb > $DOWNLOAD_DIR/jlink.deb
dpkg -i $DOWNLOAD_DIR/jlink.deb

# Install nrfjprog
NRFJPROG_ROOT=/opt/nrfjprog
curl -L https://www.nordicsemi.com/eng/nordic/download_resource/51386/15/89856469 -o $DOWNLOAD_DIR/nrfjprog.tar
tar xvf $DOWNLOAD_DIR/nrfjprog.tar -C /opt

# Install boost
export BOOST_ROOT=/opt/boost_1_61_0
curl -L http://downloads.sourceforge.net/project/boost/boost/1.61.0/boost_1_61_0.tar.bz2 -o $DOWNLOAD_DIR/boost.tar.bz2
tar xvjf $DOWNLOAD_DIR/boost.tar.bz2 -C /opt
cd $BOOST_ROOT && ./bootstrap.sh && ./b2 toolset=gcc cxxflags=-fPIC cflags=-fPIC address-model=64 link=static --with-thread --with-system --with-regex --with-date_time --with-chrono

# Update PATH
echo "export PATH=$NRFJPROG_ROOT:$BOOST_ROOT:$PATH" >> /home/vagrant/.bashrc

# Give access to serial port for vagrant user
usermod -a -G dialout vagrant

# Clone repositories
mkdir -p $REPO_DIR && cd $REPO_DIR
git clone https://github.com/NordicSemiconductor/pc-ble-driver.git
git clone https://github.com/NordicSemiconductor/pc-ble-driver-js.git
chown -R vagrant:vagrant $REPO_DIR
