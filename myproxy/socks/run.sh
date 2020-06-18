#!/bin/sh

#pgrep -f SocksServer | xargs kill -9
pkill -f SocksServer
sleep 1

cd $(dirname $(realpath $0))

java -Xms16m -Xmx64m -cp .:classes SocksServer 23628 &

