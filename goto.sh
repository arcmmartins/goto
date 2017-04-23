#!/usr/bin/env bash
start="."
ret="/.."
ARRAY=()
if [ $# -eq 0 ]; then
    echo "USAGE: goto target <optional goback>"
else
	for i in $(seq 1 $2); do start=$start$ret; done
	cd $start
	while read d; do
	    ARRAY+=("$(echo $d)")
	done <<< "$(find * -maxdepth 4 -type d -name $1* 2>/dev/null)"
	if [ ${#ARRAY[@]} -eq 0 ]; then
	  echo "not found"
	elif [ ${#ARRAY[@]} -eq 1 ]; then
	  cd ${ARRAY[0]}
	else
	  i=0
	  for value in "${ARRAY[@]}"; do
	    echo "$i $value"
	    i=$(($i+1))
	  done
	  echo  "pick your target"
	  read opt
	  cd $(echo ${ARRAY[$opt]} | tr -d '\r')
	fi
fi


