#!/bin/bash
#:Title: startKB.sh
#:Author: Balaji Subramanian/Alan Coleman
#:Description: script to start kibana

#sets the 'logs' and 'lib' location
logs=$ELK_POC_HOME/logs 
lib=$ELK_POC_HOME/lib

# Defininig the log location
LOG_DIR=$logs/kibana
logname=kibana.log

# Elasticsearch installation home 
echo "Starting Kibana"
nohup sh $lib/kibana-5.5.0-linux-x86_64/bin/kibana > $logs/kibana/nohup.kibana & echo $! >>kibanaScripts/kibana.pid 
