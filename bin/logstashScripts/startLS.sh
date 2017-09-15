#!/bin/bash
#:Title: startLS.sh
#:Author: Balaji Subramanian/Alan Coleman
#:Description: Script to start logstash

#sets the 'logs' and 'lib' location
logs=$ELK_POC_HOME/logs 
lib=$ELK_POC_HOME/lib

# Defininig the log location
LOG_DIR=$logs/logstash
logname=logstash.log

# Logstash installation home  
echo "Starting Logstash"
nohup sh $lib/logstash-5.5.2/bin/logstash -f logstashScripts/logstash.conf & echo $! >>logstashScripts/logstash.pid
