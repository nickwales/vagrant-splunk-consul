class splunk::searchpeer {

  exec { 'enable_cluster_slave':
    command => "splunk edit cluster-config -mode slave -master_uri https://10.0.0.3:8089 -replication_port 9887 -auth admin:changeme -secret secret",
    path => [ "/opt/splunk/bin" ],
    require => Service['splunk'],  
  } ->
  
  exec { "restart":
    command => "splunk restart",
    path => [ "/opt/splunk/bin" ],
    require => Package['splunk'],
  }

  file { 'splunk_search_peer_consul': 
    path    => '/etc/consul.d/splunk_search_peer.json',
    content => template("splunk/splunk_search_peer.json.erb"),
    require => Package['consul'],
    notify  => Service['consul'],
  }

}
