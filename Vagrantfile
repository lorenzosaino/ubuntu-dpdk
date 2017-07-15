# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at https://docs.vagrantup.com.

  config.vm.box = "bento/ubuntu-16.04"

  # Provision from file
  config.vm.provision :shell, privileged: false, :path => "setup.sh"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # This option is needed otherwise the Intel DPDK takes over the entire adapter
  config.vm.network "private_network", ip: "10.0.0.10"

  # VirtualBox-specific configuration
  config.vm.provider "virtualbox" do |vb|
      # Set easy to remember VM name
      vb.name = "ubuntu-16.04-dpdk"
      # Assign 2 GB of memory
      vb.memory = 2048
      # Assign 2 cores
      vb.cpus = 2

      # Configure VirtualBox to enable passthrough of SSE 4.1 and SSE 4.2
      # instructions, according to this:
      # https://www.virtualbox.org/manual/ch09.html#sse412passthrough
      # This step is fundamental otherwise DPDK won't build.
      # It is possible to verify in the guest OS that these changes took effect
      # by running `cat /proc/cpuinfo` and checking that `sse4_1` and `sse4_2`
      # are listed among the CPU flags
      vb.customize ["setextradata", :id, "VBoxInternal/CPUM/SSE4.1", "1"]
      vb.customize ["setextradata", :id, "VBoxInternal/CPUM/SSE4.2", "1"]
  end
end
