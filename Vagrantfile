# -*- mode: ruby -*-
# vi: set ft=ruby :
 
Vagrant.configure("2") do |config|
     config.vm.define "servidor-primari" do |nodo2|
       nodo2.vm.box = "chenhan/ubuntu-desktop-20.04"
       nodo2.vm.hostname = "servidor-primari"
       nodo2.vm.network "public_network", ip: "192.168.1.202", netmask:"255.255.255.0"
       nodo2.vm.network "private_network", ip: "192.168.76.1", netmask:"255.255.255.0" , virtualbox__intnet: "ASIX2"
       nodo2.vm.network "private_network", ip: "192.168.176.1", netmask:"255.255.255.0" , virtualbox__intnet: "DAM2"
       nodo2.vm.provider "virtualbox" do |v|
       	v.name="servidor-primari-test"
       	v.memory = 2048
       	v.cpus = 2
       end
       nodo2.vm.provision "shell", inline: $role_script
       nodo2.vm.provision "shell", inline: $install_package
       nodo2.vm.provision "shell", path: "dns_config.sh"
     end 

     config.vm.define "client-linux" do |nodo3|
       nodo3.vm.box = "chenhan/ubuntu-desktop-20.04"
       nodo3.vm.hostname = "client-linux"
       nodo3.vm.network "private_network", type:"dhcp" , virtualbox__intnet: "ASIX2"
       nodo3.vm.provider "virtualbox" do |v|
       	v.name="client-linux"
       	v.memory = 2048
       	v.cpus = 2
       end
       nodo3.vm.provision "shell", inline:"sudo apt update"
       nodo3.vm.provision "shell", inline:"sudo apt install resolvconf"
       nodo3.vm.provision "shell", inline:"cd /etc/resolvconf/resolv.cond.d/ && mv head head.bak && wget https://raw.githubusercontent.com/xthalach/DNS-DHCP/main/head"
       nodo3.vm.provision "shell", inline:"sudo netplan apply"
     end 
    $role_script = <<-SCRIPT
    echo "Actualitzant..."
    sudo apt update
    echo "Configurant..."
    sed -i '$a PermitRootLogin yes' /etc/ssh/sshd_config
    sed -i 's/PasswordAuthentication no/#PasswordAuthentication no/' /etc/ssh/sshd_config
    echo "root:123456" | sudo chpasswd
    sudo service sshd restart
  SCRIPT
    
    $install_package = <<-SCRIPT
    sudo apt install bind9 bind9-doc bind9utils isc-dhcp-server resolvconf net-tools -y
  SCRIPT
end
