#!/bin/sh

#killall -9 java stunnel autossh
#pkill -f "stunnel|autossh|Jhttpp2Launcher|ZyxelAuthPoller"
#pkill -9 -f "stunnel|autossh|Jhttpp2Launcher"
pkill -9 -f "stunnel|autossh"
sleep 1

#cd myauth
#./run.sh
#cd ..
#sleep 1

cd mytunnel
./run.sh
cd ..
sleep 1

#ssh -p 9443 -D 0.0.0.0:23628 -N xp@127.0.0.1
./autossh.host
sleep 1

#cd jHTTPp2
#./run.sh
#cd ..


