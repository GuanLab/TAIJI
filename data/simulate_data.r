# simulate_data.r

tbl=read.csv("/home/gyuanfan/2016/DC/rawdata_correct/ch1_test_monoTherapy_csvmap.csv",check.names=F,row.names=NULL,stringsAsFactors=F)
colnames(tbl)=c(colnames(tbl)[-1],"FILENAME") # the original csv has one less colname..

num=nrow(tbl)
set.seed(449)
# simply shuffle :)
for(i in 4:11){
    tbl[,i]=tbl[sample(num,num),i]
}

set.seed(449)
ind=sort(sample(dim(tbl)[1],100))
output=tbl[ind,]

write.csv(output,file="test_monotherapy.csv",row.names=F,quote=F)

path1="/home/gyuanfan/2016/DC/rawdata/Drug_synergy_data/Raw_Data_csv/ch1_ch2_monoTherapy/"
set.seed(449)
for(i in 1:nrow(output)){
    x=read.csv(paste0(path1,output[i,"FILENAME"]),check.names=F,row.names=1,stringsAsFactors=F)
    x[2:6,1]=as.character(round(as.numeric(x[2:6,1])+rnorm(5,0,10),1))
    x[1,2:6]=as.character(round(as.numeric(x[1,2:6])+rnorm(5,0,10),1))
    write.csv(x,file=paste0("./monotherapy_spread_csv/",output[i,"FILENAME"]),na=NULL)
}


