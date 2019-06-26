import pandas as pd
import sys

def main(path):
    #path="C:\\Users\\kosta\\Desktop\\data\\AREA-cheonanCROP-pearFROM-200101END-201812CREATED-2019-06-1207-14-07.csv"
    df=pd.read_csv(path)
    ymseries=df.ym
    ymstrlist={ str(i).replace("\n","")[:-2] : 1 for i in ymseries}
    frame=pd.DataFrame()
    for i in range(1,13):
        for year in ymstrlist:
            for idx,row in df.iterrows():
                if row['ym']%(int(year)*100)==i:
                    frame=frame.append(row)
                    break
    loc=path.find("pear")+4
    writepath=path[:loc]+"SORTBY_month"+path[loc:]
    frame.to_csv(writepath)
        
if __name__=="__main__":
    main(sys.argv[1])