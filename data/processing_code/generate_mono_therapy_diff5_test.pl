#!/usr/bin/perl
#

open OLD, "../monotherapy/mono_therapy.txt_combined" or die;
## first drug 2 then drug 1.;
while ($line=<OLD>){
	chomp $line;
	@table=split "\t", $line;
	@t=split '\.', $table[0];
	$drug1=$t[0];
	$drug2=$t[1];
	$cell=$t[2];

	$drug_pair=$drug1.'.'.$drug2;

	@t1=(1,3,5,7);


	$ind=1;
	foreach $i (@t1){
		$ref{$cell}{$ind}+=$table[$i];
		$count{$cell}{$ind}++;
		$ind++;
	}
	@t2=(2,4,6,8);
	$ind=1;
	foreach $i (@t2){
		$ref{$cell}{$ind}+=$table[$i];
		$count{$cell}{$ind}++;
		$ind++;
	}
}
close OLD;

open OLD, "../monotherapy/mono_therapy.txt_combined" or die;
open NEW, ">../monotherapy/mono_therapy.txt_combined_diff5" or die;
open NEW1, ">../monotherapy/mono_therapy_reverse.txt_combined_diff5" or die;
while ($line=<OLD>){
	chomp $line;
	@table=split "\t", $line;
	@t=split '\.', $table[0];
	$drug1=$t[0];
	$drug2=$t[1];
	$cell=$t[2];

	$drug_pair=$drug1.'.'.$drug2;

	print NEW "$table[0]";
	print NEW1 "$table[0]";
	
	$ind=1;
	@t1=(1,3,5,7);
	foreach $i (@t1){
		$avg=$ref{$cell}{$ind}/$count{$cell}{$ind};
		$val=$table[$i]-$avg;
		print NEW "\t$val";
		$ind++;
	}


	$ind=1;
	@t1=(2,4,6,8);
	foreach $i (@t1){
		$avg=$ref{$cell}{$ind}/$count{$cell}{$ind};
		$val=$table[$i]-$avg;
		print NEW "\t$val";
		$ind++;
	}


	$ind=1;
	@t1=(2,4,6,8);
	foreach $i (@t1){
		$avg=$ref{$cell}{$ind}/$count{$cell}{$ind};
		$val=$table[$i]-$avg;
		print NEW1 "\t$val";
		$ind++;
	}


	$ind=1;
	@t1=(1,3,5,7);
	foreach $i (@t1){
		$avg=$ref{$cell}{$ind}/$count{$cell}{$ind};
		$val=$table[$i]-$avg;
		print NEW1 "\t$val";
		$ind++;
	}





	print NEW "\n";
	print NEW1 "\n";
}
close NEW;
close NEW1;
