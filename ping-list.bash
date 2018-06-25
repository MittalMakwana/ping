#!/bin/bash
## 
## Author: Mittal Makwana
## Email: mittalmak@gmail.com
##
##

## The following for loops take a filename as an arguement 
## The file name should contain IP address/domain name
## The for loop itrates over the list and ping each server
## one at a time and save the result
## if sucessfull to ping_good file
## and fail ping server are storage in ping_bad file
##
##
##

#########################
# Declare parameter
########################

good="ping_good"
bad="ping_bad"
ping_68="ping_dns"
ping_count=1

#################
# Usage function
#################
function usage {
cat << EOF
usage: $0 [filename]

The file should contain list of IP address or hostname
One IP per line
The script will ping each host and save result in file

Report bugs to: https://github.com/MittalMakwana/
EOF

}

################################################
# Check for parameter and make sure it is a file
################################################

if [ $# -ne 1 ]||[  ! -f $1 ]
then
   usage
   exit
fi

##################################
# Loop thourgh each ip in the file
# If host is reachable ping return exit code of 0
# If the host is not reachable ping retun exit code($?) of 68
#################################
for _IP in $(cat ${1})
do
ping -q -c $ping_count $_IP >/dev/null 2>&1 
ping_exit_status=$?
if [ $ping_exit_status -eq 0 ]
then
   echo "$_IP" >> $good
elif [ $ping_exit_status -eq 68 ]
then
   echo "$_IP" >> $ping_68
else
   echo "$_IP" >> $bad
fi
done

