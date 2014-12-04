class splunk::searchhead {

  exec { 'init_search_head_cluster':
    command => "splunk init shcluster-config -auth admin:changeme -mgmt_uri https://${ipaddress_eth1}:8089 -replication_port 9192 -replication_factor 3 -conf_deploy_fetch_url https://${search_cluster_master}:9190 -secret secret",
    path    => [ "/opt/splunk/bin" ],
    require => Service['splunk'],
  
  } ->
  
  exec { 'enable_cluster_master':
    command => "splunk edit cluster-config -mode searchhead -master_uri https://${search_cluster_master}:8089 -auth admin:changeme -secret secret",
    path    => [ "/opt/splunk/bin" ],
    require => Service['splunk'],  
  } ->
  
  exec { "restart":
    command => "splunk restart",
    path    => [ "/opt/splunk/bin" ],
    require => Package['splunk'],
  }
  
  file { 'splunk_search_head_consul': 
    path    => '/etc/consul.d/splunk_search_head.json',
    content => template("splunk/splunk_search_head.json.erb"),
    require => Package['consul'],
    notify  => Service['consul'],
  }

}

# Run the search head cluster captain initialization
# /opt/splunk/bin/splunk bootstrap shcluster-captain -servers_list "https://10.0.0.11:8089, https://10.0.0.12:8089" -auth admin:changeme