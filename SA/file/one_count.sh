 ls -laARS | grep '^-\|^to\|^d' | sort -r -k 5 -n | awk  '$0 !~/\.$/ && $1 ~/^d/ {dir++} END {print "Number of directories: " dir}               $1 ~/^-/{NO++} NO<6 && $1 ~/^-/  {printf("%d %s  %s\n", NO, $5, substr($0,index($0,$9)))}  $1 !~/^d/  {sum += $5} END {print "total: " sum } $1 ~/^-/{c_file += 1}  END {printf "Number of files:" c_file "\n"} '
