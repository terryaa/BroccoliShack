import os
import numpy as np
import re
#2014-2017년 고용시간 csv 데이터 -> data1
#1990-2013년 고용시간 csv 데이터 -> data2
import pandas as pd
path = "/home/hadoop/data/raw_data/workingtime_data/"
file_list=sorted(os.listdir(path))


data1=pd.read_csv(path+file_list[0], engine='python',encoding='euc-kr')
data1=data1.dropna()
data1=data1.rename(columns={'hired labor expense':'hired_labor_expense','self labor expense':'self_labor_expense'})
#data2 데이터들에서 하나씩 고용시간과 자가 노동시간만 추출하여 
#새로운 dataframe data3에 append
clist1=["year","district","hired_labor_expense","self_labor_expense"] #column리스트

data3_year=[]
data3_dist=[]
data3_hired=[]
data3_self=[]

for x in file_list[1:10]:
    #print(x)
    xlist=x.split('_')
    #csv  파일 컬럼명 리스트
    
    data2=pd.read_csv(path+x, engine='python')
    clist=[x for x in range(len(data2.columns))]
    data2.columns=clist
    #고용시간(고용노동비)
    time1=re.findall('[0-9.]+',data2[6][49])[0]
    #자가 노동시간(자가노동비)
    time2=re.findall('[0-9.]+',data2[6][52])[0]
    #data3만들기
    data3_year.append(xlist[0])
    data3_dist.append(xlist[1])
    data3_hired.append(time1)
    data3_self.append(time2)
for x in file_list[11:]:
    xlist=x.split('_')
    
    data2=pd.read_csv(path+x, engine='python')
    clist=[x for x in range(len(data2.columns))]
    data2.columns=clist
    #고용시간(고용노동비)
    time1=data2[5][41]
    #자가 노동시간(자가노동비)
    time2=data2[5][45]
    #print(time1,time2)
    data3_year.append(xlist[0])
    data3_dist.append(xlist[1])
    data3_hired.append(time1)
    data3_self.append(time2)

    
# data3=pd.DataFrame("years":data3_year)
dictdata={"year":data3_year,"district":data3_dist, "hired_labor_expense":data3_hired,"self_labor_expense":data3_self}
data3=pd.DataFrame(dictdata)

data1=data1.append(data3)
data1.dropna()

#data1.to_csv("./testtest.csv",encoding='euc-kr')
#data1.sort_values(by='year',inplace=True)
data1.year = data1.year.astype(np.int64)
data1.sort_values(by='year',inplace=True)
#충청남도를 충남으로 전라남도를 전남으로 바꿈
data1=data1.replace({'district': '전라남도'}, {'district': '전남'}).replace({'district':'충청남도'}, {'district':"충남"})
#district 별로 csv 따로 저장하기
chdata=data1[data1.district=='충남'].loc[:, ["year", "hired_labor_expense","self_labor_expense"]].set_index("year")
chdata.to_csv("/home/hadoop/data/processed_data/workingtime_data/cheonan/ch_dist_workingtime.csv",encoding='UTF-8')
chdata=data1[data1.district=='전남'].loc[:, ["year", "hired_labor_expense","self_labor_expense"]].set_index("year")
chdata.to_csv("/home/hadoop/data/processed_data/workingtime_data/naju/j_dist_workingtime.csv",encoding='UTF-8')

