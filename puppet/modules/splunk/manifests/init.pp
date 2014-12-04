class splunk {

  include consul 
  
  $splunk_version = '6.2.0-237341'

  package { 'splunk':
    ensure   => 'installed',
    provider => 'rpm',
    source   => "/vagrant/rpms/splunk-${splunk_version}-linux-2.6-x86_64.rpm",
  }

  exec {
    "enable_boot_start":
      command => "splunk enable boot-start --answer-yes --no-prompt --accept-license",
      path => [ "/opt/splunk/bin", "/bin", "/usr/bin", "/sbin", "/usr/sbin" ],
      require => Package['splunk'],
  }

  service { 'splunk':
    ensure  => 'running', 
    require => Exec['enable_boot_start'],
  }

  service { 'ntpd':
    ensure  => 'running', 
  }

  exec {
    "flush_iptables_splunk":
      command => "iptables -F",
      path => [ "/bin", "/usr/bin", "/sbin", "/usr/sbin" ],
  } 

  case $hostname {
    /^splunk-clustermaster/: { include splunk::clustermaster }
    /^splunk-searchpeer/:    { include splunk::searchpeer }  
    /^splunk-searchhead/:    { include splunk::searchhead }  
  } 

}
