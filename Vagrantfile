# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Global provider settings for VirtualBox
  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.linked_clone = true
  end

  # Windows Server 2022 Domain Controller
  config.vm.define "ASAD-DC01" do |dc|
    dc.vm.box = "windows/server-2022-evaluation"
    dc.vm.hostname = "ASAD-DC01"
    dc.vm.network "private_network", ip: "192.168.56.10"
    
    dc.vm.provider "virtualbox" do |v|
      v.name = "ASAD-DC01"
      v.memory = 4096
      v.cpus = 2
    end
  end

  # Windows Workstation
  config.vm.define "ASAD-WS01" do |ws|
    ws.vm.box = "gusztavvargadr/windows-10"
    ws.vm.hostname = "ASAD-WS01"
    ws.vm.network "private_network", ip: "192.168.56.20"
    
    ws.vm.provider "virtualbox" do |v|
      v.name = "ASAD-WS01"
      v.memory = 2048
      v.cpus = 2
    end
  end

  # Automated Ansible Provisioning (Enables GOAD-style one-command deployment)
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/site.yml"
    ansible.inventory_path = "ansible/inventory.ini"
    ansible.limit = "all"
  end
end
