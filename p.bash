#!/bin/bash
ping -q -c 1 ${1} >/dev/null &
if wait $!
then
  echo "${1}" >> ping_good
else
  echo "${1}" >> ping_failed
fi

