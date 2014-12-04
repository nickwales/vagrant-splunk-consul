class consul {

  package { 'consul':  
    ensure   => 'installed',
    provider => 'rpm',
    source   => "/vagrant/rpms/consul-0.4.1-3.x86_64.rpm",
    require  => File['consul_conf'],
  }

  case $hostname {
    /^consul/: { 
      file { 'consul_conf':
        path    => '/etc/consul.conf',
        content => template('consul/etc/consul-server.conf.erb'),
      }
    }
    default:  {
      file { 'consul_conf':
        path    => '/etc/consul.conf',
        content => template('consul/etc/consul.conf.erb'),
      }
    }
  }

  service { 'consul': 
    ensure  => 'running',
    require => Package['consul'],    
  }

  exec {
    "flush_iptables_again":
      command => "iptables -F",
      path => [ "/bin", "/usr/bin", "/sbin", "/usr/sbin" ],
  } 


}