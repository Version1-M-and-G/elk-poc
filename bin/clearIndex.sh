#!/bin/bash
#:Title: clearIndex.sh
#:Author: Alan Coleman

#shut down logstash if running
sh logstashScripts/stopLS.sh

#verify it has shut down
sh logstashScripts/stopLS.sh

#clears content stored in "my_index"
curl -XDELETE 'localhost:9200/my_index'

#update repos
sh autoUpdateRepo.sh

#restarts logstash 
sh logstashScripts/startLS.sh
