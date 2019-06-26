# "awk -F "-" '{print $1}' | awk -F " " '{arr[$2] += $1} END {for (i in arr) {print i " " arr[i]}}' | sort -n -k 2 | numfmt --field 2 --to=iec-i | column -t"
