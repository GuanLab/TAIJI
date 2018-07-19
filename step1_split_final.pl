#!/usr/bin/perl
#


#open GS, "/home/gyuanfan/2016/DC/rawdata_correct/ch1_test_monoTherapy_csvmap.csv" or die;
open GS, "./data/test_monotherapy.csv" or die;
<GS>;
while ($line=<GS>){
	chomp $line;
	@table=split ',', $line;
	$ref{$table[14]}=0;
}
close GS;

system "rm -rf TEST_GS";
system "mkdir TEST_GS";

@all_gs=keys %ref;


open TEST_sum, ">TEST_gs.txt" or die;
print TEST_sum "CELL_LINE,COMBINATION_ID,SYNERGY_SCORE\n";

foreach $gs (@all_gs){
	@t=split '\.', $gs;
	$drug=$t[0].'.'.$t[1];
	$str=$t[0].'.'.$t[1].'.'.$t[2];
	$line=$t[2];
	$comb="$line,$drug";
	open TEST , ">>TEST_GS/$drug" or die;
	print TEST "$line\t$ref{$gs}\t$gs\n";
	print TEST_sum "$line,$drug,$ref{$gs},$gs\n";
	close TEST;
}
close TEST_sum;

