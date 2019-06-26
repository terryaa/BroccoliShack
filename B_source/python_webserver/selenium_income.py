#!/usr/bin/env python
from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.common.exceptions import UnexpectedAlertPresentException,StaleElementReferenceException
from selenium.webdriver.common.alert import Alert
from selenium.webdriver.support.ui import WebDriverWait
import time
import os
# 소득데이터를 수집

# 셀레니움 시작을 위한 크롬 드라이버를 설정.
chromeOptions = webdriver.ChromeOptions()
prefs = {"download.default_directory" : "/home/webserver/data/raw_data/income_data"}
chromeOptions.add_experimental_option("prefs",prefs)
chromeOptions.add_argument("--no-snadbox")
chromedriver = "/usr/local/bin/chromedriver"
driver = webdriver.Chrome(executable_path=chromedriver, chrome_options=chromeOptions)
# 사이트로 이동.
driver.get("http://oasis.krei.re.kr/analyzer/income.do")
driver.implicitly_wait(7)
da = Alert(driver)

#기간설정
driver.find_element_by_css_selector('#sYear > option:nth-child(24)').click()
driver.find_element_by_css_selector('#eYear > option:nth-child(1)').click()

#충남, 전남을 선택.
driver.find_element_by_css_selector('#spancode2 > dd > ol > li:nth-child(10) > label').click()
driver.find_element_by_css_selector('#spancode2 > dd > ol > li:nth-child(5) > label').click()

time.sleep(7)
# 소득, 조수입을 먼저 선택해서 저장 
driver.find_element_by_css_selector('#spancode1 > dd > ol.last > li:nth-child(2)').click()
    
driver.find_element_by_css_selector('#code30').click()
driver.find_element_by_css_selector('#code32').click()

driver.find_element_by_css_selector('#search').click()

time.sleep(7)
driver.find_element_by_css_selector('#excelDownload > img').click()
time.sleep(7)

# 사이트로 재이동.
driver.get("http://oasis.krei.re.kr/analyzer/income.do")

da = Alert(driver)

#기간설정
driver.find_element_by_css_selector('#sYear > option:nth-child(24)').click()
driver.find_element_by_css_selector('#eYear > option:nth-child(1)').click()

#충남, 전남ㅇㅇ
driver.find_element_by_css_selector('#spancode2 > dd > ol > li:nth-child(10) > label').click()
driver.find_element_by_css_selector('#spancode2 > dd > ol > li:nth-child(5) > label').click()
# 소득률및 경영비를 이후에 다시 저장
time.sleep(7)
driver.find_element_by_css_selector('#spancode1 > dd > ol.last > li:nth-child(2)').click()
    
driver.find_element_by_css_selector('#code34').click()
driver.find_element_by_css_selector('#code31').click()

driver.find_element_by_css_selector('#search').click()
time.sleep(7)
driver.find_element_by_css_selector('#excelDownload > img').click()
time.sleep(10)

driver.close()
# 저장된 데이터를 ssh를 통해 마스터의 디렉토리로 옮기고 웹서버상의 데이터를 지움.
os.system("scp /home/webserver/data/raw_data/income_data/* root@master:/home/hadoop/data/raw_data/income_data/")
os.system("rm -rf /home/webserver/data/raw_data/income_data/*")
