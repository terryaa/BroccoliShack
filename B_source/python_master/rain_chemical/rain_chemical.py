#!/usr/bin/env python
# coding: utf-8

# In[49]:


import glob
import pandas as pd
import numpy as np
import datetime
import pandas
#폴더에 있는 모든 주소를 불러옴
#path = "C:\\Users\\kosta\\Desktop\\rain_chemical\\"
path = "/home/hadoop/data/raw_data/rain_data/"
file_list = glob.glob(path+"*")
file_list_csv = [file for file in file_list if file.endswith(".csv")]

#데이터를 하나로 만듬
df1=[]
for file_name in file_list_csv:
    df2=pd.read_csv(file_name, encoding='EUC-KR')
    df1.append(df2)
data1=pd.concat(df1, ignore_index=True)

data1['year_month']=data1['일시'].str[:4]+data1['일시'].str[5:7]

col=[x[:-12] for x in data1.columns if("(micro eq/L)" in x)]
for x in col:
    data1[x+"(micro eq/L)"] = np.where(pd.notnull(data1[x+"(micro eq/L)"]) == True, data1[x+"(micro eq/L)"], data1[x+"(μeq/L)"])
for x in col:
    del data1[x+"(μeq/L)"]

dt_index = pandas.date_range(start='19970101', end='20171231')
dt_list = dt_index.strftime("%Y-%m-%d").tolist()

for x in dt_list:
    if x not in list(data1["일시"]):
        data1.loc[x, '일시'] = x  
data1 = data1.sort_values(["일시"], ascending=[True])

data1=data1.interpolate(method ='linear', limit_direction ='forward') 
data1=data1.interpolate(method ='linear', limit_direction ='backward') 


data2=data1.groupby(['year_month'], as_index=False).mean()
#data2=data2.drop(['지점'], axis=1)
y_m_l=[str(x)+str(y).zfill(2)  for x in range(1990,2019) for y in range(1,13)]

for x in y_m_l:
    if x not in list(data2["year_month"]):
        data2.loc[x, 'year_month'] = x  
        
data2 = data2.sort_values(["year_month"], ascending=[True])



data2=data2.interpolate(method ='linear', limit_direction ='forward') 
data2=data2.interpolate(method ='linear', limit_direction ='backward') 

print(data2.columns)      

si=int(len(data2))
for dc in data2.columns:
    if dc != 'year_month':
        max_d=int(data2[dc].max())
        min_d=int(data2[dc].min())
        m_m=(max_d-min_d)/100
        random1=(np.random.rand(si)*2-1)*m_m
        data2[dc]=data2[dc]-random1
        data2[dc][data2[dc]<=0]=0
data2 = data2.rename(columns = {'year_month': 'ym'})
data2.to_csv("/home/hadoop/data/processed_data/rain_data/cheonan/"+str(datetime.datetime.now()).split(".")[0].replace(":","-")+".csv" , index=False)
data2.to_csv("/home/hadoop/data/processed_data/rain_data/naju/"+str(datetime.datetime.now()).split(".")[0].replace(":","-")+".csv" , index=False)
    

