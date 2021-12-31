#!/bin/bash 

HNAME=$2
DIREXEC=$1

${DIREXEC}/log4j-detect scan -d / 2>&1 > ${DIREXEC}/log4j-detect-${HNAME}-status.log

exit 0
