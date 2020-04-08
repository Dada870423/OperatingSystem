ls -laAR |grep "^d" | grep -v "\.$" | awk 'END{print "Number of directories："NR}'
ls -laARS |grep "^-" |awk 'END{print "Number of files："NR}'
ls -laARS | grep "^-" |awk '{sum += $5} END {print "total: " sum}'
ls -laARS |grep "^-" |  sort -r -k 5 -n  |awk  '{print NR ". " $5 "  " $9 $10 $11 $12 $13 $14}' |head -n 5
