#!/usr/bin/env python
# coding: utf-8
import os,sys
sys.path.append(os.path.dirname(__file__))
from modules import connection as cn ,apiurl as au
from modules.dataprocess import DataProcess
from bs4 import BeautifulSoup
import math
import pandas as pd
import glob
import datetime

path = "/home/hadoop/data/processed_data/water_data/"

if(len(sys.argv)!=2):
    print("연도를 쓰시오")
    sys.exit()
year=sys.argv[1]
    
#지역정보를 가져옴
api_url=au.crop_kwater_url(1)
soup=cn.getSoup(api_url)
dp=DataProcess()
sido=[]
for item in soup.find_all("sido"):
    sido.append(item.text)
sido=['충남', '전남']
    
#지반종류 가져옴
api_url=au.crop_kwater_url(2)
soup=cn.getSoup(api_url)
wellnum=[]
for item in soup.find_all("code"):
    wellnum.append(item.text)

#년도 정보를 가져옴
#api_url=au.crop_kwater_url(4)
#soup=cn.getSoup(api_url)
#year=[]
#for item in soup.find_all("yyyy"):
#    year.append(item.text)
    
#상세 지역정보를 가져옴
api_url=au.crop_kwater_url(3,sido,wellnum)
jewon={}
for key, value in api_url.items():
    soup=cn.getSoup(key)
    for item in soup.find_all("wnumno"):
        wnumno=item.text
        jewon[wnumno]=value

#최종 지하수 정보       
api_url=au.crop_kwater_url(5,year,jewon)
data=[]
print(api_url)
dp=DataProcess()
for api_url1, do in api_url.items():
    soup=cn.getSoup(api_url1)
    for item in soup.find_all("item"):
        row={}
        for ele in item:
            row.update({ele.name:ele.text.split(" ")[0]})
            row.update({"do":do})
        data.append(row)
    if len(data)!=0:
        dp.setDataList(data)
    else:
        print("no data to fetch!")
    dp.writeToCsv()

#폴더에 있는 모든 주소를 불러옴
#df=pd.DataFrame(data)
file_list = glob.glob("/home/hadoop/data/raw_data/water_data/"
+"*")
file_list_csv = [file for file in file_list if file.endswith(".csv")]

#데이터를 하나로 만듬
df1=[]
for file_name in file_list_csv:
    df2=pd.read_csv(file_name, encoding='utf-8')
    df1.append(df2)
data=pd.concat(df1, ignore_index=True)
data=data.drop(data.columns[[0]], axis='columns')
data=data.drop_duplicates()

#컬럼을 만들어줌
data["year"]=data['testymd'].str[:4]
data["month"]=data['testymd'].str[5:7]
data["si"]=data['obsvname'].str[:2]

data['year_month']=data['year']+data['month']
data.set_index("year_month")
data1=data[data["si"]=='천안']
data2=data[data["si"]=='나주']
data1.set_index("watnum")
data2.set_index("watnum")
data2=data2.drop_duplicates(['year_month'], keep='first')
data1=data1.drop_duplicates(['year_month'], keep='first')
data1 = data1.sort_values(["year_month"], ascending=[False])
data2 = data2.sort_values(["year_month"], ascending=[False])

y_m_l=[str(x)+str(y).zfill(2)  for x in range(1990,2019) for y in range(1,13)]

for x in y_m_l:
    if x not in list(data1["year_month"]):
        data1.loc[x, 'year_month'] = x
    if x in list(data1["year_month"]):
        data1.loc[x] = data1[(data1["year_month"]==x)].values[0]   
        
data1=data1.drop_duplicates(['year_month'], keep='last')

for x in y_m_l:
    if x not in list(data2["year_month"]):
        data2.loc[x, 'year_month'] = x
    if x in list(data2["year_month"]):
        data2.loc[x] = data2[(data2["year_month"]==x)].values[0]   
        
data2=data2.drop_duplicates(['year_month'], keep='last')

#저장하기

data1.to_csv(path+"cheonan/water_data_cheonan"+str(datetime.datetime.now()).split(".")[0].replace(":","-")+".csv")
data2.to_csv(path+"naju/water_data_naju"+str(datetime.datetime.now()).split(".")[0].replace(":","-")+".csv")

