#!/bin/bash
#:Title: elasticsearch.sh
#:Author: alan coleman 

pid_count=$( (cat logstashScripts/logstash.pid) | wc -w)
if [ $pid_count -eq 0 ]
then
#runs startLS script, starts Logstash
  sh ${ELK_POC_HOME}/elk-poc/bin/logstashScripts/startLS.sh

else
#runs stopLS script, stops Logstash
  sh ${ELK_POC_HOME}/elk-poc/bin/logstashScripts/stopLS.sh

fi
