#!/bin/bash
#:Title: startES.sh
#:Author: Balaji Subramanian/Alan Coleman
#:Description: Script to start elasticsearch server

#sets the 'logs' and 'lib' location
logs=$ELK_POC_HOME/logs 
lib=$ELK_POC_HOME/lib

# Defininig the log location
LOG_DIR=$logs/elasticsearch
logname=elasticsearch.log

#We need to set the following value to avoid a potential maximum map count error
sudo sysctl -w vm.max_map_count=262144

# Elasticsearch installation home 
echo "Starting Elasticsearch"
sh $lib/elasticsearch-5.5.0/bin/elasticsearch -d -p elasticsearchScripts/elasticsearch.pid > $LOG_DIR/$logname
