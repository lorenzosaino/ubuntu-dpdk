# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "bento/ubuntu-14.04"

  # Provision from file
  # Explicitly set not to run the script as superuser. The specific instructions
  # that need to be run as sudo in the script are prepended with sudo
  config.vm.provision :shell, privileged: false, :path => "provision.sh"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # This option is needed otherwise the Intel DPDK takes over the entire adapter
  config.vm.network "private_network", ip: "10.0.0.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # VirtualBox-specific configuration
  config.vm.provider "virtualbox" do |vb|
      # Set easy to remember VM name
      vb.name = "ubuntu-14.04-dpdk"
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
