# -*- mode: ruby -*-
# vi: set ft=ruby :

#
# This is a specialized Vagrantfile I am developing to make
# Amazon Opsworks easier to use with Vagrant.
#
Vagrant.configure("2") do |config|

  # Attributes are loaded from attributes.json
  if !(File.exists?("attributes.json"))
    warn "Copy attributes.json.example attributes.json and try again."
    exit
  end

  attributes = JSON.parse(IO.read("attributes.json"))

  # Loop through each layer
  attributes["opsworks"]["layers"].each do |layerName, layer|

    #loop through each instance
    layer["instances"].each do |name, instance|
      config.vm.define name do |configInstance|

        # All OPSWORKS use precise32 (or Amazon Linux)
        configInstance.vm.box = "precise32"
        configInstance.vm.box_url = "http://files.vagrantup.com/precise32.box"

        # Networking & hostname
        # Specify your network adapter in attributes.json
        configInstance.vm.network :public_network, :bridge => attributes["vagrant"]["adapter"]

        # Sets an available, host-only IP so you can always access the VM at the same IP
        configInstance.vm.network :private_network, ip: '10.10.10.10'
        configInstance.vm.hostname = name

        # Install make.
        # Uninstall chef 10.x (I cannot figure out how to prevent installation of this.)
        # Install chef 0.9.18.  (OpsWorks)
        # Install OpsWorks-compatible gems
        #
        configInstance.vm.provision :shell, :inline => "bash /vagrant/pre-install.sh"

        # Chef Solo
        configInstance.vm.provision :chef_solo do |chef|

          # Add this layer's cookbooks path
          chef.cookbooks_path = layer["cookbooks_path"]

          # Add this layer's Run List
          layer["run_list"].each do |recipe|
            chef.add_recipe recipe
          end

          # Set instance attribute to be the currently running instance
          instance["hostname"] = name
          attributes["opsworks"]["instance"] = instance

          # Pass the rest of the attributes
          chef.json = attributes
        end
      end
    end
  end
end
