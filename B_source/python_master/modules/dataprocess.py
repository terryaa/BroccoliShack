import datetime
import pandas as pd

class DataProcess():
    def __init__(self):
        self.dataList=[]
    def setDataList(self,data):
        self.dataList=data 
    def printDataList(self):
        print(self.dataList)
    def writeToCsv(self,name='result'):
        df=pd.DataFrame(self.dataList)
        #경로 리눅스에 맞게 수정.
        df.interpolate(inplace=True,method="linear",limit_direction="bacward")
        name="/home/hadoop/data/"+name+str(datetime.datetime.now()).split(".")[0].replace(":","-").replace(" ","")+".csv"
        df.to_csv(name)
        return name
        #df
