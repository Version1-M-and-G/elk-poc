#!/bin/bash
#:Title: elasticsearch.sh
#:Author: alan coleman

pid_count=$( (cat kibanaScripts/kibana.pid) | wc -w)

if [ $pid_count -eq 0 ]
	then
#runs startKB script, starts Kibana
sh ${ELK_POC_HOME}/elk-poc/bin/kibanaScripts/startKB.sh

else
#runs stopKB script, stops Kibana
sh ${ELK_POC_HOME}/elk-poc/bin/kibanaScripts/stopKB.sh

fi
