#!/usr/bin/perl

# 15 features; (mono1; mono2; mono1+mono2) * 5 concentrations

@mat=glob "../monotherapy_spread_csv/*";
open NEW, ">../monotherapy/mono_therapy_spread_min_max_avg_test.txt" or die;
foreach $file (@mat){
	open OLD, "$file" or die;
	@t=split '/', $file;
	$fullname=pop @t;
	@t=split '\.', $fullname;
	$drug1=$t[0];
	$drug2=$t[1];
	$cell=$t[2];
	<OLD>;
	$line=<OLD>;
	chomp $line;
	$line=~s/"//g;
	@table=split ',', $line;
	shift @table;
	shift @table;
	@drug2=@table; # 5 mono values
	@drug1=();
	$i=0;
	while ($i<5){
		$line=<OLD>;
		chomp $line;
		$line=~s/"//g;
		@table=split ',', $line;
		push @drug1, $table[1];
		$i++;
	}

	print NEW "$fullname";
	foreach $aaa (@drug2){
		$bbb=shift @drug1;
		if ($aaa>$bbb){
			print NEW "\t$aaa\t$bbb";
		}else{
			print NEW "\t$bbb\t$aaa";
		}
		$add=$aaa+$bbb;
		print NEW "\t$add";
			
	}
	print NEW "\n";


}
	
close NEW;
	
