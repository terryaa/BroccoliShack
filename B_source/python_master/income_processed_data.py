#!/usr/bin/env python
# coding: utf-8

# In[38]:

import os
import pandas as pd 
from pandas import DataFrame
import numpy as np
from scipy.interpolate import interp1d


def get_12_list(n):
    if n == 'NaN':
        return [np.NaN]*12
    else:
        list=[0]*7+[2.3,20.1,33,4.3,0]
        s=sum(list)
        return [n*x/s for x in list]

def nan_add(d):
    d1 = d[1:20]
    d2 =d[20:]
    na1 = pd.Series([np.NaN],dtype=object)
    d1=d1.append(na1,ignore_index = True)
    na2 = pd.Series([np.NaN for x in range(len(range(2010,2019))-len(d2))],dtype=object)
    d2 = d2.append(na2,ignore_index=True)    
    d1 = d1.append(d2)   
    d1 = d1.reset_index(drop=True)
    return d1
    

path = "/home/hadoop/data/raw_data/income_data/"
file_list=os.listdir(path)
file_list.sort()
data = pd.read_excel(path+file_list[0],'소득정보(농촌진흥청)(스프레드시트)')
data1 = pd.DataFrame(data)
data = pd.read_excel(path+file_list[1],'소득정보(농촌진흥청)(스프레드시트)')
data2 = pd.DataFrame(data)

income_naju=data1["나주시/배/소득"]
income_naju=nan_add(income_naju)

income_cheonan = data1["천안시/배/소득"]
income_cheonan=nan_add(income_cheonan)

grossIncome_naju=data1["나주시/배/조수입"]
grossIncome_naju=nan_add(grossIncome_naju)

operationExpense_naju=data2["나주시/배/경영비"]
operationExpense_naju=nan_add(operationExpense_naju)

grossIncome_cheonan = data1["천안시/배/조수입"]
grossIncome_cheonan=nan_add(grossIncome_cheonan)

operationExpense_cheonan = data2["천안시/배/경영비"]
operationExpense_cheonan=nan_add(operationExpense_cheonan)

year=[str(y) for y in range(1990,2019)]

year=[str(y)+str(x).zfill(2) for y in year[:] for x in range(1,13)]
income_cheonan=sum([get_12_list(float(str(x).replace(",","")))  for x in income_cheonan if x!="원"],[])
income_naju=sum([get_12_list(float(str(x).replace(",","")))  for x in income_naju if x!="원"],[])
grossIncome_cheonan=sum([get_12_list(float(str(x).replace(",","")))  for x in grossIncome_cheonan if x!="원"],[])
grossIncome_naju=sum([get_12_list(float(str(x).replace(",","")))  for x in grossIncome_naju if x!="원"],[])
operationExpense_cheonan=sum([get_12_list(float(str(x).replace(",","")))  for x in operationExpense_cheonan if x!="원"],[])
operationExpense_naju=sum([get_12_list(float(str(x).replace(",","")))  for x in operationExpense_naju if x!="원"],[])

dict_naju = {"조회일자":year,"나주시/배/소득":income_naju,"나주시/배/조수입":grossIncome_naju,"나주시/배/경영비":operationExpense_naju}
dict_cheonan = {"조회일자":year,"천안시/배/소득":income_cheonan,"천안시/배/조수입":grossIncome_cheonan,"천안시/배/경영비":operationExpense_cheonan}

df_data_cheonan= pd.DataFrame(dict_cheonan)
df_data_naju= pd.DataFrame(dict_naju )

df_data_naju.to_csv('/home/hadoop/data/processed_data/income_data/naju/1990_2018_Monthly_naju_income_incomeRate_grossIncome_operationExpense.csv',sep=',',encoding="UTF-8",index=False)  

df_data_cheonan.to_csv('/home/hadoop/data/processed_data/income_data/cheonan/1990_2018_Monthly_cheonan_income_incomeRate_grossIncome_operationExpense.csv',sep=',',encoding="UTF-8",index=False)  

