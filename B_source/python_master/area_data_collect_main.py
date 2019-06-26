import datetime
import math
import pandas as pd
import os
citylist=['천안시','나주시']
bigcitylist=['대전광역시','세종특별자치시']
districtdict={'천안시':'충청남도','나주시':'전라남도'}

ratiolist=[]

def appendFrame(before,after,frame,district,df2):
    sido=df2[(df2.시도별==district)& (df2.항목=="배:면적")][str(int(before.year))+" 년"]
    sido2=df2[(df2.시도별==district)& (df2.항목=="배:면적")][str(int(after.year))+" 년"]
    if (math.isnan(sido)) or (math.isnan(sido2)):
        lf=linearFunction()
        #print(type(lf))
        lf.setTwoPoints(before.year,before.clt_area,after.year,after.clt_area)
        for i in range(int(after.year-before.year)-1):
            year=before.year+1+i
            area=lf.returnResult(year)
            #print(area,year)
            dict1={'year':[year],'clt_area':[area],'fs_gb':'배','sgg':before.sgg,'sido':district}
            frame=frame.append(pd.DataFrame(dict1))
    else:
        ratio=  ( (before.clt_area/sido)+ (after.clt_area/sido2) )  /2
        ratio=float(ratio.values)
        ratiodata={"ratio":ratio,"year_before":before.year,"year_after":after.year,"city":before.sgg}
        ratiolist.append(ratiodata)
        
        if after.year==2018:
            after.year=2019
        for i in range(int(after.year-before.year)-1):
            year=before.year+1+i
            area=df2[(df2.시도별==district)& (df2.항목=="배:면적")][str(int(year))+" 년"]*ratio
            dict1={'year':[year],'clt_area':[area.iat[0]],'fs_gb':'배','sgg':before.sgg,'sido':district}
            frame=frame.append(pd.DataFrame(dict1))
    return frame


def initFrame(city,df):
    if city in citylist:
        frame=df[(df.sgg == city) & (df.fs_nm == '전체')][['year','clt_area','sgg','sido','fs_gb']]
        district=districtdict.get(city)
    else :
        frame=df[(df.sido == city) & (df.fs_nm == '전체')][['year','clt_area','sgg','sido','fs_gb']]
        district=city
    return frame,district

def makeData(city,df,df2):
    frame,district=initFrame(city,df)
    rep=len(frame.index)
    for idx in range(rep):
        before=frame.iloc[idx]
        if idx==(rep-1):
            after=frame.iloc[idx]
            after.year=2018
        else:
            after=frame.iloc[idx+1]
        frame=appendFrame(before,after,frame,district,df2)
    return frame

def readDistrictData(district,df2):
    frame=pd.DataFrame()
    for year in range(1980,2019) :
        sido2=df2[(df2.시도별==district)& (df2.항목=="배:면적")][str(year)+" 년"]
        dict1={'year':[year],'clt_area':sido2,'fs_gb':'배','sgg':"전체",'sido':district}
        if sido2.empty:
            dict1.update({'clt_area':'0'})
        frame=frame.append(pd.DataFrame(dict1))
    return frame
                  
def main():
    folder1="/home/hadoop/data/raw_data/farm_area/"
    folder2="/home/hadoop/data/raw_data/area_gain/"
    dirlist=os.listdir(folder1)
    dirlist2=os.listdir(folder2)

    if len(dirlist)==0 or len(dirlist2)==0:
        print("No files in this directory")
    else:
        dirlist.sort()
        dirlist2.sort()
        #print(dirlist[0])
        df=pd.read_csv(folder1+dirlist[len(dirlist)-1],encoding="euc-kr")
        #/home/hadoop/data/raw_data/farm_data/
        df2=pd.read_csv(folder2+dirlist2[len(dirlist2)-1],encoding="euc-kr")

        #/home/hadoop/data/raw_data/area_gain/
        framenaju=makeData('나주시',df,df2)
        framecheonan=makeData('천안시',df,df2)
        framecheonan.to_csv("/home/hadoop/data/processed_data/area_farm/cheonan/Area_Farm_Cheonan"+str(datetime.datetime.now()).split(".")[0].replace(":","-").replace(" ","")+".csv")
        framenaju.to_csv("/home/hadoop/data/processed_data/area_farm/naju/Area_Farm_Naju"+str(datetime.datetime.now()).split(".")[0].replace(":","-").replace(" ","")+".csv")
if __name__=="__main__":
    main()
    
