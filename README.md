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

