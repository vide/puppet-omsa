# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = 'puppet-omsa'
#  config.vm.synced_folder "modules", "/tmp/puppet-modules", type: "rsync", rsync__exclude: ".git/"
  config.vm.synced_folder "modules", "/tmp/puppet-modules", create: true
  config.vm.synced_folder ".", "/tmp/puppet-modules/omsa" , create: true

  config.vm.define "centos" do |centos|
    centos.vm.box     = 'vStone/centos-7.x-puppet.3.x'
    centos.vm.provision :puppet do |puppet|
      puppet.manifests_path = "tests"
      puppet.manifest_file  = "vagrant.pp"
      puppet.options        = ["--modulepath", "/tmp/puppet-modules"]
    end
  end

  config.vm.define "ubuntu", primary: true do |ubuntu|
    ubuntu.vm.box     = 'ubuntu64'
    ubuntu.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box'
    ubuntu.vm.provision :shell, :inline => 'aptitude update'
    ubuntu.vm.provision :puppet do |puppet|
      puppet.manifests_path = "tests"
      puppet.manifest_file  = "vagrant.pp"
      puppet.options        = ["--modulepath", "/tmp/puppet-modules"]
    end
  end

end
