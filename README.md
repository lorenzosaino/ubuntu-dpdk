# DPDK Ubuntu 14.04 Vagrant VM
This project contains scripts and configuration files to create a Ubuntu 14.04 virtual machine with the Intel DPDK framework installed and fully configured.

## Setup
To set up a Vagrant virtual machine, first make sure that you have [Vagrant](http://www.vagrantup.com) installed and configured (this code has been tested with version 1.6.3).
Then, make sure that you have the `chef/ubuntu-14.04` box installed. You can check it by typing:

    $ vagrant box list

If you do not see it in the list, then install it with:

    $ vagrant box add chef/ubuntu-14.04

At this stage, you are ready to set up the virtual machine with the Intel DPDK.
Open a shell and move to the directory where this README file is located and type:

    $ sh create.sh

This will create a Vagrant VM according to the configuration contained in `Vagrantfile` and then it will provision it by running the `provision.sh` script.

Further information about the specific steps executed during this process can be found in the comments of the `create.sh`, `provision.sh` and `Vagrantfile` files.

# Requirements
 * Vagrant 1.6.3+
 * VirtualBox 3.8+

# License
This project is released under the terms of [BSD License](http://en.wikipedia.org/wiki/BSD_licenses).
