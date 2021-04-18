#!/usr/bin/perl


#$file=$ARGV[0];
#@t=split '/', $file;
#$excluded=pop @t;
#@t=split '\.', $excluded;
#$exclude_drug{$t[0]}=0;
#$exclude_drug{$t[1]}=0;
#$exclude_pair{$excluded}=0;

open PROB, "/home/gyuanfan/2016/DC/rawdata/CCLE_target_probability/drug_cnv_probability_CCLE.txt" or die;
#open PROB, "../data/drug_cnv_probability_CCLE.txt" or die;
# head -2 drug_cnv_probability_CCLE.txt 
# WNT11   WEE1    0.039517
# WNT11   VEGFA   0.208162
while ($line=<PROB>){
	chomp $line;
	@table=split "\t", $line;
	$prob_cnv_CCLE{$table[0]}{$table[1]}=$table[2];
	$prob_cnv_CCLE{$table[1]}{$table[0]}=$table[2];
}
close PROB;
# % gene1 & gene2 - connection

open TARGET, "/home/gyuanfan/2016/DC/rawdata/CCLE_target_probability/drug_cnv_target_list_CCLE.txt" or die;
#open TARGET, "../data/drug_cnv_target_list_CCLE.txt" or die;
# head -2 drug_cnv_target_list_CCLE.txt
# ADAM17  ADAM17
# AKT     AKT1    AKT2    AKT3
while ($line=<TARGET>){
	chomp $line;
	@table=split "\t", $line;
	$drug=shift @table;
	foreach $ddd (@table){
		$cnv_CCLE{$drug}{$ddd}=0;
		$gene_cnv_CCLE{$ddd}=0;
	}
}
close TARGET;
# % drug & gene 0

open REF_EXP, "/home/gyuanfan/2016/DC/processed/imputed_data_by_tissue_CCLE/CCLE_cnv_imputed.txt" or die;
#open REF_EXP, "../data/CCLE_cnv_imputed.txt" or die;
# row cell; column gene
$title=<REF_EXP>;
chomp $title;
@cnvs_CCLE=split "\t", $title;
shift @cnvs_CCLE;

@final_cnvs_CCLE=();
foreach $eee (@cnvs_CCLE){
	if (exists $gene_cnv_CCLE{$eee}){
		push @final_cnvs_CCLE, $eee;
	}
}


while ($line=<REF_EXP>){
	chomp $line;
	$line=~s/"//g;
	@table=split "\t", $line;
	$cell=shift @table;
	foreach $eee (@cnvs_CCLE){
		$val=shift @table;
		if (exists $gene_cnv_CCLE{$eee}){
			if (exists $ref_cnv_CCLE{$cell}){
				$ref_cnv_CCLE{$cell}.="\t$val";
			}else{
				$ref_cnv_CCLE{$cell}="$val";
			}
		}
	}
}
close REF_EXP;
			







open PROB, "/home/gyuanfan/2016/DC/rawdata/CCLE_target_probability/drug_exp_probability_CCLE.txt" or die;
#open PROB, "../data/drug_exp_probability_CCLE.txt" or die;
while ($line=<PROB>){
	chomp $line;
	@table=split "\t", $line;
	$prob_CCLE{$table[0]}{$table[1]}=$table[2];
	$prob_CCLE{$table[1]}{$table[0]}=$table[2];
}
close PROB;

open TARGET, "/home/gyuanfan/2016/DC/rawdata/CCLE_target_probability/drug_exp_target_list_CCLE.txt" or die;
#open TARGET, "../data/drug_exp_target_list_CCLE.txt" or die;
while ($line=<TARGET>){
	chomp $line;
	@table=split "\t", $line;
	$drug=shift @table;
	foreach $ddd (@table){
		$exp_CCLE{$drug}{$ddd}=0;

		$gene_CCLE{$ddd}=0;
	}
}
close TARGET;


open REF_EXP, "/home/gyuanfan/2016/DC/processed/imputed_data_by_tissue_CCLE/CCLE_exp_imputed.txt" or die;
#open REF_EXP, "../data/CCLE_exp_imputed.txt" or die;
$title=<REF_EXP>;
chomp $title;
@exps=split "\t", $title;
shift @exps;

@final_exps_CCLE=();
foreach $eee (@exps){
	if (exists $gene_CCLE{$eee}){
		push @final_exps_CCLE, $eee;
	}
}


while ($line=<REF_EXP>){
	chomp $line;
	$line=~s/"//g;
	@table=split "\t", $line;
	$cell=shift @table;
	foreach $eee (@exps){
		$val=shift @table;
		if (exists $gene_CCLE{$eee}){
			if (exists $ref_exp_CCLE{$cell}){
				$ref_exp_CCLE{$cell}.="\t$val";
			}else{
				$ref_exp_CCLE{$cell}="$val";
			}
		}
	}
}
close REF_EXP;

open PROB, "/home/gyuanfan/2016/DC/rawdata/drug_mutation_probability.txt" or die;
#open PROB, "../data/drug_mutation_probability.txt" or die;
while ($line=<PROB>){
	chomp $line;
	@table=split "\t", $line;
	$prob_mutation{$table[0]}{$table[1]}=$table[2];
	$prob_mutation{$table[1]}{$table[0]}=$table[2];
}
close PROB;

open TARGET, "/home/gyuanfan/2016/DC/rawdata/drug_mutation_target_list.txt" or die;
#open TARGET, "../data/drug_mutation_target_list.txt" or die;
while ($line=<TARGET>){
	chomp $line;
	@table=split "\t", $line;
	$drug=shift @table;
	foreach $ddd (@table){
		$mutation{$drug}{$ddd}=0;
		$gene_mutation{$ddd}=0;
	}
}
close TARGET;


open REF_EXP, "/home/gyuanfan/2016/DC/processed/mutations.txt" or die;
#open REF_EXP, "../data/mutations.txt" or die;
$title=<REF_EXP>;
chomp $title;
@mutations=split "\t", $title;
shift @mutations;

@final_mutations=();
foreach $eee (@mutations){
	if (exists $gene_mutation{$eee}){
		push @final_mutations, $eee;
	}
}


while ($line=<REF_EXP>){
	chomp $line;
	$line=~s/"//g;
	@table=split "\t", $line;
	$cell=shift @table;
	foreach $eee (@mutations){
		$val=shift @table;
		if (exists $gene_mutation{$eee}){
			if (exists $ref_mutation{$cell}){
				$ref_mutation{$cell}.="\t$val";
			}else{
				$ref_mutation{$cell}="$val";
			}
		}
	}
}
close REF_EXP;
			



open PROB, "/home/gyuanfan/2016/DC/rawdata/drug_exp_probability.txt" or die;
#open PROB, "../data/drug_exp_probability.txt" or die;
while ($line=<PROB>){
	chomp $line;
	@table=split "\t", $line;
	$prob{$table[0]}{$table[1]}=$table[2];
	$prob{$table[1]}{$table[0]}=$table[2];
}
close PROB;

open TARGET, "/home/gyuanfan/2016/DC/rawdata/drug_exp_target_list.txt" or die;
#open TARGET, "../data/drug_exp_target_list.txt" or die;
while ($line=<TARGET>){
	chomp $line;
	@table=split "\t", $line;
	$drug=shift @table;
	foreach $ddd (@table){
		$exp{$drug}{$ddd}=0;
		$gene{$ddd}=0;
	}
}
close TARGET;


open REF_EXP, "/home/gyuanfan/2016/DC/processed/imputed_data_by_tissue/gex_imputed.txt" or die;
#open REF_EXP, "../data/gex_imputed.txt" or die;
$title=<REF_EXP>;
chomp $title;
@exps=split "\t", $title;
shift @exps;

@final_exps=();
foreach $eee (@exps){
	if (exists $gene{$eee}){
		push @final_exps, $eee;
	}
}


while ($line=<REF_EXP>){
	chomp $line;
	$line=~s/"//g;
	@table=split "\t", $line;
	$cell=shift @table;
	foreach $eee (@exps){
		$val=shift @table;
		if (exists $gene{$eee}){
			if (exists $ref_exp{$cell}){
				$ref_exp{$cell}.="\t$val";
			}else{
				$ref_exp{$cell}="$val";
			}
		}
	}
}
close REF_EXP;
			



open PROB, "/home/gyuanfan/2016/DC/rawdata/drug_cnv_probability.txt" or die;
#open PROB, "../data/drug_cnv_probability.txt" or die;
while ($line=<PROB>){
	chomp $line;
	@table=split "\t", $line;
	$prob_cnv{$table[0]}{$table[1]}=$table[2];
	$prob_cnv{$table[1]}{$table[0]}=$table[2];
}
close PROB;

open TARGET, "/home/gyuanfan/2016/DC/rawdata/drug_cnv_target_list.txt" or die;
#open TARGET, "../data/drug_cnv_target_list.txt" or die;
while ($line=<TARGET>){
	chomp $line;
	@table=split "\t", $line;
	$drug=shift @table;
	foreach $ddd (@table){
		$cnv{$drug}{$ddd}=0;
		$gene_cnv{$ddd}=0;
	}
}
close TARGET;


open REF_EXP, "/home/gyuanfan/2016/DC/processed/imputed_data_by_tissue/cnv_gene_min_imputed.txt" or die;
#open REF_EXP, "../data/cnv_gene_min_imputed.txt" or die;
$title=<REF_EXP>;
chomp $title;
@cnvs=split "\t", $title;
shift @cnvs;

@final_cnvs=();
foreach $eee (@cnvs){
	if (exists $gene_cnv{$eee}){
		push @final_cnvs, $eee;
	}
}


while ($line=<REF_EXP>){
	chomp $line;
	$line=~s/"//g;
	@table=split "\t", $line;
	$cell=shift @table;
	foreach $eee (@cnvs){
		$val=shift @table;
		if (exists $gene_cnv{$eee}){
			if (exists $ref_cnv{$cell}){
				$ref_cnv{$cell}.="\t$val";
			}else{
				$ref_cnv{$cell}="$val";
			}
		}
	}
}
close REF_EXP;
			



open PROB, "/home/gyuanfan/2016/DC/rawdata/drug_methyl_probability.txt" or die;
#open PROB, "../data/drug_methyl_probability.txt" or die;
while ($line=<PROB>){
	chomp $line;
	@table=split "\t", $line;
	$prob_methyl{$table[0]}{$table[1]}=$table[2];
	$prob_methyl{$table[1]}{$table[0]}=$table[2];
}
close PROB;

open TARGET, "/home/gyuanfan/2016/DC/rawdata/drug_methyl_target_list.txt" or die;
#open TARGET, "../data/drug_methyl_target_list.txt" or die;
while ($line=<TARGET>){
	chomp $line;
	@table=split "\t", $line;
	$drug=shift @table;
	foreach $ddd (@table){
		$methyl{$drug}{$ddd}=0;
		$gene_methyl{$ddd}=0;
	}
}
close TARGET;

open REF_EXP, "/home/gyuanfan/2016/DC/processed/imputed_data_by_tissue/methyl_beta_gene_imputed.txt" or die;
#open REF_EXP, "../data/methyl_beta_gene_imputed.txt" or die;
$title=<REF_EXP>;
chomp $title;
@methyls=split "\t", $title;
shift @methyls;

@final_methyls=();
foreach $eee (@methyls){
	if (exists $gene_methyl{$eee}){
		push @final_methyls, $eee;
	}
}

while ($line=<REF_EXP>){
	chomp $line;
	$line=~s/"//g;
	@table=split "\t", $line;
	$cell=shift @table;
	foreach $eee (@methyls){
		$val=shift @table;
		if (exists $gene_methyl{$eee}){
			if (exists $ref_methyl{$cell}){
				$ref_methyl{$cell}.="\t$val";
			}else{
				$ref_methyl{$cell}="$val";
			}
		}
	}
}
close REF_EXP;
			
@final_exps_cp=@final_exps;
@final_cnvs_cp=@final_cnvs;
@final_methyls_cp=@final_methyls;
@final_mutations_cp=@final_mutations;
@final_exps_CCLE_cp=@final_exps_CCLE;
@final_cnvs_CCLE_cp=@final_cnvs_CCLE;





$file_drug_list=$ARGV[0];
open DRUG_LIST, $file_drug_list or die;
while ($line=<DRUG_LIST>){
    chomp $line;
    $the_drug=$line;
    $exclude_drug{$line}=0;
    print "$the_drug\n";

@mat=glob "TRAIN_GS/*";
open TRAIN, ">train.txt" or die;
#open TRAIN_ori, ">train_ori.txt" or die;
foreach $file (@mat){
	@t=split '/', $file;
	$drug=pop @t;
	
	@t=split '\.', $drug;
	$drug1=$t[0];
	$drug2=$t[1];
	
#	if (exists $exclude_pair{$drug}){}else{
	if ((exists $exclude_drug{$drug1})||(exists $exclude_drug{$drug2})){
	open OLD, "$file" or die;
	while ($line=<OLD>){
		chomp $line;	
		@table=split "\t", $line;
		$comb=$table[2];

			@expression_new=();

			@expression=split "\t", $ref_exp_CCLE{$table[0]};

			foreach $gene (@final_exps_CCLE){
				$aaa=shift @expression;
				if ((exists $exp_CCLE{$drug1}{$gene})||(exists $exp_CCLE{$drug2}{$gene})){
					$aaa=0;
				}else{
					$bbb=0;
					foreach $ggg (@final_exps_CCLE_cp){
						if ((exists $exp_CCLE{$drug1}{$ggg})||(exists $exp_CCLE{$drug2}{$ggg})){
							$connect=$prob_CCLE{$ggg}{$gene};
							if ($connect>$bbb){
								$bbb=$connect;
							}
						}
					}
					$aaa=$aaa*(1-$bbb);
				}
				push @expression_new, $aaa;
			}

			@expression=split "\t", $ref_cnv_CCLE{$table[0]};

			foreach $gene (@final_cnvs_CCLE){
				$aaa=shift @expression;
				if ((exists $cnv_CCLE{$drug1}{$gene})||(exists $cnv_CCLE{$drug2}{$gene})){
					$aaa=0;
				}else{
					$bbb=0;
					foreach $ggg (@final_cnvs_CCLE_cp){
						if ((exists $cnv_CCLE{$drug1}{$ggg})||(exists $cnv_CCLE{$drug2}{$ggg})){
							$connect=$prob_cnv_CCLE{$ggg}{$gene};
							if ($connect>$bbb){
								$bbb=$connect;
							}
						}
					}
					$aaa=$aaa*(1-$bbb);
				}
				push @expression_new, $aaa;
			}


			@expression=split "\t", $ref_exp{$table[0]};

			foreach $gene (@final_exps){
				$aaa=shift @expression;
				if ((exists $exp{$drug1}{$gene})||(exists $exp{$drug2}{$gene})){
					$aaa=0;
				}else{
					$bbb=0;
					foreach $ggg (@final_exps_cp){
						if ((exists $exp{$drug1}{$ggg})||(exists $exp{$drug2}{$ggg})){
							$connect=$prob{$ggg}{$gene};
							if ($connect>$bbb){
								$bbb=$connect;
							}
						}
					}
					$aaa=$aaa*(1-$bbb);
				}
				push @expression_new, $aaa;
			}
				
			
			@expression=split "\t", $ref_cnv{$table[0]};

			foreach $gene (@final_cnvs){
				$aaa=shift @expression;
				if ((exists $cnv{$drug1}{$gene})||(exists $cnv{$drug2}{$gene})){
					$aaa=0;
				}else{
					$bbb=0;
					foreach $ggg (@final_cnvs_cp){
						if ((exists $cnv{$drug1}{$ggg})||(exists $cnv{$drug2}{$ggg})){
							$connect=$prob_cnv{$ggg}{$gene};
							if ($connect>$bbb){
								$bbb=$connect;
							}
						}
					}
					$aaa=$aaa*(1-$bbb);
				}
				push @expression_new, $aaa;
			}



			@expression=split "\t", $ref_methyl{$table[0]};

			foreach $gene (@final_methyls){
				$aaa=shift @expression;
				if ((exists $methyl{$drug1}{$gene})||(exists $methyl{$drug2}{$gene})){
					$aaa=0;
				}else{
					$bbb=0;
					foreach $ggg (@final_methyls_cp){
						if ((exists $methyl{$drug1}{$ggg})||(exists $methyl{$drug2}{$ggg})){
							$connect=$prob_methyl{$ggg}{$gene};
							if ($connect>$bbb){
								$bbb=$connect;
							}
						}
					}
					$aaa=$aaa*(1-$bbb);
				}
				push @expression_new, $aaa;
			}



			@expression=split "\t", $ref_mutation{$table[0]};

			foreach $gene (@final_mutations){
				$aaa=shift @expression;
				if ((exists $mutation{$drug1}{$gene})||(exists $mutation{$drug2}{$gene})){
					$aaa=1;
				}else{
					$bbb=0;
					foreach $ggg (@final_mutations_cp){
						if ((exists $mutation{$drug1}{$ggg})||(exists $mutation{$drug2}{$ggg})){
							$connect=$prob_mutation{$ggg}{$gene};
							if ($connect>$bbb){
								$bbb=$connect;
							}
						}
					}
					$aaa=$aaa*$bbb;
				}
				push @expression_new, $aaa;
			}

			
		print TRAIN "$table[1]";
		foreach $aaa (@expression_new){
			print TRAIN "\t$aaa";
		}
		print TRAIN "\n";



	}
	close OLD;
	
		
	}
#	}
}
close TRAIN;
close TRAIN_ori;

system "python molecular_save.py $the_drug"; 

}
close DRUG_LIST;




