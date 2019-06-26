#!/usr/bin/env python
# coding: utf-8

# In[21]:
import sys,os
sys.path.append(os.path.dirname(__file__))

import pandas as pd 
from pandas import DataFrame
import numpy as np
from scipy.interpolate import interp1d
from module.Get_HDFS import get_data,save_data   
def get_12_sum(n): 
    list=[0]*7+[2.3,20.1,33,4.3,0]
    s=sum(list) 
    if n!="None" or n!=None or n!=np.NaN:
        cn= n/list[7]* s
        return cn
       
    else:
        return np.NaN
    
def sum_func(n0):
    sum_year = [0.0]*(len(n0)//12)
    k=0
    for i in range(8,len(n0),12):
        sum_year[k] = get_12_sum(n0[i])         
        k=k+1
    return sum_year
    
def get_12_list(n):
    list=[0]*7+[2.3,20.1,33,4.3,0]
    s=sum(list)
    return [n*x/s for x in list]

path1='/home/hadoop/data/processed_data/income_data/naju'
df_data_naju=get_data(path1)
path2='/home/hadoop/data/processed_data/income_data/cheonan'
df_data_cheonan=get_data(path2)


naju_data=df_data_naju["나주시/배/소득"]
dict_naju = {"나주시/배/소득":sum_func(naju_data)}
df_naju_year = pd.DataFrame(dict_naju)


naju_data=df_data_naju["나주시/배/조수입"]
df_naju_year["나주시/배/조수입"] = sum_func(naju_data)

naju_data=df_data_naju["나주시/배/경영비"]
df_naju_year["나주시/배/경영비"] = sum_func(naju_data)


df_naju_year=df_naju_year.interpolate(method='linear',limit_direction = 'backward' )
df_naju_year=df_naju_year.interpolate(method='linear',limit_direction = 'forward' )


cheonan_data=df_data_cheonan["천안시/배/소득"]
dict_cheonan = {"천안시/배/소득":sum_func(cheonan_data)}
df_cheonan_year = pd.DataFrame(dict_cheonan)

cheonan_data=df_data_cheonan["천안시/배/조수입"]
df_cheonan_year["천안시/배/조수입"] = sum_func(cheonan_data)

cheonan_data=df_data_cheonan["천안시/배/경영비"]
df_cheonan_year["천안시/배/경영비"] = sum_func(cheonan_data)

#df_cheonan_year  #연별 데이터 프레임을 만들었지요.

df_cheonan_year=df_cheonan_year.interpolate(method='linear',limit_direction = 'backward' )
df_cheonan_year=df_cheonan_year.interpolate(method='linear',limit_direction = 'forward' )

#display(df_cheonan_year)


income_naju=df_naju_year["나주시/배/소득"]

income_cheonan = df_cheonan_year["천안시/배/소득"]

grossIncome_naju=df_naju_year["나주시/배/조수입"]

operationExpense_naju=df_naju_year["나주시/배/경영비"]

grossIncome_cheonan = df_cheonan_year["천안시/배/조수입"]

operationExpense_cheonan = df_cheonan_year["천안시/배/경영비"]

year=[str(y) for y in range(1990,2019)]

year=[str(y)+str(x).zfill(2) for y in year[:] for x in range(1,13)]
income_cheonan=sum([get_12_list(float(str(x).replace(",","")))  for x in income_cheonan if x!="원"],[])
income_naju=sum([get_12_list(float(str(x).replace(",","")))  for x in income_naju if x!="원"],[])

grossIncome_cheonan=sum([get_12_list(float(str(x).replace(",","")))  for x in grossIncome_cheonan if x!="원"],[])

grossIncome_naju=sum([get_12_list(float(str(x).replace(",","")))  for x in grossIncome_naju if x!="원"],[])

operationExpense_cheonan=sum([get_12_list(float(str(x).replace(",","")))  for x in operationExpense_cheonan if x!="원"],[])

operationExpense_naju=sum([get_12_list(float(str(x).replace(",","")))  for x in operationExpense_naju if x!="원"],[])

dict_naju = {"ym":year,"naju.pear.income":income_naju,"naju.pear.grossIncome":grossIncome_naju,"naju.pear.operationExpense":operationExpense_naju}
dict_cheonan = {"ym":year,"cheonan.pear.income":income_cheonan,"cheonan.pear.grossIncome":grossIncome_cheonan,"cheonan.pear.operationExpense":operationExpense_cheonan}
df_data_cheonan= pd.DataFrame(dict_cheonan)
df_data_naju= pd.DataFrame(dict_naju )

path3='/home/hadoop/data/more_processed_data/income_data/naju'
save_data(path3,df_data_naju)
#df_data_naju.to_csv('/home/hadoop/data/more_processed_data/parksr/naju/1990_2018_Monthly_naju_income_incomeRate_grossIncome_operationExpense2.csv',sep=',',encoding="UTF-8",index=False)  

path4='/home/hadoop/data/more_processed_data/income_data/cheonan'
save_data(path4,df_data_cheonan)
#df_data_cheonan.to_csv('/home/hadoop/data/more_processed_data/parksr/cheonan/1990_2018_Monthly_cheonan_income_incomeRate_grossIncome_operationExpense2.csv',sep=',',encoding="UTF-8",index=False)  

