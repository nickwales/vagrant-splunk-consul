node default {

  case $hostname {
    /^splunk/:            { include splunk,haproxy }  
#    /^loadbalancer/:      { include haproxy }  
    /^consul/:            { include consul }
  } 

}
