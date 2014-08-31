#!/bin/sh
#
# This script creates a Vagrant VM fully provisioned with Intel DPDK
#

# Create VM first without provision. This is needed because I need to
# set some flags related to the VirtualBox VM before starting the installation
# of the Intel DPDK in the guest OS
vagrant up --no-provision
vagrant halt

# At this stage after the VM is created I need to configure VirtualBox
# to enable passthrough of SSE 4.1 and SSE 4.2 instructions, according to this:
# https://www.virtualbox.org/manual/ch09.html#sse412passthrough
# This step is fundamental otherwise DPDK won't build
# It is possible to verify in the guest OS that these changes took effect by running
# "cat /proc/cpuinfo" and checking that "sse4_1" and "sse4_2" are listed among the 
# CPU flags
VBoxManage setextradata "ubuntu-14.04-dpdk" VBoxInternal/CPUM/SSE4.1 1
VBoxManage setextradata "ubuntu-14.04-dpdk" VBoxInternal/CPUM/SSE4.2 1

# Now I can start the VM, which will in turn launch the provision script installing DPDK
vagrant up --provision
 