from urllib.request import urlopen
from urllib.error import HTTPError,URLError
from bs4 import BeautifulSoup

def getSoup(api_url):
    try:
        page=urlopen(api_url)
    except HTTPError:
        try:
            page=urlopen(api_url.decode('ASCII')).read()
            print("HTTP 에러")
        except Except:
            print("HTTP Error")
    except URLError:
        print("URL 에러")
    else:
        soup=BeautifulSoup(page.read(),'lxml')
        return soup

def getHtml(api_url):
    try:
        page=urlopen(api_url)
    except HTTPError:
        print("HTTP 에러")
    except URLError:
        print("URL 에러")
    else:
        return page
