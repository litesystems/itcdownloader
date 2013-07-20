#!/bin/sh

# iTunes Connect Settings
VENDORID=00000000
R_TYPE=Sales
D_TYPE=Daily
R_S_TYPE=Summary

# File Settings
OUTPUT_DIR=reports/
TEMP_FILE=result.tmp

# Constants
DAYS=31

# Commands
JAVA=java
GREP=grep

# Get OS for date command
OS=`uname`

if [ $R_TYPE = "Sales" ]; then
  FILE_PRE_R="S_"
else
  echo "Only sales report is supported."
  exit 1
fi

if [ $D_TYPE = "Daily" ]; then
  FILE_PRE_D="D_"
else
  echo "Only daily report is supported."
  exit 1
fi

FILE_PRE=${FILE_PRE_R}${FILE_PRE_D}

# Make output directory
if [ ! -d $OUTPUT_DIR ]; then
  mkdir $OUTPUT_DIR
fi

for i in `seq 0 ${DAYS}`
do
  if [ $OS = "Darwin" ]; then
    DATE=`date -v-${i}d +'%Y%m%d'`
  elif [ $OS = "Linux" ]; then
    DATE=`date -d "$i days ago" +'%Y%m%d'`
  else
    break
  fi

  FILE=${FILE_PRE}${VENDORID}_${DATE}.txt

  # If file exists
  if [ -e ${OUTPUT_DIR}${FILE} ]; then
    continue
  fi

  # Download with Autoingestion
  $JAVA Autoingestion autoingestion.properties $VENDORID $R_TYPE $D_TYPE $R_S_TYPE $DATE > $TEMP_FILE

  # If succeeded
  if $GREP $FILE $TEMP_FILE > /dev/null; then
    gzip -d -f ${FILE}.gz
    mv ${FILE} ${OUTPUT_DIR}${FILE}
  fi
done

exit 0

