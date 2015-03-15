#!/bin/sh
#
# This script downloads, installs and configure the Intel DPDK framework
# on a clean Ubuntu 14.04 installation running in a virtual machine.
# 
# This script has been created based on the following scripts:
#  * https://gist.github.com/ConradIrwin/9077440
#  * http://dpdk.org/doc/quick-start

# # Install dependencies
sudo apt-get update
sudo apt-get -y -q install git build-essential linux-headers-`uname -r`
 
# Get code from Git repo
git clone http://dpdk.org/git/dpdk

# Move to the DPDK dir
cd dpdk

# Path to the build dir
export RTE_SDK=`pwd`

# Target of build process
export RTE_TARGET=x86_64-native-linuxapp-gcc

# Build code
# I am building from the dev branch (plus POPCNT patch) because the latest stable release
# at the time of writing this script (1.7.0) has a bug preventing DPDK compilation on Ubuntu 14.04
make config T=${RTE_TARGET}
make

# Install kernel modules
sudo modprobe uio
sudo insmod build/kmod/igb_uio.ko
 
# Configure hugepages
# You can later check if this change was successful with "cat /proc/meminfo"
echo 1024 | sudo tee /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
sudo mkdir /mnt/huge
sudo mount -t hugetlbfs nodev /mnt/huge
 
# Bind secondary network adapter
# I need to set a second adapter in Vagrantfile
sudo ifconfig eth1 down
sudo ${RTE_SDK}/tools/dpdk_nic_bind.py --bind=igb_uio eth1

# Add env variables setting to .profile file so that they are set at each login
echo "export RTE_SDK=${RTE_SDK}" >> ${HOME}/.profile
echo "export RTE_TARGET=${RTE_TARGET}" >> ${HOME}/.profile

# We need to do this to make the examples compile, not sure why.
ln -s ${RTE_SDK}/build ${RTE_SDK}/${RTE_TARGET}


