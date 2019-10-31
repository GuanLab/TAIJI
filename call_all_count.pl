#!/usr/bin/perl

@mat=glob "TEST_GS/*" or die;
open NEW, ">pred_count.txt" or die;
print NEW "CELL_LINE,COMBINATION_ID,PREDICTION\n";
foreach $file (@mat){
	#system "rm output1.txt output2.txt output_reverse1.txt output_reverse2.txt output_ori1.txt output_ori2.txt";
	if (-f "output1.txt"){
	    system "rm output1.txt";
        }
	if (-f "output2.txt"){
	    system "rm output2.txt";
        }

        @t=split '/', $file;
        $drug_pair=pop @t; 
        @t=split '\.', $drug_pair;
        $drug1=$t[0];
        $drug2=$t[1];
        print "$drug_pair\n";

	system "perl dt_count_test.pl $file 0";
	#$i=0;
	#open OLD, "train.txt" or die;
	#while ($line=<OLD>){
	#	$i++;
	#}
	#close OLD;
	#if ($i>0){

		#system "matlab -nojvm -nodisplay -nosplash -r 'tree'";
                system "python count_pred.py $drug1";
		system "mv output.txt output1.txt";
	#}



	system "perl dt_count_test.pl $file 1";
	#$i=0;
	#open OLD, "train.txt" or die;
	#while ($line=<OLD>){
	#	$i++;
	#}
	#close OLD;
	#if ($i>0){
		#system "matlab -nojvm -nodisplay -nosplash -r 'tree'";
                system "python count_pred.py $drug2";


		system "mv output.txt output2.txt";

	#}

	open OLD, "pred_tmp.txt" or die;
	if (-f "output1.txt"){
		open PRED1, "output1.txt" or die;
	}
	if (-f "output2.txt"){
		open PRED2, "output2.txt" or die;
	}
	while ($line=<OLD>){
		chomp $line;
		print NEW "$line";
		$l=<PRED1>;
		chomp $l;
		$l=~s/ //g;
		$l_r=<PRED_R1>;
		chomp $l_r;
		$l_r=~s/ //g;
		$l_o=<PRED_O1>;
		chomp $l_o;
		$l_o=~s/ //g;
		$avg1=($l+$l_r+$l_o+$l_o)/4;



		$l=<PRED2>;
		chomp $l;
		$l=~s/ //g;
		$l_r=<PRED_R2>;
		chomp $l_r;
		$l_r=~s/ //g;
		$l_o=<PRED_O2>;
		chomp $l_o;
		$l_o=~s/ //g;
		$avg2=($l+$l_r+$l_o+$l_o)/4;
		$avg=($avg1+$avg2);
		print NEW ",$avg\n";
	}
	close PRED;




}
close NEW;

