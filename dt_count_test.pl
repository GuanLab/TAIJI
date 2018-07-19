#!/usr/bin/perl


$file=$ARGV[0];

@t=split '/', $file;
$excluded=pop @t;
@t=split '\.', $excluded;

$id=$ARGV[1];
$exclude_drug{$t[$id]}=0;
$exclude_pair{$excluded}=0;

open REF_DATA, "/home/gyuanfan/2016/DC/rawdata/Drug_synergy_data/Raw_Data_csv/cell_drug_count.txt" or die; # first line of this file has minor bug
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$ref_count{$table[0]}{$table[2]}=$table[5]."\t".$table[6];
}
close REF_DATA;
# % ref_count: cell & drug - count(cell,drug)/count(drug) & count(cell,drug)/count(cell) 

@final_exps_cp=@final_exps;
@final_cnvs_cp=@final_cnvs;
@final_methyls_cp=@final_methyls;
@final_mutations_cp=@final_mutations;

#@mat=glob "TRAIN_GS/*";
## head TOP2.TOP2_2 
## NCI-H2085       -48.4551227095238       TOP2.TOP2_2.NCI-H2085.Rep1.csv
## Calu-3  -21.3707527095238       TOP2.TOP2_2.Calu-3.Rep1.csv
#open TRAIN, ">train.txt" or die;
#open TRAIN_ori, ">train_ori.txt" or die;
#foreach $file (@mat){
#	@t=split '/', $file;
#	$drug=pop @t;
#	
#	@t=split '\.', $drug;
#	$drug1=$t[0];
#	$drug2=$t[1];
#	
#	#if (exists $exclude_pair{$drug}){}else{
#	if ((exists $exclude_drug{$drug1})||(exists $exclude_drug{$drug2})){
#	open OLD, "$file" or die;
#	while ($line=<OLD>){
#		chomp $line;	
#		@table=split "\t", $line;
#		$comb=$table[2];
#
#		if (exists $exclude_drug{$drug1}){
#			print TRAIN "$table[1]";
#	
#			print TRAIN "\t$ref_count{$table[0]}{$drug1}";
#			print TRAIN "\n";
#		}
#
#		if (exists $exclude_drug{$drug2}){
#			print TRAIN "$table[1]";
#	
#			print TRAIN "\t$ref_count{$table[0]}{$drug2}";
#			print TRAIN "\n";
#		}
#
#
#
#	}
#	close OLD;
#	
#		
#	}
#	#}
#}
#close TRAIN;
#close TRAIN_ori;

open NEW, ">pred_tmp.txt" or die;
@mat=glob "TEST_GS/$excluded";
open TEST, ">test.txt" or die;
foreach $file (@mat){
	open OLD, "$file" or die;
	@t=split '/', $file;
	$drug=pop @t;
	@t=split '\.', $drug;
	$drug1=$t[0];
	$drug2=$t[1];
	while ($line=<OLD>){
		chomp $line;	
		@table=split "\t", $line; #@expression=split "\t", $ref_exp{$table[0]};
		$comb=$table[2];

			print TEST "$table[1]";
	
			print TEST "\t$ref_count{$table[0]}{$t[$id]}";
			print TEST "\n";
			
	}
	close OLD;
	
	@t=split '/', $file;
	$drug=pop @t;
	open FILE, "$file" or die;
	while ($line=<FILE>){
		chomp $line;
		@table=split "\t", $line;
		print NEW "$table[0],$drug\n";
	}
	close FILE;
		
}

close TEST;
close TEST_REVERSE;
close TEST_ori;
close NEW;


