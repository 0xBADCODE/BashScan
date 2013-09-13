#!/bin/bash
if [ $UID != 0 ]; then
        echo 'Run as root.'
        exit
fi

ping -c 1 $1 > /dev/null

if [ $? -eq '0' ]; then
	echo "Target is alive!"
	else echo "Target might be down."
fi

for i in {1..65535};
do timeout 1 bash -c "echo >/dev/tcp/$1/$i" 2>/dev/null &&
	 echo "port $i is open" ||
	 echo "port $i is closed"
done
