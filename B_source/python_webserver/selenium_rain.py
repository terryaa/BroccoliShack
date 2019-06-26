from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import UnexpectedAlertPresentException,StaleElementReferenceException
from selenium.webdriver.common.alert import Alert
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
import time
import os,sys

# 강수량 데이터를 수집.
# 요소가 클릭이 될때까지 클릭을 시키는 알고리즘.
def clickable(x):
    while True:
        try:
            x.click()
            break
        except Exception:
            pass
# 요소의 자식중에서 value를 가진 요소를 찾아내서 클릭시키는 알고리즘.
def select_no(ele,val):
    for option in ele.find_elements_by_tag_name('option'):
        if option.get_attribute("value")==val:
            clickable(option) # select() in earlier versions of webdriver
            break
# 테이블내에서 특정 value를 가진 요소를 찾아내서 클릭시키는 알고리즘.
def table_sel(ele,val):
    for a in ele.find_elements_by_tag_name("a"):
        if a.text==val:
            clickable(a)
            break

# 윈하는 year를 선택시킴.
year=int(sys.argv[1])

# 셀레리움을 시작하기위한 크롬 드라이버를 설정.
chromeOptions = webdriver.ChromeOptions()
prefs = {"download.default_directory" : "/home/webserver/data/raw_data/rain_data/","download.prompt_for_download": False,
  "download.directory_upgrade": True,
  "safebrowsing.enabled": True}
chromeOptions.add_experimental_option("prefs",prefs)
chromeOptions.add_argument("--no-snadbox")
chromedriver = "/usr/local/bin/chromedriver"
driver = webdriver.Chrome(executable_path=chromedriver, chrome_options=chromeOptions)

# 사이트로 이동.
driver.get("https://data.kma.go.kr/data/gaw/selectPrcptchmList.do?pgmNo=584")
driver.implicitly_wait(7)
da = Alert(driver)

#자료조회 이동
clickable(driver.find_element_by_xpath('//*[@id="content"]/div[2]/div[1]/div[1]/ul/li[2]/a'))


for y in range(1997,year+1):
  
    mon=[("0101","0731"),("0801","1231")] # 상반기 하반기로 나눔.
    for sm,em in mon:
        start_y=str(y)+sm
        end_y=str(y)+em
        clickable(driver.find_element_by_xpath('//*[@id="dataFormCd"]/option[1]'))
        clickable(driver.find_element_by_xpath('//*[@id="startDt"]'))
        select=driver.find_element_by_xpath('//*[@id="ui-datepicker-div"]/div[1]/div/select[1]')
        select_no(select,start_y[:4])
        select=driver.find_element_by_xpath('//*[@id="ui-datepicker-div"]/div[1]/div/select[2]')
        mon=start_y[4:6].replace("0","") if start_y[4:6][0]=="0" else start_y[4:6]
        select_no(select,str(int(mon)-1))
        select=driver.find_element_by_xpath('//*[@id="ui-datepicker-div"]/table')
        day=start_y[6:].replace("0","") if start_y[6:][0]=="0" else start_y[6:]
        table_sel(select,day)
        
        clickable(driver.find_element_by_xpath('//*[@id="endDt"]'))
        select=driver.find_element_by_xpath('//*[@id="ui-datepicker-div"]/div[1]/div/select[1]')
        select_no(select,end_y[:4])
        select=driver.find_element_by_xpath('//*[@id="ui-datepicker-div"]/div[1]/div/select[2]')
        mon=end_y[4:6].replace("0","") if end_y[4:6][0]=="0" else end_y[4:6]
        select_no(select,str(int(mon)-1))
        select=driver.find_element_by_xpath('//*[@id="ui-datepicker-div"]/table')
        day=end_y[6:].replace("0","") if end_y[6:][0]=="0" else end_y[6:]
        table_sel(select,day)
        
        clickable(driver.find_element_by_xpath('//*[@id="btnStn1"]'))
        clickable(driver.find_element_by_xpath('//*[@id="ztree_3_check"]'))
        clickable(driver.find_element_by_xpath('//*[@id="sidetreecontrol"]/ul[2]/li/a'))
        clickable(driver.find_element_by_xpath('//*[@id="gubun"]'))
        clickable(driver.find_element_by_xpath('//*[@id="ztree_1_check"]'))
        clickable(driver.find_element_by_xpath('//*[@id="sidetreecontrol"]/ul[2]/li/a'))
        clickable(driver.find_element_by_xpath('//*[@id="dsForm"]/div[3]/a[2]'))
        clickable(driver.find_element_by_xpath('//*[@id="wrap-datapop"]/div/div[2]/div/span/a'))
        
time.sleep(10)

# 수집이 끝나고 ssh를 통해 마스터의 디렉토리로 데이터를 옮김
os.system("scp /home/webserver/data/raw_data/rain_data/* root@master:/home/hadoop/data/raw_data/rain_data")
# 옮긴후 웹서버의 데이터를 삭제
os.system("rm -rf /home/webserver/data/raw_data/rain_data/*")
driver.close()
