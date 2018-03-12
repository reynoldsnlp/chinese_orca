#!/bin/bash
"""Remove any stars from a corpus for passing to Apertium."""
regular_corp=$1
corp=$(echo ${regular_corp} | cut -d "-" -f 1)
char=$(echo ${regular_corp} | cut -d "-" -f 3)
segd=$(echo ${regular_corp} | cut -d "-" -f 4)
cat ${regular_corp} | sed s'/\*//g' > ${corp}-nostar-${char}-${segd}
