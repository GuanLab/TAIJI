#!/usr/bin/perl
#
#open OLD, "data/test_monotherapy.csv" or die;
$filename=$ARGV[0];
open OLD, $filename or die;
<OLD>;
open NEW, ">data/monotherapy/mono_therapy.txt_combined" or die;

while ($line=<OLD>){
	chomp $line;
	$line=~s/"//g;
	@table=split ',', $line;
	print NEW "$table[14]";
	$i=3;
	while ($i<11){
		print NEW "\t$table[$i]";
		$i++;
	}
	print NEW "\n";
}

close NEW;
close OLD;
	
