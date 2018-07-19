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
	$drug_pair=$drug1.'.'.$drug2;


	$i=1;
	while ($i<100){
		if (defined $table[$i]){
			$ref{$cell}{$i}+=$table[$i];
			$count{$cell}{$i}++;
		}
		$i++;
	}
}
close OLD;

open OLD, "../monotherapy/mono_therapy_min_max_avg.txt_combined" or die;
open NEW, ">../monotherapy/mono_therapy_min_max_avg.txt_combined_diff5" or die;
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
	while ($i<100){
		if (defined $count{$cell}{$i}){
			$avg=$ref{$cell}{$i}/$count{$cell}{$i};
			$val=$table[$i]-$avg;
			print NEW "\t$val";
		}
		$i++;
	}


	print NEW "\n";
}
close NEW;
