import datetime
import pandas as pd

class DataProcess():
    def __init__(self):
        self.dataList=[]
    def setDataList(self,data):
        self.dataList=data 
    def printDataList(self):
        print(self.dataList)
    def writeToCsv(self,name='farm_area'):
        df=pd.DataFrame(self.dataList)
        #경로 리눅스에 맞게 수정.
        df.to_csv("/home/hadoop/data/raw_data/farm_area/farm_area"+name+str(datetime.datetime.now()).split(".")[0].replace(":","-")+".csv",encoding="euc-kr")

        #df
