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

# Elasticsearch installation home 
echo "Starting Elasticsearch"
nohup sh $lib/elasticsearch-5.5.0/bin/elasticsearch > $logs/elasticsearch/nohup.elasticsearch & echo $! >>elasticsearchScripts/elasticsearch.pid 
