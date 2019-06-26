#-*-coding:utf-8-*-
import sys,os
sys.path.append(os.path.dirname(__file__))
import pandas as pd
import datetime
from modules import yeartomonth as ym

def main():

    # 원본 파일중에 최신파일을 찾아서 그 파일을 가져온다. 
    filelist=[]
    filenames = os.listdir("/home/hadoop/data/raw_data/area_gain/")
    for filename in filenames:
        ext = os.path.splitext(filename)[-1]
        if ext == '.csv': 
            filelist.append(filename)
    csv_file_name = sorted(filelist)[-1]
        
    csv_file_name = "/home/hadoop/data/raw_data/area_gain/"+csv_file_name

    data = pd.read_csv(csv_file_name, encoding='euc-kr')

#1) "배:면적" 찾으면:0 , 아니면:-1
    search = data.loc[: , "항목"].str.find("배:면적")
    pearArea=[]
    item=['계','세종특별자치시','충청남도','전라남도']

    for i in range(len(search)):
        if search[i] != -1 and data["시도별"][i] in item: 
                # search[i] !=-1 : 배:면적을 가진 인덱스라는 것 
                # data["시도별"][i] in item: data["시도별"][i]이 4개 안에 들어가 있으면 
                # 2) data.loc[i:i+2].fillna(0)) : 행을 가져오는데 nan이 있으면 0을 넣는다.
            pearArea.append(data.loc[i+2:i+2, :].fillna(0))

#2) 충청남도 = 세종 (pearArea[1]) + 충청남도 (pearArea[2])
    # [(DataFrame)] : list 안에 값은 DataFrame 형태이다. 

    pearArea[1].loc[:,"1980 년":] #세종시 정보 1980부터 2018
    pearArea[2].loc[:,"1980 년":] #충청남도 정보 1980부터 2018
    # 더하려는 index 값을 같게 해두어서 계산이 가능하도록 설정
    pearArea[1].index=["충청남도"]
    pearArea[2].index=["충청남도"]
    # 계산
    pearArea[2].loc[:,"1980 년":] = pearArea[1].loc[:,"1980 년":] + pearArea[2].loc[:,"1980 년":]

    # index 값 정리
    pearArea[0].index = ["전국"]
    pearArea[3].index = ["전라남도"]

#3) 최종결과 데이터 프레임 만들기 - [전국, 충남, 전남]
    result = pearArea[0].append(pearArea[2]).append(pearArea[3]).loc[:,"1990 년":].T

#4) 도별 연도별 데이터를 시별 연도별 데이터로 바꾼다.

    # 영훈씨가 작성한 연도별 도 : 시 ratio csv 파일
    ratiodata = pd.read_csv("/home/hadoop/data/raw_data/cheon_naju_ratio_to_do.csv")
    # 나주시와 천안시 데이터를 구분하여 저장
    najuratiolist = ratiodata.loc[1:4,"ratio":"year_before"]
    cheonanratiolist = ratiodata.loc[5:11,"ratio":"year_before"]
    # 연도:면적ratio 형태의 dictionary 자료형으로 데이터 저장
    # 나주시 데이터
    najudict={}
    for i in range(len(najuratiolist)):
        if(i==0):
    #         1992년 데이터부터 존재 하므로 그 전에는 1992년 데이터와 같다고 assume
            najudict.update({1990:najuratiolist.iloc[i,0]})
            najudict.update({1991:najuratiolist.iloc[i,0]})
    #         하나의 row 별 연도 기간의 ratio 값을 가져와서 미리 생성한 dictionary 에 저장
        for x in list(range(int(najuratiolist.iloc[i,2:3]),int(najuratiolist.iloc[i,1:2]))):
            najudict.update({x:najuratiolist.iloc[i,0]})
    #         마지막 연도의 값은 그 전 연도의 ratio 와 같다고 assume
        if(i == (len(najuratiolist)-1)):
            najudict.update({int(najuratiolist.iloc[i,1]):(najuratiolist.iloc[i,0])})

    # dictionary 형태의 값들을 list(tuple로 바꿈)
    najudict=list(najudict.items())
    najudata = result.loc[:,"전라남도"]
    naju_production=pd.concat([najudata[najudata.index==str(najudict[x][0])+" 년"]*najudict[x][1] for x in range(len(najudict))])
    naju_production = pd.Series(naju_production)
    
    # 천안시 데이터
    cheonandict={}
    for i in range(len(cheonanratiolist)):
    #         하나의 row 별 연도 기간의 ratio 값을 가져와서 미리 생성한 dictionary 에 저장
        for x in list(range(int(cheonanratiolist.iloc[i,2:3]),int(cheonanratiolist.iloc[i,1:2]))):
            cheonandict.update({x:cheonanratiolist.iloc[i,0]})
    #         마지막 연도의 값은 그 전 연도의 ratio 와 같다고 assume
        if(i == (len(cheonanratiolist)-1)):
            cheonandict.update({int(cheonanratiolist.iloc[i,1]):(cheonanratiolist.iloc[i,0])})

    # dictionary 형태의 값들을 list(tuple로 바꿈)
    cheonandict=list(cheonandict.items())
    cheonandata = result.loc[:,"충청남도"]
    cheonan_production=pd.concat([cheonandata[cheonandata.index==str(cheonandict[x][0])+" 년"]
                              *cheonandict[x][1] for x in range(len(cheonandict))])
    cheonan_production = pd.Series(cheonan_production)

#5) 나주시 데이터 csv 파일로 저장 
    # 연도 기준 월 단위 값을 받는 list 생성
    all_month=[]

    # 성대씨가 만든 알고리즘에 따라 생산량의 1년량을 비율에 따라 12개월로 나눈다.
    [all_month.append(ym.get_12_list(naju_production[i])) for i in range(len(naju_production))]

    # 날짜를 index로 지정하고, 12개월로 나뉜 생산량을 values로 지정한다.
    month = list(range(1,13))
    list_series = pd.Series([x for y in all_month for x in y], 
                            index=[y.replace(" 년",str(x).zfill(2)) for y in naju_production.index for x in month])

    # 수정된 data를 DataFrame으로 만든다.
    list_df = pd.DataFrame(list_series)
    list_df.columns = ["naju"]
    
    save_file_name = list(list_df.columns)[0]
    list_df.to_csv("/home/hadoop/data/processed_data/pear_production/naju/processed_pear_production_"+save_file_name+"_"+str(datetime.datetime.now()).split(".")[0].replace(":","-").replace(" ","")+".csv", float_format='%.f')

#5) 천안시 데이터 csv 파일로 저장 
    all_month.clear()

    # 성대씨가 만든 알고리즘에 따라 생산량의 1년량을 비율에 따라 12개월로 나눈다.
    [all_month.append(ym.get_12_list(cheonan_production[i])) for i in range(len(cheonan_production))]

    # 날짜를 index로 지정하고, 12개월로 나뉜 생산량을 values로 지정한다.
    month = list(range(1,13))
    list_series = pd.Series([x for y in all_month for x in y], 
                            index=[y.replace(" 년",str(x).zfill(2)) for y in cheonan_production.index for x in month])

    # 수정된 data를 DataFrame으로 만든다.
    list_df = pd.DataFrame(list_series)
    list_df.columns = ["cheonan"]
    
    save_file_name = list(list_df.columns)[0]
    list_df.to_csv("/home/hadoop/data/processed_data/pear_production/cheonan/processed_pear_production_"+save_file_name+"_"+str(datetime.datetime.now()).split(".")[0].replace(":","-").replace(" ","")+".csv", float_format='%.f')

if __name__ == '__main__':
    main()
