from module.hdfs_dir_list import get_hdfs_list as ghl
from pyspark.sql import SparkSession
import pandas as pd
import numpy as np
def get_data(path):
    data_list=[]
    data_s=ghl(path)
    ss=SparkSession.builder.appName("get_data").getOrCreate()
    for d in data_s:
        p=str(d)[1:].replace("'",'')
        if p[p.rfind('/')+1]!="_":
            df_load=ss.read.csv("hdfs://master:9000"+p)
            df=df_load.toPandas()
            data_list.append(df)
    
    data=pd.concat(data_list,ignore_index=True)
    #data=data.drop(data.columns[[0]], axis='columns')
    data=data.drop_duplicates()
    data.columns=data.iloc[0]
    data.replace({'None':np.NaN,None:np.NaN})
    data=data[1:]
    for x in data.columns[1:]:
        data[x]=data[x].astype('float64',errors='ignore')
    data=data.reindex(range(1,len(data.index)+1))
    return data
def save_data(path,df): 
    print(df)    
    #df=df.reindex(range(1,len(df.index)+1))
    ss=SparkSession.builder.appName("save_data").getOrCreate()
    df=push_year(df)
    df_sp=ss.createDataFrame(df)
    df_sp.write.csv("hdfs://master:9000"+path,mode="append",header=True)
    print("saved")
def save_processed_data(path,df): 
    print(df)    
    #df=df.reindex(range(1,len(df.index)+1))
    ss=SparkSession.builder.appName("save_data").getOrCreate()
    df_sp=ss.createDataFrame(df)
    df_sp.write.csv("hdfs://master:9000"+path,mode="append",header=True)
    print("saved")


def push_year(frame):
    #frame['ym']=frame['ym'].astype('int64')
    last_year=(int(frame.tail(1)['ym'])//100)+1
    newyear_month=[str(last_year)+"0"+str(i) if i<10 else str(last_year)+str(i) for i in range(1,13)]
    last_index=frame.tail(1).index.values.astype(int)[0]+1
    frame_noym=frame.loc[:,frame.columns != 'ym']
    print(last_index)
    frame_noym_new=frame_noym.iloc[last_index-12:last_index]
    frame_noym_old=frame_noym.iloc[:last_index-12]
    frame_noym_old['ym']=frame['ym'][12:].reset_index()['ym']
    frame_noym_new['ym']=pd.Series(newyear_month,index=frame_noym_new.index)
    old_month=frame['ym'][:12]
    old_month=[ {'ym':item} for item in old_month]
    old_month_frame= pd.DataFrame(old_month)
    frame=frame_noym_old.append(frame_noym_new)
    result=old_month_frame.append(frame)
    result.drop(result.columns[result.columns.str.contains('unnamed',case = False)],axis = 1, inplace = True)
    print(result)
    result['ym']=result['ym'].astype('float64')
    result=result.sort_values(['ym'],ascending=[True])
    return result
