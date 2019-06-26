import os,sys
sys.path.append(os.path.dirname(__file__))
from modules import connection as cn ,apiurl as au
from modules.dataprocess import DataProcess
from bs4 import BeautifulSoup
import math


def main():
    api_url=au.farm_area()
    soup=cn.getSoup(api_url+"1")
    dp=DataProcess()

    data=[]
    pagenum=0
    for pagenum in range(601):
        pagenum+=1
        soup=cn.getSoup(api_url+str(pagenum))
        for item in soup.find_all("model"):
            row={}
            for ele in item:
                row.update({ele.name:ele.text.split(" ")[0]})
            data.append(row)
        
    if len(data)!=0:
        dp.setDataList(data)
    else:
        print("no data to fetch!")
    dp.writeToCsv()
    

if __name__=='__main__':
    main()
