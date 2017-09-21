#!/bin/sh

# Script to run "airflow trigger_dag -e yyyy-mm-ddTHH:MM" for a specific dag for a specified window of dates

# $1 = start date
# $2 = end date
# $3 = dag to be used

begindate=$1
enddate=$2
dag=$3
currentdate=$begindate
loopenddate=$(date --date "$enddate 1 day" +%Y-%m-%dT%H:%M)

echo "-------------------------"
echo "INPUT PARAMS:"
echo "Begin Date: "$begindate
echo "End Date: "$enddate
echo "Dag Name: "$dag
echo "-------------------------"

until [ "$currentdate" == "$loopenddate" ]
do
  
  mycmd="airflow trigger_dag "$dag" -e "$currentdate
  echo ".............."
  echo "COMMAND:"
  echo $mycmd
  echo ".............."
  
  # run airflow command
  airflow trigger_dag $dag -e $currentdate
  
  # increment date by 1 day
  currentdate=$(date --date "$currentdate 1 day" +%Y-%m-%dT%H:%M)
  
done
