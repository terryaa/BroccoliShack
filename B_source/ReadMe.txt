Flume:
설정 파일내에 있는 open.sh를 실행함으로써 flume실행

Hadoop:
etc/hadoop/ 내에있는 (마스터) 설정파일

python_webserver:
웹서버에서 실행되는 데이터 수집용 파이썬 코드(셀레니움) / raw_data_python.sh 로 실행

python_master:
마스터에서 데이터를 전처리하는 파이썬 코드 / get_processed_data.sh 로 실행

python_master/more:
hdfs에 연동하여 전처리된 데이터에서 다시한번 결측치제거 등의 전처리를 실행하는 코드 / get_more_processed_data.sh 로 실행

analy/R_Regression_Analysis.r:
R을 통해 hdfs에서 spark로 가져온 데이터를 다중회귀분석하여 오라클디비에 넣는 코드

analy/analysis.py:
python을 통해 hdfs에서 spark로 가져온 데이터를 RNN을 학습시켜 예측한 데이터를 오라클디비에 넣는 코드

spark:
spark 설정파일

sqoop:
sqoop 설정 파일 / sqoop.sh는 mysql내의 matching테이블의 데이터를 hdfs로 저장하는 코드 실행

webaapps:
만든 사이트 spring maven 프로젝트파일

Project_Final.war:
만든 사이트 war파일

B_sql_oracle.txt
oracledb에 만든 테이블 sql문 (인코딩 : utf-8)

B_sql_mysql.txt
mysql에 만든 테이블 sql문