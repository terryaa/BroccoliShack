library('sparklyr')
library('stringr')
library('dplyr')
library('car')
library('DBI')
library('rJava')
library('RJDBC')
sc<-spark_connect("local")
hdfs_dir_list <- function(path){
      lis <- system(paste('hdfs dfs -ls ',path),intern=TRUE)
      li<-list()
      #frame.aggr<-data.frame()
      for (x in lis){
		idx<- str_locate(x,'/')
      		result<-substr(x,idx[,1],nchar(x))
		if (is.na(str_locate(result,"SUCCESS")[,1])){
			li<-append(result,li)
		}
      }
      frame.aggr<-spark_read_csv(sc,paste("hdfs://master:9000",li[1],sep=""))
      if (length(li)>=2){
      	for (x in li[1:length(li)]){
	      if (!is.na(x)){
		      data<-spark_read_csv(sc,paste("hdfs://master:9000",x,sep=""))
		      frame.aggr<-rbind(frame.aggr,data)
	      }
      	}
      }
      frame.aggr=data.frame(frame.aggr)
      return (unique(frame.aggr))
}


#날씨읽어오기
path<-"/home/hadoop/data/more_processed_data/month_workingtime_data/cheonan"
cnwork<-hdfs_dir_list(path)

path<-"/home/hadoop/data/more_processed_data/month_workingtime_data/naju"
njwork<-hdfs_dir_list(path)


path<-"/home/hadoop/data/more_processed_data/weather_data/cheonan"
cnweather<-hdfs_dir_list(path)


path<-"/home/hadoop/data/more_processed_data/weather_data/naju"
njweather<-hdfs_dir_list(path)

cnweather_2002<-cnweather[13:(nrow(cnweather)-24),]
njweather_2002<-njweather[13:(nrow(njweather)-24),]
cnweather_test=cnweather[205:216,]
njweather_test=njweather[205:216,]

cnwork$hired<-cnwork$hired/8
njwork$hired<-njwork$hired/8
cnwork_2002<-cnwork[157:nrow(cnwork)-12,]
njwork_2002<-njwork[157:nrow(njwork)-12,]
cnwork_1991<-cnwork[25:nrow(cnwork)-12,]
njwork_1991<-njwork[25:nrow(njwork)-12,]
cnwork_test<-cnwork[205:216,]
njwork_test<-njwork[205:216,]

#지하수 읽어오기
path<-"/home/hadoop/data/more_processed_data/water_data/cheonan"
c_water<-hdfs_dir_list(path)

path<-"/home/hadoop/data/more_processed_data/water_data/naju"
n_water<-hdfs_dir_list(path)

c_water_2002 <-c_water[c(145:(nrow(c_water)-24)),]
n_water_2002 <-n_water[c(145:(nrow(n_water)-24)),]
c_water_1991<-c_water[c(13:(nrow(c_water)-24)),]
n_water_1991<-c_water[c(13:(nrow(n_water)-24)),]
c_water_test<-c_water[205:216,]
n_water_test<-n_water[205:216,]


#생산량 데이터 읽어오기
path<-"/home/hadoop/data/more_processed_data/pear_production/cheonan"
cn_production<-hdfs_dir_list(path)

path<-"/home/hadoop/data/more_processed_data/pear_production/naju"
nj_production<-hdfs_dir_list(path)


cn_production_2002<-cn_production[145:(nrow(cn_production)-24),]
nj_production_2002<-nj_production[145:(nrow(nj_production)-24),]
cn_production_1991<-cn_production[13:(nrow(cn_production)-24),]
nj_production_1991<-nj_production[13:(nrow(nj_production)-24),]
cn_production_test<-cn_production[205:216,]
nj_production_test<-nj_production[205:216,]

#소득 데이터 불러오기
path<-"/home/hadoop/data/more_processed_data/income_data/cheonan"
cn_income<-hdfs_dir_list(path)

path<-"/home/hadoop/data/more_processed_data/income_data/naju"
nj_income<-hdfs_dir_list(path)

cn_income_2002<-cn_income[145:(nrow(cn_income)-24),]
nj_income_2002<-nj_income[145:(nrow(nj_income)-24),]
cn_income_1991<-cn_income[13:(nrow(cn_income)-24),]
nj_income_1991<-nj_income[13:(nrow(nj_income)-24),]
cn_income_test<-cn_income[205:216,]
nj_income_test<-nj_income[205:216,]

#가격 데이터 불러오기
path<-"/home/hadoop/data/more_processed_data/price_data/cheonan"
cn_price<-hdfs_dir_list(path)

path<-"/home/hadoop/data/more_processed_data/price_data/naju"
nj_price<-hdfs_dir_list(path)

cn_price_2002<-cn_price[145:(nrow(cn_price)-24),]
nj_price_2002<-nj_price[145:(nrow(nj_price)-24),]
cn_price_1991<-cn_price[13:(nrow(cn_price)-24),]
nj_price_1991<-nj_price[13:(nrow(nj_price)-24),]
cn_price_test<-cn_price[205:216,]
nj_price_test<-nj_price[205:216,]

#비정보 데이터 불러오기
path<-"/home/hadoop/data/more_processed_data/rain_data/cheonan"
cn_rain<-hdfs_dir_list(path)

path<-"/home/hadoop/data/more_processed_data/rain_data/naju"
nj_rain<-hdfs_dir_list(path)

cn_rain_2002<-cn_rain[145:(nrow(cn_rain)-24),]
nj_rain_2002<-nj_rain[145:(nrow(nj_rain)-24),]
cn_rain_1991<-cn_rain[13:(nrow(cn_rain)-24),]
nj_rain_1991<-cn_rain[13:(nrow(nj_rain)-24),]
cn_rain_test<-cn_rain[205:216,]
nj_rain_test<-nj_rain[205:216,]

#2002~2017년도 천안(날씨포함)

whole_weather_water_prod_income_price_cn_2002<-data.frame(cnweather_2002[1:8],c_water_2002[1:4],as.data.frame(cn_production_2002[1]),cn_income_2002[1:3],as.data.frame(cn_price_2002[1]),cn_rain_2002[1:12])
model_whole_cn_2002<-lm(cnwork_2002$hired ~ . , data=whole_weather_water_prod_income_price_cn_2002)
summary(model_whole_cn_2002)
vif(model_whole_cn_2002)

#a <- c(cnweather_2002$mnhavgrhm)
b <- c(cnweather_2002$mnhavgta)
c <- c(cnweather_2002$mnhavgws)
d <- c(cnweather_2002$mnhminrhm)
e<-  c(cnweather_2002$mnhminta)
#f<- c(cnweather_2002$mnhsumrn)
#g<-c(cnweather_2002$mnhsumss)
f<-c(c_water_2002$bac)
h<-c(c_water_2002$no3n)
i<-c(c_water_2002$ph)
j<-c(cn_production_2002$cheonan)
k<-c(cn_income_2002$cheonan_pear_income)
l<-c(cn_price_2002$price)
m<-c(cn_rain_2002$KionueqL)
o<-c(cn_rain_2002$NH4ionueqL)
p<-c(cn_rain_2002$FionueqL)
q<-c(cn_rain_2002$NaionueqL)
col_correlated_cn_2002<-data.frame(mnhavgta=b,mnhavgws=c,mnhminrhm=d,bac=f,no3n=h,ph=i,production=j,K_ion=m,F_ion=p,NA_ion=q)
#날씨 & 지하수 $ 생산량 & 소득 줄여진 컬럼 모델
model_adjr2_cn_2002<-lm(cnwork_2002$hired ~  .,data=col_correlated_cn_2002)
summary (model_adjr2_cn_2002)
vif(model_adjr2_cn_2002)

#1991~2017년도 천안 (날씨빼고)
whole_water_prod_income_price_cn_1991<-data.frame(c_water_1991[1:4],as.data.frame(cn_production_1991[1]),cn_income_1991[1:3],as.data.frame(cn_price_1991[1]),cn_rain_1991[1:12])
model_whole_cn_1991<-lm(cnwork_1991$hired ~ . , data=whole_water_prod_income_price_cn_1991)
summary(model_whole_cn_1991)
vif(model_whole_cn_1991)

#a <- c(cnweather_1991$mnhavgrhm)
#b <- c(cnweather_1991$mnhavgta)
#c <- c(cnweather_1991$mnhavgws)
#d <- c(cnweather_1991$mnhminrhm)
#e<-  c(cnweather_1991$mnhminta)
#f<- c(cnweather_1991$mnhsumrn)
#g<-c(cnweather_1991$mnhsumss)

g<-c(c_water_1991$cl)
f<-c(c_water_1991$bac)
h<-c(c_water_1991$no3n)
i<-c(c_water_1991$ph)
j<-c(cn_production_1991$cheonan)
k<-c(cn_income_1991$cheonan_pear_income)
l<-c(cn_price_1991$price)
m<-c(cn_rain_1991$KionueqL)
o<-c(cn_rain_1991$NH4ionueqL)
p<-c(cn_rain_1991$FionueqL)
q<-c(cn_rain_1991$SO4ionueqL)
u<-c(cn_rain_1991$NO3ionueqL)
col_correlated_cn_1991<-data.frame(cl=g,bac=f,no3n=h,ph=i,income=k,K_ion=m,NH4_ion=o,SO4_ion=q,NO3_ion=u)

#날씨 & 지하수 $ 생산량 &.income 줄여진 컬럼 모델
model_adjr2_cn_1991<-lm(cnwork_1991$hired ~  .,data=col_correlated_cn_1991)
summary (model_adjr2_cn_1991)
vif(model_adjr2_cn_1991)

#2002~2017년도 나주(날씨포함)

whole_weather_water_prod_income_price_nj_2002<-data.frame(njweather_2002[1:7],n_water_2002[1:4],as.data.frame(nj_production_2002[1]),nj_income_2002[1:3],as.data.frame(nj_price_2002[1]),nj_rain_2002[1:12])
model_whole_nj_2002<-lm(njwork_2002$hired ~ . , data=whole_weather_water_prod_income_price_nj_2002)
summary(model_whole_nj_2002)
vif(model_whole_nj_2002)

#a <- c(njweather_2002$mnhavgrhm)
b <- c(njweather_2002$mnhavgta)
c <- c(njweather_2002$mnhavgws)
d <- c(njweather_2002$mnhminrhm)
e<-  c(njweather_2002$mnhminta)
f<- c(njweather_2002$mnhsumrn)
#g<-c(njweather_2002$mnhsumss)
f<-c(n_water_2002$bac)
h<-c(n_water_2002$no3n)
i<-c(n_water_2002$ph)
j<-c(nj_production_2002$naju)
r<-c(nj_income_2002$naju_pear_operationExpense)
k<-c(nj_income_2002$naju_pear_income)
s<-c(nj_income_2002$naju_pear_grossIncome)
l<-c(nj_price_2002$price)
m<-c(nj_rain_2002$KionueqL)
o<-c(nj_rain_2002$NH4ionueqL)
p<-c(nj_rain_2002$FionueqL)
q<-c(nj_rain_2002$NaionueqL)
t<-c(nj_rain_2002$Mg2ionueqL)
u<-c(nj_rain_2002$NO3ionueqL)
v<-c(nj_rain_2002$precipitationmm)
z<-c(nj_rain_2002$SO4ionueqL)
col_correlated_nj_2002<-data.frame(mnhavgta=b,mnhsumrn=f,no3n=h,management_fee=r,Mg2_ion=t,NH4_ion=o,NO3_ion=u,K_ion=m,rainfall=v)
#날씨 & 지하수 $ 생산량 &.income 줄여진 컬럼 모델
model_adjr2_nj_2002<-lm(njwork_2002$hired ~  .,data=col_correlated_nj_2002)
summary (model_adjr2_nj_2002)
vif(model_adjr2_nj_2002)

#1991~2017년도 나주 (날씨빼고)
whole_water_prod_income_price_nj_1991<-data.frame(n_water_1991[1:4],as.data.frame(nj_production_1991[1]),nj_income_1991[1:3],as.data.frame(nj_price_1991[1]),nj_rain_1991[1:12])
model_whole_nj_1991<-lm(njwork_1991$hired ~ . , data=whole_water_prod_income_price_nj_1991)
summary(model_whole_nj_1991)
vif(model_whole_nj_1991)

#a <- c(cnweather_1991$mnhavgrhm)
#b <- c(cnweather_1991$mnhavgta)
#c <- c(cnweather_1991$mnhavgws)
#d <- c(cnweather_1991$mnhminrhm)
#e<-  c(cnweather_1991$mnhminta)
#f<- c(cnweather_1991$mnhsumrn)
#g<-c(cnweather_1991$mnhsumss)
g<-c(n_water_1991$cl)
f<-c(n_water_1991$bac)
h<-c(n_water_1991$no3n)
i<-c(n_water_1991$ph)
j<-c(nj_production_1991$naju)
r<-c(nj_income_1991$naju_pear_operationExpense)
k<-c(nj_income_1991$naju_pear_income)
l<-c(nj_price_1991$price)
m<-c(nj_rain_1991$KionueqL)
o<-c(nj_rain_1991$NH4ionueqL)
p<-c(nj_rain_1991$FionueqL)
q<-c(nj_rain_1991$SO4ionueqL)
u<-c(nj_rain_1991$NO3ionueqL)
v<-c(nj_rain_1991$precipitationmm)
col_correlated_nj_1991<-data.frame(bac=f,no3n=h,ph=i,management_fee=r,K_ion=m,NH4_ion=o,NO3_ion=u)
#날씨 & 지하수 $ 생산량 &.income 줄여진 컬럼 모델
model_adjr2_nj_1991<-lm(njwork_1991$hired ~  .,data=col_correlated_nj_1991)
summary (model_adjr2_nj_1991)
vif(model_adjr2_nj_1991)

#컬럼들 csv로 추출
#write.csv(model_whole_cn_1991,"model_whole_cn_1991.csv")
#write.csv(model_whole_nj_1991,"model_whole_nj_2002.csv")
#write.csv(model_whole_cn_2002,"model_whole_cn_1991.csv")
#write.csv(model_whole_nj_2002,"model_whole_nj_2002.csv")


#예측 및 correlation을 통해 예측값과 실제값과의 상관성 분석, 높을수록 좋은 예측률.
#예측에 쓰일 컬럼 생성. 지금은2017년도자료
predictframe=data.frame(mnhavgta=cnweather_test$mnhavgta,mnhavgws=cnweather_test$mnhavgws,mnhminrhm=cnweather_test$mnhminrhm,bac=c_water_test$bac,no3n=c_water_test$no3n,ph=c_water_test$ph,production=cn_production_test$cheonan,K_ion=cn_rain_test$KionueqL,F_ion=cn_rain_test$FionueqL,NA_ion=cn_rain_test$NaionueqL)
#2017년도자료로  2018년도 구인필요인원을 예측함
pre<-predict(model_adjr2_cn_2002,newdata=predictframe)
pre

#실제 구인필요인원과 비교, 높을수록 좋다.
cor(pre, cnwork_2002$hired[13:24]) 


#회귀분석에 쓰이는 컬럼들을 오라클 디비에 저장. 
drv <- JDBC("oracle.jdbc.driver.OracleDriver","/root/ojdbc6.jar")
conn <- dbConnect(drv, "jdbc:oracle:thin:@//192.168.0.46:1521/xe", "fp", "1234")

#연관된 컬럼 데이터 생성
col_correlated_cn_1991_todb<-data.frame(col_correlated_cn_1991,ym=cnwork_1991$ym)
col_correlated_nj_1991_todb<-data.frame(col_correlated_nj_1991,ym=njwork_1991$ym)
col_correlated_cn_2002_todb<-data.frame(col_correlated_cn_2002,ym=cnwork_2002$ym)
col_correlated_nj_2002_todb<-data.frame(col_correlated_nj_2002,ym=njwork_2002$ym)

#이미 있는 테이블을 지우고
dbRemoveTable(conn, "col_correlated_cn_1991_todb")
dbRemoveTable(conn, "col_correlated_nj_1991_todb")
dbRemoveTable(conn, "col_correlated_cn_2002_todb")
dbRemoveTable(conn, "col_correlated_nj_2002_todb")
#새로만듬
dbWriteTable(conn,"col_correlated_cn_1991_todb",col_correlated_cn_1991_todb,   rownames=FALSE, overwrite = TRUE, append = FALSE)
dbWriteTable(conn,"col_correlated_nj_1991_todb",col_correlated_cn_1991_todb,   rownames=FALSE, overwrite = TRUE, append = FALSE)
dbWriteTable(conn,"col_correlated_cn_2002_todb",col_correlated_cn_1991_todb,   rownames=FALSE, overwrite = TRUE, append = FALSE)
dbWriteTable(conn,"col_correlated_nj_2002_todb",col_correlated_cn_1991_todb,   rownames=FALSE, overwrite = TRUE, append = FALSE)

#x,y Coeffients 자료 생성
coeffients_cn_1991<-t(data.frame(model_adjr2_cn_1991$coefficients))
colnames(coeffients_cn_1991)[1]="intercept"
coeffients_nj_1991<-t(data.frame(model_adjr2_nj_1991$coefficients))
colnames(coeffients_nj_1991)[1]="intercept"
coeffients_cn_2002<-t(data.frame(model_adjr2_cn_2002$coefficients))
colnames(coeffients_cn_2002)[1]="intercept"
coeffients_nj_2002<-t(data.frame(model_adjr2_nj_2002$coefficients))
colnames(coeffients_nj_2002)[1]="intercept"
#원래있던 테이블 삭제
dbRemoveTable(conn, "coeffients_cn_1991")
dbRemoveTable(conn, "coeffients_nj_1991")
dbRemoveTable(conn, "coeffients_cn_2002")
dbRemoveTable(conn, "coeffients_nj_2002")
#테이블 재생성.
dbWriteTable(conn,"coeffients_cn_1991",coeffients_cn_1991,   rownames=FALSE, overwrite = TRUE, append = FALSE)
dbWriteTable(conn,"coeffients_nj_1991",coeffients_nj_1991,   rownames=FALSE, overwrite = TRUE, append = FALSE)
dbWriteTable(conn,"coeffients_cn_2002",coeffients_cn_2002,   rownames=FALSE, overwrite = TRUE, append = FALSE)
dbWriteTable(conn,"coeffients_nj_2002",coeffients_nj_2002,   rownames=FALSE, overwrite = TRUE, append = FALSE)


#commit
dbCommit(conn)
#연결끊기.
dbDisconnect(conn)
