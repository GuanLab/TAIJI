#!/bin/bash

## generate monotherapy features
perl ./data/processing_code/generate_mono_therapy_spread_max_min_avg.pl $2
perl ./data/processing_code/generate_mono_therapy_spread_max_min_diff_test.pl
perl ./data/processing_code/generate_mono_therapy_spread_max_min_diff5_test.pl

perl ./data/processing_code/generate_mono_therapy_max_min_avg_combined.pl $1
perl ./data/processing_code/generate_mono_therapy_max_min_diff_combined.pl
perl ./data/processing_code/generate_mono_therapy_max_min_diff5_combined.pl

perl ./data/processing_code/generate_mono_therapy_spread_test.pl $2
perl ./data/processing_code/generate_mono_therapy_spread_diff_test.pl
perl ./data/processing_code/generate_mono_therapy_spread_diff5_test.pl

perl ./data/processing_code/generate_mono_therapy_combined.pl $1
perl ./data/processing_code/generate_mono_therapy_diff_test.pl
perl ./data/processing_code/generate_mono_therapy_diff5_test.pl

perl ./data/processing_code/generate_mono_therapy_spread_reverse_test.pl $2
#
#

perl ./data/processing_code/generate_mono_therapy_reverse_combined.pl $1
#
#

