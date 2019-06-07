port=1

while [ $port -lt 65535 ]; do

    nmap 10.37.131.15 -p $port | grep -A 1 '^PORT' | tail -1 >> 5201.port.res

    port=$(($port+1))

done