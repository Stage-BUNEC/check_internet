#!/bin/bash

log_file=internetAccess.log
internet_status='Unknow'

checkInternet(){
  
  echo -ne "Check Internet..."
  date=$(date  +'%x %X')
  
  # Check if we have I @IP
  ping -qc 4 8.8.8.8 > /dev/null 2>&1
  if [ $? -eq 2 ];then
    echo -ne "Not IP address ! exit \n"
    exit 1 
  fi

  # Check Percent of Packet Loss
  percentLoss=$(ping -c 5 -q 8.8.8.8 | grep -oP '\d+(?=% packet loss)')
  
  if [ $percentLoss -lt 100 ];then
    echo "$date OK" > $log_file 
    echo -ne " [ OK ]\n"
    internet_status=$(cut -d " " -f 3 $log_file)
  else
    echo "$date Err" > $log_file
    echo -ne " [ Err ]\n"
    internet_status=$(cut -d " " -f 3 $log_file)
  fi

}

checkInternet; 
#echo "$internet_status"
