import os,sys
sys.path.append(os.path.dirname(__file__))
import pandas as pd
from module.Get_HDFS import get_data,save_data,save_processed_data
#1990_01 -> 199001 형식으로 바꿔주는 함수
def splitData(x):
    ym=x.split("_")
    x=int(ym[0]+ym[1])
    return x

#월별 row를 저장하는 함수 (월이 12 단위로 증가하므로 인덱스 활용)
def extractMonth(month):
    frame=pd.DataFrame()
    for i in range(29):
        row=df.iloc[12*i+(month-1)]
        frame=frame.append(row)
    return frame

# 원본 파일중에 최신파일을 찾아서 그 파일을 가져온다. 
#filelist=[]
#filenames = os.listdir("/home/hadoop/data/processed_data/price_data/")
#for filename in filenames:
#    ext = os.path.splitext(filename)[-1]
#    if ext == '.csv':
#        filelist.append(filename)
#csv_file_name = sorted(filelist)[-1]
#csv_file_name = "/home/hadoop/data/processed_data/price_data/"+csv_file_name

#나주 노동시간 데이터
path="/home/hadoop/data/processed_data/month_workingtime_data/naju"
df1=get_data(path)
#df1=pd.read_csv("/home/hadoop/data/processed_data/month_workingtime_data/naju/naju_workingtime.csv")
#천안 노동시간 데이터
path="/home/hadoop/data/processed_data/month_workingtime_data/cheonan"
df2=get_data(path)
#df2=pd.read_csv("/home/hadoop/data/processed_data/month_workingtime_data/cheonan/cheonan_workingtime.csv")
#농산물 가격 데이터
#crop=pd.read_csv(csv_file_name, encoding='euc-kr')
path="/home/hadoop/data/processed_data/price_data"
crop=get_data(path)
#컬럼명 지정하기
df1.columns=["ym","hired","self"]
df2.columns=["ym","hired","self"]
crop.columns=["ym","price"]
#형식 맞춰주기
#df1['ym']=df1['ym'].apply(splitData)
#df2['ym']=df2['ym'].apply(splitData)
#crop['ym']=crop['ym'].apply(splitData)
#분석을 위해 나주,천안 노동시간과 농산물 가격 데이터프레임 합치기 
df1=pd.merge(df1,crop,on="ym",how="outer")
df2=pd.merge(df2,crop,on="ym",how="outer")

#결측치가 있기 때문에 interpolate로 데이터 보간
#월별로 농산물 가격의 패턴이 존재하기 때문에 시계열로 채우기보다는
#월별로 row를 뽑아 데이터를 보간한 후 합치는 과정 필요함

#1.나주+농산물 가격 데이터 프레임 전처리하기
df = pd.DataFrame({"ym":df1.ym, "self":df1.self,"hired":df1.hired,"price":df1.price})
#빈 데이터 프레임
year=pd.DataFrame()

for i in range(12):
    mon=extractMonth(i+1)
    mon=mon.interpolate(method ='linear', axis=0, limit_direction ='forward')
    mon=mon.interpolate(method ='linear', axis=0,limit_direction ='backward')
    year=year.append(mon)

d_data=year[['hired','self','ym']].sort_values(by=['ym'])
path="/home/hadoop/data/more_processed_data/month_workingtime_data/naju"
save_processed_data(path,d_data)
#월별로 정렬된 데이터 시간순으로 맞추기
#독립변수만 남기기 위해 self, hired 컬럼 drop
year=year.sort_index().drop(['self','hired'], axis=1)
#전처리한 데이터 저장
#year.to_csv("/home/hadoop/data/more_processed_data/priace_data/naju/more_nj_price.csv",encoding='euc-kr')
path="/home/hadoop/data/more_processed_data/price_data/naju"
save_data(path,year)
#2. 천안도 똑같이 반복
df = pd.DataFrame({"ym":df2.ym, "self": df2.self, "hired":df2.hired,"price":df2.price})

def extractMonth(month):
    frame=pd.DataFrame()
    for i in range(29):
        row=df.iloc[12*i+(month-1)]
        frame=frame.append(row)
    return frame

year=pd.DataFrame()
for i in range(12):
    mon=extractMonth(i+1)
    mon=mon.interpolate(method ='linear', axis=0, limit_direction ='forward')
    mon=mon.interpolate(method ='linear', axis=0,limit_direction ='backward')
    year=year.append(mon)
 
d_data=year[['hired','self','ym']].sort_values(by=['ym'])
path="/home/hadoop/data/more_processed_data/month_workingtime_data/cheonan"
save_processed_data(path,d_data)
   
year=year.sort_index().sort_index().drop(['self','hired'], axis=1)

path="/home/hadoop/data/more_processed_data/price_data/cheonan"
save_data(path,year)
#year.to_csv("/home/hadoop/data/more_processed_data/price_data/cheonan/more_ch_price.csv",encoding='euc-kr')
