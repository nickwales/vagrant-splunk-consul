class haproxy {

  file { 'splunk_lb_consul':
    path    => "/etc/consul.d/splunk-lb.json", 
    content => template("haproxy/splunk-lb.json.erb"),
    require => Class['consul'],
  }

  exec {
    "flush_iptables":
      command => "iptables -F",
      path => [ "/bin", "/usr/bin", "/sbin", "/usr/sbin" ],
  } 


  package { "haproxy":
    name   => 'haproxy',
    ensure => 'installed',  
  }
  
  package { 'consul-haproxy':  
    ensure   => 'installed',
    provider => 'rpm',
    source   => "/vagrant/rpms/consul-haproxy-0.2.0-1.x86_64.rpm",
  }

  file { 'in_conf':
    path    => "/etc/haproxy/in.conf", 
    content => template("haproxy/in.conf.erb"),
    require => Package["haproxy"],
  } ->

  file { 'consul_haproxy_conf':
    path    => "/etc/haproxy/consul-haproxy.conf", 
    content => template("haproxy/consul-haproxy.conf.erb"),
  } ->

  exec {
    "consul_haproxy_daemonize":
      command => "consul-haproxy -f /etc/haproxy/consul-haproxy.conf &",
      path    => [ "/usr/local/bin" ],
      require => Package['consul-haproxy'],
  }

}