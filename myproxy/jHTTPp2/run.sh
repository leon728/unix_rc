#!/bin/sh

pkill -f Jhttpp2Launcher
sleep 1

cd $(dirname $(realpath $0))

#java -Xms2m -Xmx64m -DsocksProxyHost=localhost -DsocksProxyPort=23628 -cp classes Jhttpp2Launcher &
java -Xms16m -Xmx64m -cp classes Jhttpp2Launcher &
