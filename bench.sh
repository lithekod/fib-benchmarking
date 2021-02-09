#!/bin/bash

script=script.py

while read -r num; do
    perl -ne "s/_val_/$num/g;print" $script > _script.py

    time=$(hyperfine 'python3 _script.py' -s basic \
        | cut -f 2 -d : \
        | head -n 3 \
        | tail -n 1 \
        | cut -f 1 -d m \
    )
    echo "$num $time" >> result
done <<< $(seq 10 15)
