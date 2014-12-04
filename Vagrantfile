VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "./puppet/manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = "./puppet/modules"
    puppet.facter = { "search_cluster_master" => "10.0.0.3" }
  end

  ### Consul Server
  config.vm.define "consul" do |node|
   node.vm.box = "puppetlabs/centos-6.5-64-puppet"
   node.vm.hostname = "consul"
   node.vm.network "private_network", ip: "10.0.0.30"
  end  

 # ### Load Balancer (LB's installed on each searchhead now)
 # config.vm.define "loadbalancer" do |node|
 #  node.vm.box = "puppetlabs/centos-6.5-64-puppet"
 #  node.vm.hostname = "loadbalancer"
 #  node.vm.network "private_network", ip: "10.0.0.20"
 # end  

  ### Cluster Master
  config.vm.define "splunk-clustermaster" do |node|
    node.vm.box = "puppetlabs/centos-6.5-64-puppet"
    node.vm.hostname = "splunk-clustermaster"
    node.vm.network "private_network", ip: "10.0.0.3"
  end

  ### Search Peers
  config.vm.define "splunk-searchpeer" do |node|
    node.vm.box = "puppetlabs/centos-6.5-64-puppet"
    node.vm.hostname = "splunk-searchpeer"
    node.vm.network "private_network", ip: "10.0.0.4"
  end

  ### Search Heads
  config.vm.define "splunk-searchhead-1" do |node|
   node.vm.box = "puppetlabs/centos-6.5-64-puppet"
   node.vm.hostname = "splunk-searchhead-1"
   node.vm.network "private_network", ip: "10.0.0.10"
  end

  config.vm.define "splunk-searchhead-2" do |node|
   node.vm.box = "puppetlabs/centos-6.5-64-puppet"
   node.vm.hostname = "splunk-searchhead-2"
   node.vm.network "private_network", ip: "10.0.0.11"
  end
  
  config.vm.define "splunk-searchhead-3" do |node|
   node.vm.box = "puppetlabs/centos-6.5-64-puppet"
   node.vm.hostname = "splunk-searchhead-3"
   node.vm.network "private_network", ip: "10.0.0.12"
  end  

end
