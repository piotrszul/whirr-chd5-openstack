RUNNING HADOOP ON RESEARCH CLOUD USING WHIRR (CDH5)
------------------------------------------------------

This repository contains info on how to run hadoop (yarn) on openstack nova [Apache Whirr](http://whirr.apache.org/).


#Installation  (for Ubuntu 12.04 precise amd64)

Install whirr as described in [Cloudera CDH5 installation manual](http://www.cloudera.com/content/cloudera-content/cloudera-docs/CDH5/5.0/CDH5-Installation-Guide/CDH5-Installation-Guide.html). 
Also install hadoop-client.

Your installation should include the following steps:

- add CDH5 debian repository to apt sources (see: CDH5 installation)
- apt-get install openjdk-6-jdk
- apt-get install whirr
- apt-get install hadoop-client

As the last step run  ./install_whirr.sh to patch the installation (use sudo)

	sudo ./install_whirr.sh 

#Starting a hadoop cluster

Make a copy of recipies/hadoop-yarn-cdh5-openstack.properties and update the whirr.identity and whirr.credential whirr.endpoint and whirr.image-id


To start a new cluster use:

	whirr launch-cluster --config hadoop-yarn-cdh5-rc.properties

To destroy the cluster use:

	whirr destroy-cluster --config hadoop-yarn-cdh5-rc.properties

#Customizing the configuration

You can modify the other properties in hadoop-yarn-cdh5-rc.properties to customize your cluster.
In particular 

- whirr.instance-templates - to increase the number of worker nodes
- whirr.hardware-name to modify instance size (NOTE: you will need to update yarn resource configuration as well)
- whirr.image-id - to use a different base image

For more info refer to [whirr documentation](http://whirr.apache.org/docs/0.8.2/configuration-guide.html).

#Using the cluster:

Resource manager GUI  is available at `<master-node-ip>:8088`

HDFS GUI is available at `<master-node-ip>:50070`

Master node ip  can be found at: `~/.whirr/hadoop-yarn/instances`

whirr connects to hadoop cluster using an ssh proxy as described in [whirr quick start guide](http://whirr.apache.org/docs/0.8.2/quick-start-guide.html)

The bin/start_client simpfies the setup process. Simply use:

	bin/start-client.sh

to connect to the cluster and setup necessary envrionment variables and start a hadoop client shell.

To test your setup you can run the run_wordcount.sh script from bin directory (while in the client shell):

	bin/run-wordcount.sh










