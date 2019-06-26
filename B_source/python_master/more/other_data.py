import os,sys
sys.path.append(os.path.dirname(__file__))
from module.Get_HDFS import get_data, save_data

def get_data_path(p):
    return "/home/hadoop/data/processed_data/"+p
def save_data_path(p):
    return "/home/hadoop/data/more_processed_data/"+p
#비 데이터 more에 넣기
r="rain_data"
path1=get_data_path(r)
spath1=save_data_path(r)
#기상 데이터 more에 넣기
w="weather_data"
path2=get_data_path(w)
spath2=save_data_path(w)
#생산량 데이터 more에 넣기
p="pear_production"
path3=get_data_path(p)
spath3=save_data_path(p)

gp=[path1,path2,path3]
sp=[spath1,spath2,spath3]
#천안,나주 나눠서 저장
path=zip(gp,sp)
area=['cheonan','naju']
def set_index(data):
    data=data.reindex(range(len(data.index)+1))
    for i in range(len(data.index)-1):
        data.iloc[i]=data.iloc[i+1]
    data=data[:-1]
    return data
for gp,sp in path:
    for a in area:
        if w in gp:
            l=['ym','mnhavgrhm','mnhavgta','mnhavgws','mnhmaxta','mnhminrhm','mnhminta','mnhsumrn','mnhsumss']
            data=get_data(gp+"/"+a)
            if a=="cheonan":
                data=data[l]
            else :
                data=data[l[:-1]]
            save_data(sp+"/"+a,set_index(data))
        elif p in gp:
            data=get_data(gp+"/"+a)
            data.rename(columns={None:"ym"}, inplace = True) #False이면 아무변화 없음
            save_data(sp+"/"+a,set_index(data))
        else:
	
            data=get_data(gp+"/"+a)
            temp=[]
            for t in data.columns:
                temp.append(t.replace("이온농도","ion").replace("강수량","precipitation").replace("산성도","acidity").replace("전기전도도","electrical_conductivity"))
            data.columns=temp
            save_data(sp+"/"+a,set_index(data))
