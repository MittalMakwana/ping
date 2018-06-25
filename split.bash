#!/bin/bash

echo "Splitting the file"

(awk -F "," '{print $2}' ${1}|sed 's@"@@g' | awk -F, 'NR%'"${2}"'==1 {close("website"i); filename="website"++i} {print > filename}'&2>1  >/dev/null) &
