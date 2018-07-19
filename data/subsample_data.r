# subsample_data.r

tbl=read.csv("/home/gyuanfan/2016/DC/rawdata_correct/ch1_test_monoTherapy_csvmap.csv",check.names=F,row.names=NULL,stringsAsFactors=F)
colnames(tbl)=c(colnames(tbl)[-1],"FILENAME") # the original csv has one less colname..

set.seed(449)
ind=sort(sample(dim(tbl)[1],100))
x=tbl[ind,]

write.csv(x,file="test_monotherapy.csv",row.names=F,quote=F)

path1="/home/gyuanfan/2016/DC/rawdata/Drug_synergy_data/Raw_Data_csv/ch1_ch2_monoTherapy/"
for(i in 1:nrow(x)){
    system(paste0("cp ", path1, x[i,"FILENAME"], " ./monotherapy_spread_csv/"))
}
