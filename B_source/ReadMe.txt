Flume:
���� ���ϳ��� �ִ� open.sh�� ���������ν� flume����

Hadoop:
etc/hadoop/ �����ִ� (������) ��������

python_webserver:
���������� ����Ǵ� ������ ������ ���̽� �ڵ�(�����Ͽ�) / raw_data_python.sh �� ����

python_master:
�����Ϳ��� �����͸� ��ó���ϴ� ���̽� �ڵ� / get_processed_data.sh �� ����

python_master/more:
hdfs�� �����Ͽ� ��ó���� �����Ϳ��� �ٽ��ѹ� ����ġ���� ���� ��ó���� �����ϴ� �ڵ� / get_more_processed_data.sh �� ����

analy/R_Regression_Analysis.r:
R�� ���� hdfs���� spark�� ������ �����͸� ����ȸ�ͺм��Ͽ� ����Ŭ��� �ִ� �ڵ�

analy/analysis.py:
python�� ���� hdfs���� spark�� ������ �����͸� RNN�� �н����� ������ �����͸� ����Ŭ��� �ִ� �ڵ�

spark:
spark ��������

sqoop:
sqoop ���� ���� / sqoop.sh�� mysql���� matching���̺��� �����͸� hdfs�� �����ϴ� �ڵ� ����

webaapps:
���� ����Ʈ spring maven ������Ʈ����

Project_Final.war:
���� ����Ʈ war����

B_sql_oracle.txt
oracledb�� ���� ���̺� sql�� (���ڵ� : utf-8)

B_sql_mysql.txt
mysql�� ���� ���̺� sql��