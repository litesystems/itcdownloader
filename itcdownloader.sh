#!/bin/bash

DIR=`dirname $0`

# Load settings
source ${DIR}/settings.sh

# Constants
DAYS=31
OS=`uname`

# Commands
JAVA=java
GREP=grep

if [ -z $PROPERTIES ]; then
  echo '$PROPERTIES is not set.'
  exit 1
fi

if [ ! $VENDOR_ID -gt 0 ]; then
  echo '$VENDOR_ID is not set.'
  exit 1
fi

if [ $REPORT_TYPE = 'Sales' ]; then
  FILE_PRE_R='S_'
else
  echo 'Only sales report is supported.'
  exit 1
fi

if [ $REPORT_SUB_TYPE != 'Summary' ]; then
  echo 'Only summary report is supported.'
  exit 1
fi

if [ $DATE_TYPE = 'Daily' ]; then
  FILE_PRE_D='D_'
else
  echo 'Only daily report is supported.'
  exit 1
fi

FILE_PRE=${FILE_PRE_R}${FILE_PRE_D}

cd $DIR

# Make output directory
if [ ! -d $OUTPUT_DIR ]; then
  mkdir $OUTPUT_DIR
fi

for i in `seq 0 ${DAYS}`
do
  if [ $OS = 'Darwin' ]; then
    DATE=`date -v-${i}d +'%Y%m%d'`
  elif [ $OS = 'Linux' ]; then
    DATE=`date -d "$i days ago" +'%Y%m%d'`
  else
    break
  fi

  FILE=${FILE_PRE}${VENDOR_ID}_${DATE}.txt

  # If file exists
  if [ -e ${OUTPUT_DIR}${FILE} ]; then
    continue
  fi

  # Download with Autoingestion
  RESULT=`$JAVA -jar Reporter.jar p=$PROPERTIES Sales.getReport $VENDOR_ID, $REPORT_TYPE, $REPORT_SUB_TYPE, $DATE_TYPE, $DATE`

  # If succeeded
  if echo $RESULT | $GREP $FILE > /dev/null; then
    gzip -d -f ${FILE}.gz
    mv ${FILE} ${OUTPUT_DIR}${FILE}
  fi
done

exit 0

