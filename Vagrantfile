# -*- mode: ruby -*-
# vi: set ft=ruby :

server_cfg = [
    {
     :name => "dut1",
     :box => "vEXOS-30.2.1.8",
     :autostart => true,
     :memory => 512,
     :cpus => 1,
     :mac => "000101010101",
   },{
     :name => "dut2",
     :box => "vEXOS-30.2.1.8",
     :autostart => true,
     :memory => 512,
     :cpus => 1,
     :mac => "000202020202",
   },{
     :name => "harness",
     :box => "centos/7",
     :autostart => true,
     :memory => 4096,
     :cpus => 1,
     :mac => "000303030303",
   }
]

Vagrant.configure("2") do |config|

  server_cfg.each do |server|

    config.vm.define server[:name], autostart: server[:autostart] do |node|
      node.vm.box = server[:box]
      node.ssh.insert_key = false

      config.vm.provider "virtualbox" do |vb|
        vb.memory = server[:memory]
        vb.cpus = server[:cpus]
        vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
        vb.customize ["modifyvm", :id, "--macaddress1", server[:mac]]
        vb.customize ["modifyvm", :id, "--chipset", "ich9"]
      end

      if server[:name] == "dut1"
        # dut1 ports 1-4 go to dut2 ports 1-4
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet11-21"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet12-22"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet13-23"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet14-24"

        # dut1 ports 5-8 go to harness ports 1-4
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet15-h1"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet16-h2"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet17-h3"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet18-h4"
      end
      if server[:name] == "dut2"
        # dut2 ports 1-4 go to dut1 ports 1-4
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet11-21"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet12-22"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet13-23"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet14-24"

        # dut2 ports 5-8 go to harness ports 5-8
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet25-h5"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet26-h6"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet27-h7"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet28-h8"
      end
      if server[:name] == "harness"
        # harness ports 1-4 go to dut1 ports 5-8
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet15-h1"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet16-h2"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet17-h3"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet18-h4"

        # harness ports 5-8 go to dut2 ports 5-8
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet25-h5"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet26-h6"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet27-h7"
        node.vm.network "private_network", nic_type: "virtio", forward_mode: "none", type: "dhcp", auto_config: false, virtualbox__intnet: "intnet28-h8"
      end

      config.vm.provider "virtualbox" do |vb|
        vb.memory = server[:memory]
        vb.cpus = server[:cpus]
        (2..13).each do |num|
          vb.customize ["modifyvm", :id, "--nicpromisc#{num}", "allow-all"]
        end
      end
    end
  end
end