#!/bin/bash

command=$1
flags=$2

flag_array=()
for (( i=0; i<${#flags}; i++ )); do
    flag_array+=("-${flags:$i:1}")
done

for flag in "${flag_array[@]}"
do
    echo "Searching for flag: $flag"
    man $command | sed -n "/$flag/p" | tail -5
done

