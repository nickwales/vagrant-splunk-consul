Vagrant Splunk Consul
------------------

Demo Splunk 6.2 Clustering with Load Balancing from HA-Proxy.

HA-Proxy is installed on each Search Head and gets its config dynamically from Consul.

Instructions
------------

For new releases:

1. vagrant up
2. consul comes up first, watch here to see subsequent http://10.0.0.30:8500/
3. ha-proxy listens on port 80 on each search head.

TO-DO
-----

To enable the splunk search head clustering the cluster captain command needs to be run, it should look something like this:

  /opt/splunk/bin/splunk bootstrap shcluster-captain -servers_list "https://10.0.0.11:8089, https://10.0.0.12:8089" -auth admin:changeme
