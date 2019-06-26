#!/usr/bin/env python
# coding: utf-8
import os,sys
sys.path.append(os.path.dirname(__file__))

import pandas as pd
import numpy as np
import datetime
from module.Get_HDFS import get_data,save_data
#폴더에 있는 모든 주소를 불러옴
path = "/home/hadoop/data/processed_data/water_data"
path1= "/home/hadoop/data/more_processed_data/water_data"

#데이터를 하나로 만듬
data1=get_data(path+"/cheonan")
#폴더에 있는 모든 주소를 불러옴


#데이터를 하나로 만듬
data2=get_data(path+"/naju")
#data1.set_index("year_month",inplace=True)
#data2.set_index("year_month",inplace=True)

data_columns=data1.columns
colum=['bac', 'cl', 'no3n', 'ph','year_month']

for dcol in data_columns:
    if dcol not in colum:
        data1=data1.drop([dcol], axis=1)
data1=data1.interpolate(method ='linear', limit_direction ='forward') 
data1=data1.interpolate(method ='linear', limit_direction ='backward') 

colum.remove('year_month') # 따로 year_month를 인덱스 안하고 인터폴레이션 안하기
si=int(len(data1))
for dc in colum:
    max_d=int(data1[dc].max())
    min_d=int(data1[dc].min())
    m_m=(max_d-min_d)/100
    random1=(np.random.rand(si)*2-1)*m_m
    data1[dc]=data1[dc]-random1
    data1[dc][data1[dc]<=0]=0

data1=data1.reindex(range(len(data1.index)+1))
for i in range(len(data1.index)-1):
    data1.iloc[i]=data1.iloc[i+1]
data1=data1[:-1]
data1.rename(columns={'year_month': 'ym'}, inplace=True)
data1['ym']=data1['ym'].astype('object')
#저장하기
save_data(path1+"/cheonan",data1)
#data1.to_csv(path1+"naju/water_data2"+str(datetime.datetime.now()).split(".")[0].replace(":","-")+".csv")     

colum=['bac', 'cl', 'no3n', 'ph','year_month']
for dcol in data_columns:
    if dcol not in colum:
        data2=data2.drop([dcol], axis=1)
        
data2=data2.interpolate(method ='linear', limit_direction ='forward') 
data2=data2.interpolate(method ='linear', limit_direction ='backward') 

colum.remove('year_month') # 따로 year_month를 인덱스 안하고 인터폴레이션 안하기
si=int(len(data2))
for dc in colum:
    max_d=int(data2[dc].max())
    min_d=int(data2[dc].min())
    m_m=(max_d-min_d)/100
    random1=(np.random.rand(si)*2-1)*m_m
    data2[dc]=data2[dc]-random1
    data2[dc][data2[dc]<=0]=0
data2=data2.reindex(range(len(data2.index)+1))
for i in range(len(data2.index)-1):
    data2.iloc[i]=data2.iloc[i+1]
data2=data2[:-1]
data2.rename(columns={'year_month': 'ym'}, inplace=True)
data2['ym']=data2['ym'].astype('object')
#저장하기
save_data(path1+"/naju",data2)
#data2.to_csv(path1+"cheonan/water_data2"+str(datetime.datetime.now()).split(".")[0].replace(":","-")+".csv")   

