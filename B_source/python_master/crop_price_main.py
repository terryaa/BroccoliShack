import os,sys
sys.path.append(os.path.dirname(__file__))
from modules import connection as cn
from modules import apiurl as au
from modules.dataprocess import DataProcess
from bs4 import BeautifulSoup
import pandas as pd
import datetime

def main(end_year, period):
    api_url=au.crop_price_url(end_year, period,1,1)
    soup=cn.getSoup(api_url)
    dp=DataProcess()
    data=[]

    #item 안의 모든 자식을 해당 자식의 name:text 형태로 딕셔러니를 만든다
    #item 한개당 한개의 자식 딕셔너리 리스트를 원소로하는 리스트를 만들고
    #모든 item리스를 모아 data에저장한다.
    for item in soup.find_all("item"):
        row={}
        for ele in item:
            row.update({ele.name:ele.string.split(" ")[0].replace(",", "")})
        data.append(row)
    if len(data)!=0:
        dp.setDataList(data)
    else:
        print("no data to fetch!")
        
    # data process 하는곳
    df = pd.DataFrame(data)
    df = (df[1:df.shape[0]//2])
    df = df.drop([None,'regday','yearavg'],axis=1)
    year_list = list(df['yyyy'])
    print(year_list)
    df = df.set_index('yyyy').T
    df = [float(x) for t in range(len(df)) for x in df.iloc[t]]
    y_m= [str(y)+str(m).zfill(2) for y in range(int(year_list[0]),int(year_list[-1])+1) for m in range(1,13)]


    df=pd.DataFrame(df,index=y_m)
    df.columns = ["all_area"]
    df.to_csv("/home/hadoop/data/processed_data/price_data/processed_pear_price"+str(datetime.datetime.now()).split(".")[0].replace(":","-").replace(" ","")+".csv", float_format='%.f')

if __name__=='__main__':
    main(sys.argv[1],sys.argv[2])
