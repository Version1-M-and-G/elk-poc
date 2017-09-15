#!/bin/bash
#:Title: stopKB.sh
#:Author: Balaji Subramanian/Alan Coleman
#:Description: script to stop kibana process

#process ID to be killed fetched from kibana.pid
#graceful shutdown is preferred
echo "Kibana process to be shutdown is : "
echo "$(cat kibanaScripts/kibana.pid)"

#verify number of process id's in kibana.pid file. It should be one, anything else dont kill the process
pid_count=$( (cat kibanaScripts/kibana.pid) | wc -w)
echo "Number of process in kibana.pid is" $pid_count

#if number of PID's found = 1, kill process
if [ $pid_count -eq 1 ]
	then
		echo "Kibana is attempting to shut down"
		kill "$(cat kibanaScripts/kibana.pid)"
		echo "Verify if the process is still running"
		proc_count=$(ps -eaf | grep "$(cat kibanaScripts/kibana.pid)" | wc -l)

		if [ $proc_count -lt 2 ]
			then
				echo "Process killed, clearing the kibana.pid file"
				> kibanaScripts/kibana.pid
		fi

#if number of PID's found = 0, don't kill
elif [ $pid_count -eq 0 ]
	then
		echo "no pid found. so no kill"

#if number of PID's found is neither 0 or 1, error, don't kill
else
	echo "Incorrect number of process id found. so no kill"
	echo "Please kill the process and clear the pid file manually"
fi
