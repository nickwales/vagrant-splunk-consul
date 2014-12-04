class splunk::clustermaster {

  exec { 'enable_cluster_master':
    command => "splunk edit cluster-config -mode master -replication_factor 1 -search_factor 1 -auth admin:changeme -secret secret",
    path => [ "/opt/splunk/bin" ],
    require => Service['splunk'],
  
    } ->
  
  exec { "restart":
    command => "splunk restart",
    path => [ "/opt/splunk/bin" ],
    require => Package['splunk'],
  }
  
  file { 'splunk_cluster_master_consul': 
    path    => '/etc/consul.d/splunk_cluster_master.json',
    content => template("splunk/splunk_cluster_master.json.erb"),
    require => Package['consul'],
    notify  => Service['consul'],
  }
  

}
