#!/bin/bash

docker ps -a | awk '{print $1}' | xargs docker rm

docker run -d --name coord citus
docker run -d --name worker1 citus
docker run -d --name worker2 citus

docker run -d --name scoord citus
docker run -d --name sworker1 citus
docker run -d --name sworker2 citus


docker inspect coord | grep "IPAddres" | tail -1 |  grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}"

export IP=`docker inspect coord | grep "IPAddres" | tail -1 |  grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}"`
export IPW1=`docker inspect worker1 | grep "IPAddres" | tail -1 |  grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}"`
export IPW2=`docker inspect worker2 | grep "IPAddres" | tail -1 |  grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}"`


psql -U postgres -d postgres -h $IP -c "SELECT citus_set_coordinator_host('$IP')"
psql -U postgres -d postgres -h $IP -c "SELECT citus_add_node('$IPW1', 5432)"
psql -U postgres -d postgres -h $IP -c "SELECT citus_add_node('$IPW2', 5432)"

export IPS=`docker inspect scoord | grep "IPAddres" | tail -1 |  grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}"`
export IPW1S=`docker inspect sworker1 | grep "IPAddres" | tail -1 |  grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}"`
export IPW2S=`docker inspect sworker2 | grep "IPAddres" | tail -1 |  grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}"`


psql -U postgres -d postgres -h $IP -c "SELECT citus_add_secondary_node('$IPW2S', 5432,'$IPW2', 5432)"
psql -U postgres -d postgres -h $IP -c "SELECT citus_add_secondary_node('$IPW1S', 5432,'$IPW1', 5432)"
psql -U postgres -d postgres -h $IP -c "SELECT citus_add_secondary_node('$IPWS', 5432,'$IP', 5432)"
