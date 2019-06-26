#!/bin/bash

python3.6 /home/hadoop/python/area_data_collect_main.py
python3.6 /home/hadoop/python/crop_price_main.py 2019 30
python3.6 /home/hadoop/python/crop_weather_main.py 20010101 20181231 천안 배
python3.6 /home/hadoop/python/crop_weather_main.py 20010101 20181231 나주 배
python3.6 /home/hadoop/python/income_processed_data.py
python3.6 /home/hadoop/python/pear_production.py
python3.6 /home/hadoop/python/WorkingtimeByDistrict.py
python3.6 /home/hadoop/python/farm_area_api/farm_area_main.py
python3.6 /home/hadoop/python/rain_chemical/rain_chemical.py
python3.6 /home/hadoop/python/water_api/water_api.py
