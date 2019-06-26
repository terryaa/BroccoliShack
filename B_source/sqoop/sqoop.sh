#!/bin/bash
python3.6 /root/foracle_tmysql.py 201812
sqoop import\
       	--connect jdbc:mysql://localhost/final\
      	--username fp\
       	--password 1234\
       	--table matching\
	--target-dir /home/hadoop/data/more_processed_data/month_workingtime_data/cheonan \
	--m 1\
	--append
sqoop import\
       	--connect jdbc:mysql://localhost/final\
      	--username fp\
       	--password 1234\
       	--table matching\
	--target-dir /home/hadoop/data/more_processed_data/month_workingtime_data/naju \
	--m 1\
	--append
