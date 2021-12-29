#!/bin/bash 

HNAME=$1
echo $HNAME
/tmp/log4j-detect scan -d / 2>&1 > /tmp/log4j-detect-status.log
