import os,sys
sys.path.append(os.path.dirname(__file__))
import pandas as pd
from module.Get_HDFS import get_data,save_processed_data
#path="/home/hadoop/data/raw_data/month_workingtime_data"
#month_list=get_data(path)
#month_list=pd.read_csv("C:\\Users\\kosta\\Desktop\\month_worktime.csv",encoding="EUC-KR")
#print(month_list)
#l=[month_list[1:-1]["sum"][y*3:y*3+3].sum() for y in range(len(month_list[1:-1]["sum"])//3)]
l=[22.7,22.9,18.3,16.5,59.8,61.8,16.8,14.5,39.9,65.4,22.1,9.8]
def get_12_list(n):
    list=l
    s=sum(list)
    return [n*x/s for x in list]
path="/home/hadoop/data/processed_data/workingtime_data/naju"
dist=get_data(path)
dist.year=dist.year.astype('float64')
#dist=pd.read_csv("C:\\Users\\kosta\\Desktop\\j_dist_workingtime.csv")[12:].drop_duplicates()
path="/home/hadoop/data/processed_data/workingtime_data/cheonan"
dist2=get_data(path)
dist2.year=dist2.year.astype('float64')
#dist2=pd.read_csv("C:\\Users\\kosta\\Desktop\\ch_dist_workingtime.csv")[12:].drop_duplicates()
path="/home/hadoop/data/processed_data/area_farm/naju"
df=get_data(path)
df.year=df.year.astype('float64')
path="/home/hadoop/data/processed_data/area_farm/cheonan"
df1=get_data(path)
df1.year=df1.year.astype('float64')
#df=pd.read_csv("C:\\Users\\kosta\\Desktop\\area2019.csv")
max=int(dist.tail(1)['year'])  if(int(dist.tail(1)['year'])<int(df.tail(1)['year'])) else int(df.tail(1)['year'])


df=df[df.year<=max]
df=df[df.year>=1990]
df1=df1[df1.year<=max]
df1=df1[df1.year>=1990]
dist=dist[dist.year<=max]
dist=dist[dist.year>=1990]
dist2=dist2[dist2.year<=max]
dist2=dist2[dist2.year>=1990]

df = df.sort_values(["year"])
df1 = df1.sort_values(["year"])
dist = dist.sort_values(["year"])
dist2 = dist2.sort_values(["year"])

df=df.drop_duplicates(['year'])
df1=df1.drop_duplicates(['year'])
dist=dist.drop_duplicates(['year'])
dist2=dist2.drop_duplicates(['year'])
df=df.set_index("year")
df1=df1.set_index("year")
dist=dist.set_index("year")
dist2=dist2.set_index("year")
col=dist.columns

dis=dist.mul(df.clt_area,axis=0)
dis=dis.interpolate()
print(dis)
dis2=dist2.mul(df1.clt_area,axis=0)
dis2=dis2.interpolate()
print(dis2)
y_m=[str(y).replace(".0","")+str(m).zfill(2) for y in dis.index for m in range(1,13)]
dis_x=sum([get_12_list(d) for d in dis['hired_labor_expense']],[])
dis_y=sum([get_12_list(d) for d in dis['self_labor_expense']],[])
dis2_x=sum([get_12_list(d) for d in dis2['hired_labor_expense']],[])
dis2_y=sum([get_12_list(d) for d in dis2['self_labor_expense']],[])
dis3=pd.DataFrame(list(zip(dis_x,dis_y)),index=y_m,columns=col).reset_index()
dis4=pd.DataFrame(list(zip(dis2_x,dis2_y)),index=y_m,columns=col).reset_index()
dis3=dis3.rename(columns={'index':'ym'})
dis4=dis4.rename(columns={'index':'ym'})
#save_data(path,dis3)
path="/home/hadoop/data/processed_data/month_workingtime_data/naju"
save_processed_data(path,dis3)
path="/home/hadoop/data/processed_data/month_workingtime_data/cheonan"
save_processed_data(path,dis4)
#dis3.to_csv("C:\\Users\\kosta\\Desktop\\naju_workingtime.csv")
#dis4.to_csv("C:\\Users\\kosta\\Desktop\\cheonan_workingtime.csv")
