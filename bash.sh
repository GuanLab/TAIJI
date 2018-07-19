#!/bin/bash

# pre-process
cd ./data/processing_code/
bash bash_process.sh
cd ../../

# monotherapy model
perl step1_split_final.pl
perl dt_spread_test_all.pl
mv pred_spread.txt pred_spread_2.txt

# count
perl call_all_count.pl # 2m41.573s

# molecular model
perl step1_split_final.pl
perl dt_molecular_test_all.pl # 2m54.491s
mv pred_ori.txt pred_ori_2.txt

# stack
perl combine.pl

