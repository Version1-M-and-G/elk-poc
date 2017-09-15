#!/bin/bash
#:Title: elasticsearch.sh
#:Author: Alan Coleman

pid_count=$( (cat elasticsearchScripts/elasticsearch.pid) | wc -w)
if [ $pid_count -eq 0 ]
	then
#runs startES script, starts Elasticsearch
sh ${ELK_POC_HOME}/elk-poc/bin/elasticsearchScripts/startES.sh

else
#runs stopES script, stops Elasticsearch
sh ${ELK_POC_HOME}/elk-poc/bin/elasticsearchScripts/stopES.sh

fi
