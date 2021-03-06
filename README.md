opsworks-up
===========

Vagrantfile for Amazon Opsworks-compatible development.

Requirements
------------

- *vagrant* - Easy installers for all platforms available at http://downloads.vagrantup.com/
- *git* - Easy installers for all platforms available at http://git-scm.com/downloads

Details
-------

Amazon Opsworks uses Chef recipes for its stack management system.  However it uses an old
version and requires a gem that does not come with a vagrant VM by default.

This Vagrantfile does the following to try and emulate the opsworks environment:

1. Installs "make" so we can install our own version of chef.
2. Uninstalls chef 0.10.x, then installs chef 0.9.18.  
(OpsWorks uses 0.9.15.x @TODO: confirm exact versions and that the versions are compatible.)
3. Installs "bundler" gem.


Installation
------------

Each Opsworks stack should be a clone of this project.  Make a new directory 
for each stack you want to fire up in Vagrant.

If your stack is called "mystack":

    mkdir Vagrants
    cd Vagrants
    git clone git@github.com:jonpugh/opsworks-up.git mystack
    
Get the aws/opsworks-cookbooks repo, and put it somewhere.

    cd ~
    mkdir Repos
    git clone https://github.com/aws/opsworks-cookbooks.git repos/opsworks-cookbooks
    
Get your own chef cookbooks.  You can still put it anywhere, but these might be
specific toward a single stack:

    cd ~/Vagrants/mystack
    git clone https://github.com/us/custom-cookbooks.git cookbooks
    
Copy the example attributes file:

    cp attributes.json.example attributes.json
    
Edit your attributes.json file to fit your local computer's settings, and to set 
opsworks/chef attributes.

You will need to know where you cloned the opsworks cookbooks and your custom cookbooks.

    vim attributes.json

Also, you will need to change your "run_list" to match the cookbooks you wish to run when 
you call "vagrant-up".  Opsworks or custom recipes can be added to the run list.
    
Then, launch a VM:

    vagrant-up


    
