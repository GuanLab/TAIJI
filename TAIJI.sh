#!/bin/bash

# pre-process
cd ./data/processing_code/
bash bash_process.sh
cd ../../

# m1. monotherapy model
perl step1_split_final.pl
perl dt_spread_test_all.pl
mv pred_spread.txt pred_spread_2.txt

# m2. count
perl call_all_count.pl # 2m41.573s

# m3. molecular model
perl step1_split_final.pl
perl dt_molecular_test_all.pl # 2m54.491s
mv pred_ori.txt pred_ori_2.txt

# stack; the three arguments correspond to the weights of the three prediction components
perl combine.pl $1 $2 $3

