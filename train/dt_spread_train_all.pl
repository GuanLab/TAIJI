#!/usr/bin/perl


# 1 generate_mono_therapy_spread_max_min_avg.pl
# 15 features; (mono1; mono2; mono1+mono2) * 5 concentrations 
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_spread_min_max_avg_test.txt" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	$a=shift @table;
	$ref_ori{$comb}=$a;
	foreach $aaa (@table){
		$ref_ori{$comb}.="\t$aaa";
	}
}
close REF_DATA;

# 2 generate_mono_therapy_spread_max_min_diff_test.pl
# 15 features; diff
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_spread_min_max_avg_diff_test.txt" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref_ori{$comb}.="\t$aaa";
	}
}
close REF_DATA;

# 3 generate_mono_therapy_spread_max_min_diff5_test.pl
# 15 features; minus cell avg
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_spread_min_max_avg_diff5_test.txt" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref_ori{$comb}.="\t$aaa";
	}
}
close REF_DATA;

# 4 generate_mono_therapy_max_min_avg_combined.pl
# 12 features; max_conc, IC50, H, Einf
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_min_max_avg.txt_combined" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref_ori{$comb}.="\t$aaa";
	}
}
close REF_DATA;
	
# 5 generate_mono_therapy_max_min_diff_combined.pl
# 12 features; diff max_conc, IC50, H, Einf
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_min_max_avg.txt_combined_diff" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref_ori{$comb}.="\t$aaa";
	}
}
close REF_DATA;
	
# 6 generate_mono_therapy_max_min_diff5_combined.pl
# 12 features; cell diff max_conc, IC50, H, Einf
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_min_max_avg.txt_combined_diff5" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref_ori{$comb}.="\t$aaa";
	}
}
close REF_DATA;
	
# 7 generate_mono_therapy_spread_test.pl
# 10 features; original values
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_spread_test.txt" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	$a=shift @table;
	$ref{$comb}=$a;
	foreach $aaa (@table){
		$ref{$comb}.="\t$aaa";
	}
}
close REF_DATA;

# 8 generate_mono_therapy_spread_diff_test.pl
# 10 features; diff original values
#open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_spread_diff_test.txt" or die;
# !! Here Yuanfang's original file only has 8 features - I don't know why 2 features are missing..
# So I replace it with mine
open REF_DATA, "/home/hyangl/2016/DC/processed_correct/mono_therapy_spread_diff_test.txt" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref{$comb}.="\t$aaa";
	}
}
close REF_DATA;
		
# 9 generate_mono_therapy_spread_diff5_test.pl
# 10 features; cell diff original values
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_spread_diff5_test.txt" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref{$comb}.="\t$aaa";
	}
}
close REF_DATA;
		
# 10 generate_mono_therapy_combined.pl
# 8 feature; original values
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy.txt_combined" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref{$comb}.="\t$aaa";
	}
}
close REF_DATA;

# 11 generate_mono_therapy_diff_test.pl
# 8 feature; diff original values
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy.txt_combined_diff" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref{$comb}.="\t$aaa";
	}
}
close REF_DATA;

# 12 generate_mono_therapy_diff5_test.pl
# 8 feature; cell diff original values
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy.txt_combined_diff5" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref{$comb}.="\t$aaa";
	}
}
close REF_DATA;

# 13 generate_mono_therapy_spread_reverse_test.pl
# 10 features; original values
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_spread_reverse_test.txt" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	$a=shift @table;
	$ref_reverse{$comb}=$a;
	foreach $aaa (@table){
		$ref_reverse{$comb}.="\t$aaa";
	}
}
close REF_DATA;
		

# 14 generate_mono_therapy_spread_diff_test.pl
# 10 features; diff original values
#open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_spread_reverse_diff_test.txt" or die;
## Here !!
open REF_DATA, "/home/hyangl/2016/DC/processed_correct/mono_therapy_spread_reverse_diff_test.txt" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref_reverse{$comb}.="\t$aaa";
	}
}
close REF_DATA;
	
# 15 generate_mono_therapy_spread_diff5_test.pl
# 10 features; cell diff original values
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_spread_reverse_diff5_test.txt" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref_reverse{$comb}.="\t$aaa";
	}
}
close REF_DATA;
	
# 16 generate_mono_therapy_reverse_combined.pl
# 8 features; original values
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_reverse.txt_combined" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref_reverse{$comb}.="\t$aaa";
	}
}
close REF_DATA;

# 17 generate_mono_therapy_diff_test.pl
# 8 features; diff original values
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_reverse.txt_combined_diff" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref_reverse{$comb}.="\t$aaa";
	}
}
close REF_DATA;

# 18 generate_mono_therapy_diff_test.pl
# 8 features; diff original values
open REF_DATA, "/home/gyuanfan/2016/DC/processed_correct/mono_therapy_reverse.txt_combined_diff5" or die;
while ($line=<REF_DATA>){
	chomp $line;
	@table=split "\t", $line;
	$comb=shift @table;
	foreach $aaa (@table){
		$ref_reverse{$comb}.="\t$aaa";
	}
}
close REF_DATA;


@list=@ARGV;

@mat=glob "TRAIN_GS/*";
open TRAIN, ">train.txt" or die;
open TRAIN_ori, ">train_ori.txt" or die;
foreach $file (@mat){
	@t=split '/', $file;
	$drug=pop @t;
	@t=split '\.', $drug;
	$drug1=$t[0];
	$drug2=$t[1];
	
	open OLD, "$file" or die;
	while ($line=<OLD>){
		chomp $line;	
		@table=split "\t", $line;
		$comb=$table[2];
		print TRAIN "$table[1]";
		print TRAIN "\t$ref{$table[2]}";
		print TRAIN "\n";
		print TRAIN "$table[1]";
		print TRAIN "\t$ref_reverse{$table[2]}";
		print TRAIN "\n";
		print TRAIN_ori "$table[1]";
		print TRAIN_ori "\t$ref_ori{$table[2]}";
		print TRAIN_ori "\n";
	}
	close OLD;
	
		
}
close TRAIN;

system "python monotherapy_save.py";

