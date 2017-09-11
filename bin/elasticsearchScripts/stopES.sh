#!/bin/bash
#:Title: stopES.sh
#:Author: Balaji Subramanian/Alan Coleman
#:Description: Script to stop elasticsearch server

#process ID to be killed fetched from elasticsearch.pid
#graceful shutdown is preferred
echo "elasticsearch process to be shutdown is : "
echo "$(cat elasticsearchScripts/elasticsearch.pid)"

#verify number of process id's in elasticsearch.pid file. It should be one, anything else dont kill the process
pid_count=$( (cat elasticsearchScripts/elasticsearch.pid) | wc -w)
echo "Number of process in elasticsearch.pid is" $pid_count

#if number of PID's found = 1, kill process
if [ $pid_count -eq 1 ]
	then
		echo "Elasticsearch is attempting to shut down"
		kill "$(cat elasticsearchScripts/elasticsearch.pid)"
		echo "Verify if the process is still running"
		proc_count=$(ps -eaf | grep "$(cat elasticsearchScripts/elasticsearch.pid)" | wc -w)

		if [ $proc_count -lt 2 ]
			then
				echo "Process killed, clearing the elasticsearch.pid file"
				> elasticsearchScripts/elasticsearch.pid
		fi

#if number of PID's found = 0, don't kill
elif [ $pid_count -eq 0 ]
	then
		echo "no pid found. so no kill"

##if number of PID's found is neither 0 or 1, error, don't kill
else
	echo "Incorrect number of process id found. so no kill"
	echo "Please kill the process and clear the pid file manually"
fi
