Vagrant.configure("2") do |config|
  
  if ENV['FIRST_RUN'] == 'true'
    config.vbguest.auto_update = false
  else
    config.vm.synced_folder "config/", "/vagrant",  type: "virtualbox"
  end

    config.vm.define "haproxy1" do |haproxy1|
      haproxy1.vm.box_download_insecure = true
      haproxy1.vm.box = "ubuntu/focal64"
      haproxy1.vm.hostname = "haproxy1"
      haproxy1.vm.network "private_network", ip: "#{ENV['PRIVATE_NETWORK']}.8"
      haproxy1.vm.provider "virtualbox" do |v|
        v.name = "haproxy1"
        v.memory = 512
        v.cpus = 1
      end
    end

    config.vm.define "haproxy2" do |haproxy2|
      haproxy2.vm.box_download_insecure = true
      haproxy2.vm.box = "ubuntu/focal64"
      haproxy2.vm.hostname = "haproxy1"
      haproxy2.vm.network "private_network", ip: "#{ENV['PRIVATE_NETWORK']}.9"
      haproxy2.vm.provider "virtualbox" do |v|
        v.name = "haproxy2"
        v.memory = 512
        v.cpus = 1
      end
    end
    
  config.vm.define "k-master" do |master|
    master.vm.box_download_insecure = true
    master.vm.box = "ubuntu/focal64"
    master.vm.hostname = "k-master"
    master.vm.network "private_network", ip: "#{ENV['PRIVATE_NETWORK']}.10"
    master.vm.provider "virtualbox" do |v|
      v.name = "k-master"
      v.memory = 4096
      v.cpus = 2
    end
    master.vm.provision "setup", type: "shell", path: "scripts/common-ubuntu.sh", privileged: true
    master.vm.provision "deploy", type: "shell", path: "scripts/master-ubuntu.sh", privileged: true
  end

    config.vm.define "k-node1" do |node|
      node.vm.box_download_insecure = true
      node.vm.box = "ubuntu/focal64"
      node.vm.hostname = "k-node1"
      node.vm.network "private_network", ip: "#{ENV['PRIVATE_NETWORK']}.11"
      node.vm.provider "virtualbox" do |v|
        v.name = "k-node1"
        v.memory = 2024
        v.cpus = 2
      end
      node.vm.provision "setup", type: "shell", path: "scripts/common-ubuntu.sh", privileged: true
    end

    config.vm.define "k-node2" do |node|
      node.vm.box_download_insecure = true
      node.vm.box = "ubuntu/focal64"
      node.vm.hostname = "k-node2"
      node.vm.network "private_network", ip: "#{ENV['PRIVATE_NETWORK']}.12"
      node.vm.provider "virtualbox" do |v|
        v.name = "k-node2"
        v.memory = 2024
        v.cpus = 2
      end
      node.vm.provision "setup", type: "shell", path: "scripts/common-ubuntu.sh", privileged: true
    end
end