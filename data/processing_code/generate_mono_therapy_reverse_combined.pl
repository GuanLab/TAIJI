#!/usr/bin/perl
#
open OLD, "../test_monotherapy.csv" or die;
<OLD>;
open NEW, ">../monotherapy/mono_therapy_reverse.txt_combined" or die;

while ($line=<OLD>){
	chomp $line;
	$line=~s/"//g;
	@table=split ',', $line;
	print NEW "$table[14]";
	@lll=(4,3,8,9,10,5,6,7);
	foreach $i (@lll){
		$val=$table[$i];
		print NEW "\t$val";
	}

	print NEW "\n";
}

close NEW;
close OLD;
	
