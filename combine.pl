#!/usr/bin/perl

# weights of three components
$w1=1;
$w2=1;
$w3=2;

if (exists $ARGV[0]){
    $w1=$ARGV[0];
}
if (exists $ARGV[1]){
    $w2=$ARGV[1];
}
if (exists $ARGV[2]){
    $w3=$ARGV[2];
}
#print "$w1\t$w2\t$w3\n";
#die;

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
	$val=($w1*$ref_count{$table[0]}{$table[1]}+$w2*$ref_2{$table[0]}{$table[1]}+$w3*$table[2])/($w1+$w2+$w3);
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
