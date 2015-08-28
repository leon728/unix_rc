#!/bin/sh

echo get svn status ...
svn status > svn_status.txt

java -cp svn_leon.zip SvnStatusFilter | tee svn_diff.txt
