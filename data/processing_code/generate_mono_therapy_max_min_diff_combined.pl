#!/usr/bin/perl
#

open OLD, "../monotherapy/mono_therapy_min_max_avg.txt_combined" or die;
## first drug 2 then drug 1.;
while ($line=<OLD>){
	chomp $line;
	@table=split "\t", $line;
	@t=split '\.', $table[0];
	$drug1=$t[0];
	$drug2=$t[1];
	$cell=$t[2];

	$i=1;
	while ($i<100){
		if (defined $table[$i]){
		$ref{$drug2}{$cell}{$i}+=$table[$i];
		$count{$drug2}{$cell}{$i}++;

		$ref{$drug1}{$cell}{$i}+=$table[$i];
		$count{$drug1}{$cell}{$i}++;
		}
		$i++;
	}
}
close OLD;

open OLD, "../monotherapy/mono_therapy_min_max_avg.txt_combined" or die;
open NEW, ">../monotherapy/mono_therapy_min_max_avg.txt_combined_diff" or die;
while ($line=<OLD>){
	chomp $line;
	@table=split "\t", $line;
	@t=split '\.', $table[0];
	$drug1=$t[0];
	$drug2=$t[1];
	$cell=$t[2];

	print NEW "$table[0]";
	
	$i=1;
	while ($i<100){
		if (defined $count{$drug2}{$cell}{$i}){
		$avg=$ref{$drug2}{$cell}{$i}/$count{$drug2}{$cell}{$i};
		$avg1=$ref{$drug1}{$cell}{$i}/$count{$drug1}{$cell}{$i};
		$aaa=($avg+$avg1)/2;
		$val=$table[$i]-$aaa;
		print NEW "\t$val";
		}
		$i++;
	}


	print NEW "\n";
}
close NEW;
