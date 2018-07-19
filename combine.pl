#!/usr/bin/perl
#
open OLD, "pred_count.txt" or die;
while ($line=<OLD>){
	chomp $line;
	@table=split ",", $line;
	$ref_count{$table[0]}{$table[1]}=$table[2];
}
close OLD;

open OLD, "pred_ori_2.txt" or die;
while ($line=<OLD>){
	chomp $line;
	@table=split ",", $line;
	$ref_2{$table[0]}{$table[1]}=$table[2];
}
close OLD;


open OLD, "pred_spread_2.txt" or die;
open NEW, ">prediction.csv" or die;
$line=<OLD>;
print NEW "$line";
while ($line=<OLD>){
	chomp $line;
	@table=split ",", $line;
#	$val=($ref_count{$table[0]}{$table[1]}+$ref_1{$table[0]}{$table[1]}+$ref_2{$table[0]}{$table[1]}+$ref_only_1{$table[0]}{$table[1]}+$ref_only_2{$table[0]}{$table[1]}+$ref_spread{$table[0]}{$table[1]}+$table[2])/5;
	$val=($ref_count{$table[0]}{$table[1]}+$ref_2{$table[0]}{$table[1]}+2*$table[2])/4;
	print NEW "$table[0],$table[1],$val\n";
}
close NEW;
close OLD;
	
open OLD, "TEST_gs.txt" or die;
open NEW, ">tmp.txt" or die;
while ($line=<OLD>){
	chomp $line;
	@table=split ',', $line;
	print NEW "$table[0],$table[1],$table[2]\n";
}
close OLD;
close NEW;
system "mv tmp.txt TEST_gs.txt";

system "rm *txt";
