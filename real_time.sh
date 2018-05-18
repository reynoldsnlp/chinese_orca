#!/bin/bash
"""For whichever corpus as an argument, print to stdout the real time values"""

for each in $1_TIME/*.txt;
  do
  seg_file=$(echo ${each} | cut -d "/" -f 2)
  segmenter=$(echo ${seg_file} | cut -d "_" -f 2)
  real_line=$(cat ${each} | grep "real")
  just_time=$(echo ${real_line} | cut -d " " -f 2)
  echo ${segmenter} ${just_time}
done
