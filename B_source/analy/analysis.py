import sys,os
sys.path.append(os.path.dirname(__file__))
from module.Get_HDFS import get_data
from keras import metrics
import pandas as pd
from keras import layers, models
from sklearn import preprocessing
from sklearn.preprocessing import normalize
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from module.connection import insert_oracle

def rmse(y_true, y_pred):
    from keras import backend
    return backend.sqrt(backend.mean(backend.square(y_pred - y_true), axis=-1))

# mean squared error (mse) for regression
def mse(y_true, y_pred):
    from keras import backend
    return backend.mean(backend.square(y_pred - y_true), axis=-1)

# coefficient of determination (R^2) for regression
def r_square(y_true, y_pred):
    from keras import backend as K
    SS_res =  K.sum(K.square(y_true - y_pred))
    SS_tot = K.sum(K.square(y_true - K.mean(y_true)))
    return (1 - SS_res/(SS_tot + K.epsilon()))

def r_square_loss(y_true, y_pred):
    from keras import backend as K
    SS_res =  K.sum(K.square(y_true - y_pred))
    SS_tot = K.sum(K.square(y_true - K.mean(y_true)))
    return 1 - ( 1 - SS_res/(SS_tot + K.epsilon()))


# 모델 선언부
class RNN(models.Sequential):
    def __init__(self, Nin,  Nout):
        super().__init__()
        self.add(layers.LSTM(1024, 
            activation='relu',
            input_shape=(1,Nin)))
        self.add(layers.BatchNormalization())
        self.add(layers.Dropout(0.4))
        self.add(layers.Dense(128, activation='relu'))       
        self.add(layers.Dropout(0.25))
        self.add(layers.BatchNormalization())
        self.add(layers.Dense(Nout, activation='relu'))
        self.compile(loss='mean_squared_error', 
                         optimizer='adam', 
                         metrics=[mse, rmse, r_square])

# 데이터 불러오기 (spark를 통해 hdfs에서)
def data_set(dir):
    area=["cheonan","naju"]
    data_set=[]
    for a in area:
        data_a_set=[]
        for d in dir:
            path="/home/hadoop/data/more_processed_data/"+d+"/"+a
            print(path)
            data=get_data(path)
            data['ym']=data['ym'].astype('object')
            data_a_set.append(data)
        df=data_a_set[0]
        if len(data_a_set)>1:
            for temp in data_a_set[1:]:
                df=pd.merge(df,temp,on="ym",how="outer")
        
        if 'self' in df.columns:
            df.drop(['self'],axis=1,inplace=True)
        df.sort_values(['ym'],inplace=True)
        col=list(df.columns)
        y_m=df.ym.astype('float64').as_matrix()
        df.drop(['ym'],axis=1,inplace=True)
        df=df.as_matrix()
        np.where(df=="NaN",0,df)
        np.where(df==np.NaN,0,df)
        data_set.append(df)
    return data_set,y_m


def main():
    # 데이터 HDFS로 부터 가져오기
    x_dir=["weather_data","water_data","pear_production","rain_data","income_data","price_data"]
    y_dir=["month_workingtime_data"]
    X_data , y_m=data_set(x_dir)
    Y_data , _=data_set(y_dir)
    # 학습할 데이터와 예측할 데이터 분리
    x_pred_ch=X_data[0][12:,:]
    x_pred_nj=X_data[1][12:,:]
    y_pred_ch=Y_data[0]/8
    y_pred_nj=Y_data[1]/8
    
    X_data_ch=X_data[0][12:-12,:] 
    X_data_nj=X_data[1][12:-12,:]
    Y_data_ch=Y_data[0][12:,:]/8
    Y_data_nj=Y_data[1][12:,:]/8
    # 지역별로 따로 학습하기 위해서 dict 생성
    data_dict= {'manpower_RNN_cn':(X_data_ch,Y_data_ch,x_pred_ch,y_pred_ch),'manpower_RNN_nj':(X_data_nj,Y_data_nj,x_pred_nj,y_pred_nj)}
    for ar in ['manpower_RNN_cn','manpower_RNN_nj']:
        # dict로 부터 데이터를 가져옴
        X_data,Y_data,x_pred,y_pred_data= data_dict[ar] 
        # 모델에 피팅시키기전에 데이터 전처리를 다시 실행
        # 이경우 날씨데이터의 없는 부분을 위해 결측치가 들어간 행 제거
        X_data_1=np.append(X_data,Y_data,axis=1)
        X_data_1=X_data_1[~np.isnan(X_data_1).any(axis=1)]
        
        Y_data=X_data_1[:,-1]
        X_data_1=normalize(X_data_1[:,:-1])
        # RNN에 맞게 shape를 만듬
        # 모뎅 생성 Nin=x의 갯수 Nout=y의 갯수
        Nin=X_data_1.shape[1]
        Nout = 1
        X_data_1=X_data_1.reshape((-1,1,Nin))
        model = RNN(Nin,  Nout)
        # 학습 시작
        history = model.fit(X_data_1, Y_data, epochs=250, batch_size=12,validation_split=0.05, verbose=2)
        
        history=history.history
        # 예측데이터를 가져오기 위해서 위와 동일한 전처리 시작
        x=np.append(x_pred,y_pred_data,axis=1)
        x=np.append(x,y_m[12:].reshape((-1,1)),axis=1)
        x=x[~np.isnan(x).any(axis=1)]
        ym=x[:,-1]
        y_pred_data=x[:,-2]
        x_pred=normalize(x[:,:-2])
        x_pred=x_pred.reshape((-1,1,x_pred.shape[1]))
         # 하습한 모델로 부터 예측값을 계산
        
        y_pred=model.predict(x_pred)
        # 학습동안 어떻게 학습이 되었는지를 확인하기위해서
        # matplotlib로 그래프를 생성
        # loss(손실값)과 val_loss(검증데이터에 대한 손실)을 그래프화
        fig=plt.figure()
        ax=fig.subplots()
        ax.plot(history['loss'])
        ax.plot(history['val_loss'])
        ax.legend(['loss','val_loss'], loc=0)
        fig.savefig('/root/'+ar+'loss.png')
        
        # r_square(결정계수=독립변수와 종속변수의 상관도)를 그래프화
        fig=plt.figure()
        ax=fig.subplots()
        ax.plot(history['r_square'])
        ax.legend(['r_square'], loc=0)
        fig.savefig('/root/'+ar+'r_square.png')
        
        # val_r_square(검증데이터에 대한 결정계수)를 그래프화
        fig=plt.figure()
        ax=fig.subplots()
        ax.plot(history['val_r_square'])
        ax.legend(['val_r_square'], loc=0)
        fig.savefig('/root/'+ar+'val_r_square.png')

        # 실제데이터와 모델이 예측한 데이터를 비교하는 그래프
        fig=plt.figure()
        ax1=fig.subplots()
        ax1.plot(y_pred)
        ax1.plot(y_pred_data)
        ax1.legend(['pred','actual'],loc=0)
        fig.savefig('/root/'+ar+'pred.png')
        
        # 실제데이터와 예측데이터의 차이를 그래프화
        fig=plt.figure()
        ax1=fig.subplots()
        cross_y_pred=y_pred.reshape((-1))-y_pred_data.reshape((-1))
        ax1.plot(cross_y_pred)
        ax1.legend(['cross'],loc=0)
        fig.savefig('/root/'+ar+'pred_cross.png')

        # 데이터를 oracleDB에 저장
        data=zip(list(map(float,list(y_pred.reshape((-1))))),list(map(int,list(ym))),len(ym)*[ar[-2:]])
        insert_oracle(data,ar)
if __name__ == '__main__':
    main()

