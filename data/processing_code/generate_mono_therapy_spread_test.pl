#!/usr/bin/perl

# the original 10 values

#@mat=glob "data/monotherapy_spread_csv/*";
$path1=$ARGV[0];
@mat=glob "${path1}/*";

open NEW, ">data/monotherapy/mono_therapy_spread_test.txt" or die;
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
	@drug2=@table;
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
		print NEW "\t$aaa";
	}
	foreach $aaa (@drug1){
		print NEW "\t$aaa";
	}
	print NEW "\n";


}
	
close NEW;
	
