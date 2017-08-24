#!/bin/bash
#: Title       : startelk.sh
#: Date        : 24/08/2017
#: Author      : "David Tuohy" <david.tuohy@version1.com>
#: Version     : 1.0
#: Description : starts ELK
#: Options     : None
clear
cd
cd elasticsearch-5.5.2
bin/elasticsearch &

echo "Wait for elastic search to start, when ready hit enter "
read var1
cd

cd kibana-5.5.2-linux-x86_64
bin/kibana &

echo "Wait for kibana search to start, when ready hit enter "
read var2
cd

cd logstash-5.5.2
bin/logstash -f logstash.conf
