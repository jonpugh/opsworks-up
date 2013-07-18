# -*- mode: ruby -*-
# vi: set ft=ruby :

#
# This is a specialized Vagrantfile I am developing to make
# Amazon Opsworks easier to use with Vagrant.
#
Vagrant.configure("2") do |config|

  # All OPSWORKS use precise32 (or Amazon Linux)
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Attributes are loaded from attributes.json
  if !(File.exists?("attributes.json"))
    warn "Copy attributes.json.example attributes.json and try again."
    exit
  end

  attributes = JSON.parse(IO.read("attributes.json"))

  # Networking & hostname
  # Specify your network adapter in attributes.json
  config.vm.network :public_network, :bridge => attributes["vagrant"]["adapter"]

  # Sets an available, host-only IP so you can always access the VM at the same IP
  config.vm.network :private_network, ip: attributes["vagrant"]["host_only_ip"]
  config.vm.hostname = attributes["vagrant"]["adapter"]

  # Install make.
  # Uninstall chef 10.x (I cannot figure out how to prevent installation of this.)
  # Install chef 0.9.18.  (OpsWorks)
  # Install OpsWorks-compatible gems
  #
  config.vm.provision :shell, :inline => "apt-get install make; gem uninstall chef; gem install chef --version 0.9.18 --no-rdoc --no-ri --conservative; gem install bundler"

  # Adds cookbooks path and run list.
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = attributes["vagrant"]["cookbooks_path"]
    attributes["run_list"].each do |recipe|
      chef.add_recipe recipe
    end
    # Passes attributes through to chef run.
    chef.json = attributes
  end
end
