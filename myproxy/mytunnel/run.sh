#!/bin/sh

#killall stunnel
pkill -f stunnel
./stunnel ${PWD}/stunnel.conf
