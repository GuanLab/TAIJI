#!/usr/bin/perl

# 12 features; max_conc1, max_conc2, log(max_conc1+max_conc2); IC50, H, Einf

#open OLD, "data/test_monotherapy.csv" or die;
$filename=$ARGV[0];
open OLD, $filename or die;
<OLD>;
open NEW, ">data/monotherapy/mono_therapy_min_max_avg.txt_combined" or die;
while ($line=<OLD>){
	chomp $line;
	$line=~s/"//g;
	@table=split ',', $line;
	print NEW "$table[14]"; # file
        if ($table[3]>$table[4]){
                print NEW "\t$table[3]\t$table[4]";
        }else{
                print NEW "\t$table[4]\t$table[3]";
        }
        $a=log($table[3]+$table[4]);
        print NEW "\t$a";


        if ($table[5]>$table[8]){
                print NEW "\t$table[5]\t$table[8]";
        }else{
                print NEW "\t$table[8]\t$table[5]";
        }
        $a=log($table[5]+$table[8]);
        print NEW "\t$a";
	
	
        if ($table[6]>$table[9]){
                print NEW "\t$table[6]\t$table[9]";
        }else{
                print NEW "\t$table[9]\t$table[6]";
        }
        $a=$table[6]+$table[9];
        print NEW "\t$a";


        if ($table[7]>$table[10]){
                print NEW "\t$table[7]\t$table[10]";
        }else{
                print NEW "\t$table[10]\t$table[7]";
        }
        $a=$table[7]+$table[10];
        print NEW "\t$a";

        print NEW "\n";

	
}
close OLD;
