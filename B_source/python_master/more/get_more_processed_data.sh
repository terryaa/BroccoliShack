#!/bin/bash

spark-submit /home/hadoop/

spark-submit /home/hadoop/python/more/month_workingtime_main.py
spark-submit /home/hadoop/python/more/crop_price_more_processed.py
spark-submit /home/hadoop/python/more/income_more_processed_data.py
spark-submit /home/hadoop/python/more/other_data.py
spark-submit /home/hadoop/python/more/water_api_prep.py

