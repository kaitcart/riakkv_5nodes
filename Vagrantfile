Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.2"

  # Working around a potential stale ssh key bug. Or a stale ssh key
  # misconfiguration. Either way, this should allow us to make sure fresh keys
  # are generated on `up`.
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"

  config.vm.synced_folder ".", "/vagrant", disabled:true
  config.vm.synced_folder ".yumcache", "/var/cache/yum",
    owner: "root", group: "root"
  #config.vm.synced_folder ".rootcache", "/root/.cache",
  #  owner: "root", group: "root"
  config.vm.synced_folder "data/applications", "/vagrant/applications",
    owner: "root", group: "root"
  config.vm.synced_folder ".downloads", "/home/vagrant/Downloads"
  config.vm.synced_folder ".sources", "/home/vagrant/sources"
  config.vm.synced_folder ".ssh", "/root/.ssh", owner: "root", group: "root"

  # Runs the provision_all script on the node.
  config.vm.provision "all", type: "shell", path: "provision/provision_all.sh"
  
  # Configures the client node. Sets up the ipaddress and hostname, and runs the provision_client script
  config.vm.define "clientkv" do |clientkv|
    clientkv.vm.hostname = "clientkv.riak.local"
    clientkv.vm.network "private_network", ip: "10.10.10.16"
    clientkv.vm.provision "clientkv", type: "shell", path: "provision/provision_client.sh"
  end

  # Configures the 5 Riak nodes. Assigns an ipaddress and hostname. Runs the provision_node script.
  (1..5).each do |index|
    last_octet = 16 + index
    
    config.vm.define "nodekv#{index}" do |nodekv|
      nodekv.vm.hostname = "nodekv#{index}.riak.local"
      nodekv.vm.network "private_network", ip: "10.10.10.#{last_octet}"
      nodekv.vm.provision "nodekv#{index}", type: "shell", path: "provision/provision_node.sh"
    
   # Creates the 5 node cluster
      if index > 1
        nodekv.vm.provision "riak", type: "shell", inline: <<-CLUSTER_JOIN
        riak-admin cluster join riak@nodekv1.riak.local
        CLUSTER_JOIN
      
        if index == 5
          nodekv.vm.provision "riak-plan-commit", type: "shell", inline: <<-CLUSTER_COMMIT
          sleep 5
        
          riak-admin cluster plan
          riak-admin cluster commit
          
    # Creates several bucket types.
          sleep 5
          riak-admin bucket-type create standard
          riak-admin bucket-type activate standard
          
          riak-admin bucket-type create maps '{"props":{"datatype":"map"}}'
          riak-admin bucket-type activate maps
          riak-admin bucket-type create sets '{"props":{"datatype":"set"}}'
          riak-admin bucket-type activate sets
          riak-admin bucket-type create counters '{"props":{"datatype":"counter"}}'
          riak-admin bucket-type activate counters
          CLUSTER_COMMIT
        end
      end
    end
  end
end
