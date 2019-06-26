from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.common.exceptions import UnexpectedAlertPresentException
from selenium.webdriver.common.alert import Alert
import time,os,sys
from selenium.common.exceptions import NoAlertPresentException, TimeoutException
from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.common.keys import Keys
from selenium.webdriver import ActionChains
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.firefox.firefox_binary import FirefoxBinary
from selenium.common.exceptions import WebDriverException

# 셀레리움 시작을 위한 크롬 드라이버를 설정
chromeOptions = webdriver.ChromeOptions()
prefs = {"download.default_directory" : "/home/webserver/data/raw_data/area_gain/","download.prompt_for_download": False,
  "download.directory_upgrade": True,
  "safebrowsing.enabled": True}
chromeOptions.add_experimental_option("prefs",prefs)
chromeOptions.add_argument("--no-snadbox")
chromedriver = "/usr/local/bin/chromedriver"
driver = webdriver.Chrome(executable_path=chromedriver, chrome_options=chromeOptions)

# URL을 통해 사이트로 진입
driver.implicitly_wait(3)
url='http://kosis.kr/statHtml/statHtml.do?orgId=101&tblId=DT_1ET0292&vw_cd=MT_ZTITLE&list_id=F1H&seqNo=&lang_mode=ko&language=kor&obj_var_id=&itm_id=&conn_path=MT_ZTITLE'
driver.get(url)

# 이후 사이트에서 데이터를 얻기위한 조작 시작.
while True:
    try:
        driver.find_element_by_xpath('//*[@id="tabTimeText"]/a').click()
        break
    except Exception:
        pass
driver.find_element_by_xpath('//*[@id="timeY"]/h2/select[1]').click()
driver.find_element_by_xpath('//*[@id="timeY"]/h2/select[1]/option[39]').click()

alert = driver.switch_to_alert()
alert.accept()


driver.find_element_by_xpath('//*[@id="searchImg2"]').click()

driver.find_element_by_xpath('//*[@id="downLargeCSV"]').click()



ele=driver.find_element_by_xpath('//*[@id="downLargeBtn"]/a')
ele.click()
time.sleep(10)

# 저장된 데이터를 ssh를 통해 마스터의 디렉토리로 옮기고 웹서버상의 데이터를 지움.
os.system("scp /home/webserver/data/raw_data/area_gain/* root@master:/home/hadoop/data/raw_data/area_gain")
os.system("rm -rf /home/webserver/data/raw_data/area_gain/*")
driver.close()
