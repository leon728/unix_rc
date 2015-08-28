#!/bin/sh

#echo $1 .... $2 ...

#nm -g $1 | grep 'T a2' > /dev/null && echo $1
#nm -g $1 | grep $2 > /dev/null && echo $1
#nm -g $1 | grep "T "$2 > /dev/null && echo $1
#nm -g $1 2>/dev/null | grep "T "$2 > /dev/null && echo $1
nm -gD $1 2>/dev/null | grep "T "$2 > /dev/null && echo $1

#nm -g $1 | grep $2 > /dev/null
#if [ $? -eq 0 ] ; then
#   echo $1
#   return 0;
#fi
#return 1;

