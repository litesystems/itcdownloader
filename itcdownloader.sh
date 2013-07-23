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

if [ ! $VENDOR_ID -gt 0 ]; then
  echo '$VENDOR_ID is not set.'
  exit 1
fi

if [ $R_TYPE = 'Sales' ]; then
  FILE_PRE_R='S_'
else
  echo 'Only sales report is supported.'
  exit 1
fi

if [ $D_TYPE = 'Daily' ]; then
  FILE_PRE_D='D_'
else
  echo 'Only daily report is supported.'
  exit 1
fi

if [ $R_S_TYPE = 'Summary' ]; then
  :
else
  echo 'Only summary report is supported.'
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
  RESULT=`$JAVA Autoingestion autoingestion.properties $VENDOR_ID $R_TYPE $D_TYPE $R_S_TYPE $DATE`

  # If succeeded
  if echo $RESULT | $GREP $FILE > /dev/null; then
    gzip -d -f ${FILE}.gz
    mv ${FILE} ${OUTPUT_DIR}${FILE}
  fi
done

exit 0

