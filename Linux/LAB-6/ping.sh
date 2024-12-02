#!/bin/bash

for i in {1..254}
do
    ip="192.168.1.$i"

    echo "Pinging $ip"

    # Ping the IP address with a timeout of 1 second and a count of 1 packet
    ping -c 1 -W 1 $ip

    if [ $? -eq 0 ]; then
        echo "Server $ip is up and running"
    else
        echo "Server $ip is unreachable"
    fi
done
