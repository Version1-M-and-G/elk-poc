#!/bin/bash
#:Title: stopLS.sh
#:Author: Balaji Subramanian/Alan Coleman
#:Description: Script to stop logstash process

#process ID to be killed fetched from logstash.pid
#graceful shutdown is preferred
echo "Logstash process to be shutdown is : "
echo "$(cat logstashScripts/logstash.pid)"

#verify number of process id's in logstash.pid file. It should be one, anything else dont kill the process
pid_count=$( (cat logstashScripts/logstash.pid) | wc -w)
echo "Number of process in logstashScripts/logstash.pid is" $pid_count

#if number of PID's found = 1, kill process
if [ $pid_count -eq 1 ]
	then
		echo "Logstash is attempting to shut down"
		kill "$(cat logstashScripts/logstash.pid)"
		echo "Verify if the process is still running"
		proc_count=$(ps -eaf | grep "$(cat logstashScripts/logstash.pid)" | wc -l)
		
		if [ $proc_count -lt 2 ]
			then
				echo "Process killed, clearing the logstash.pid file"
				> logstashScripts/logstash.pid
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
