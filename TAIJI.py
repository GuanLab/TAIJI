"""
Script for predicting drug synergy.
Use `TAIJI.py -h` to see descriptions of the arguments.
"""

import argparse
import os

def get_args():
    parser = argparse.ArgumentParser(description="TAIJI prediction",
        epilog='\n'.join(__doc__.strip().split('\n')[1:]).strip(),
        formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument('-i1', '--input1', default='data/test_monotherapy.csv', type=str,
        help='Input summary table (example: data/test_monotherapy.csv)')
    parser.add_argument('-i2', '--input2', default='data/monotherapy_spread_csv/', type=str,
        help='Directory of the input monotherapy spread sheets (example: data/monotherapy_spread_csv/)')
    parser.add_argument('-w1', '--weight1', default='1', type=str,
        help='Weight for the monotherapy component')
    parser.add_argument('-w2', '--weight2', default='1', type=str,
        help='Weight for the cell line-drug component')
    parser.add_argument('-w3', '--weight3', default='2', type=str,
        help='Weight for the molecular profile component')
    parser.add_argument('-o', '--outputdir', default='./', type=str,
        help='Output directory')
    args = parser.parse_args()
    return args

def main():
    args = get_args()
    cmd = 'bash ./data/processing_code/bash_process.sh ' + args.input1 + ' ' + args.input2
    os.system(cmd)   
 
    # m1. monotherapy model
    os.system('perl step1_split_final.pl')
    os.system('perl dt_spread_test_all.pl')
    os.system('mv pred_spread.txt pred_spread_2.txt')
    
    # m2. cell line-drug frequency
    os.system('perl call_all_count.pl') # 2m41.573s
    
    # m3. molecular model
    os.system('perl step1_split_final.pl')
    os.system('perl dt_molecular_test_all.pl') # 2m54.491s
    os.system('mv pred_ori.txt pred_ori_2.txt')
    
    # stack; the three arguments correspond to the weights of the three prediction components
    os.system('perl combine.pl ' + args.weight1 + ' ' + args.weight2 + ' ' + args.weight3)

    cmd = 'mv prediction.csv ' + args.outputdir 
    os.system(cmd)

if __name__ == '__main__':
    main()

