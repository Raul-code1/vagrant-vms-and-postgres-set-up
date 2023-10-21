Vagrant.configure("2") do |config|
    config.hostmanager.enabled = true 
    config.hostmanager.manage_host = true
    
  ### DB vm  ####
    config.vm.define "postgreshost" do |postgreshost|
      postgreshost.vm.box = "ubuntu/focal64"
      postgreshost.vm.hostname = "postgreshost"
      postgreshost.vm.network "private_network", ip: "192.168.56.40"
      postgreshost.vm.provider "virtualbox" do |vb|
       vb.memory = "800"
     end
  
    end

  ### Nginx VM ###
    config.vm.define "nginxhost" do |nginxhost|
      nginxhost.vm.box = "ubuntu/focal64"
      nginxhost.vm.hostname = "nginxhost"
    nginxhost.vm.network "private_network", ip: "192.168.56.41"
    nginxhost.vm.provider "virtualbox" do |vb|
       vb.gui = true
       vb.memory = "800"
     end
  end
    
  end
  