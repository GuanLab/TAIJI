#!/usr/bin/perl

# 15 features; minus cell avg

open OLD, "data/monotherapy/mono_therapy_spread_min_max_avg_test.txt" or die;
## first drug 2 then drug 1.;
while ($line=<OLD>){
	chomp $line;
	@table=split "\t", $line;
	@t=split '\.', $table[0];
	$drug1=$t[0];
	$drug2=$t[1];
	$cell=$t[2];

	$drug_pair=$drug1.'.'.$drug2;

	$i=1;
	while ($i<16){
		$ref{$cell}{$i}+=$table[$i];
		$count{$cell}{$i}++;

		$i++;
	}
}
close OLD;

open OLD, "data/monotherapy/mono_therapy_spread_min_max_avg_test.txt" or die;
open NEW, ">data/monotherapy/mono_therapy_spread_min_max_avg_diff5_test.txt" or die;
while ($line=<OLD>){
	chomp $line;
	@table=split "\t", $line;
	@t=split '\.', $table[0];
	$drug1=$t[0];
	$drug2=$t[1];
	$cell=$t[2];

	$drug_pair=$drug1.'.'.$drug2;
	print NEW "$table[0]";
	
	$i=1;
	while ($i<16){
		$avg=$ref{$cell}{$i}/$count{$cell}{$i};
		$val=$table[$i]-$avg;
		print NEW "\t$val";
		$i++;
	}


	print NEW "\n";
}
close NEW;
