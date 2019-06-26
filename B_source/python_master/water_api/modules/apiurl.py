import urllib.request
import urllib.parse

def crop_kwater_url(*args):
    
    url="http://opendata.kwater.or.kr/openapi-data/service/pubd/underGroundWater/waterQuality"
    key="serviceKey=jAkk5tTEPGKz1Zs6w%2FbGGpkPBCc%2BrrJcw2QI9LfcrYD77m2cQJWDgzZP14xOPIOpZQWJm2P2nC2ZsaacfYxcLw%3D%3D"
    
    #지역정보를 가져옴
    if args[0]== 1:
        api_url=url+"/sido/codelist?"+key
        return api_url
    
    #지반종류 가져옴
    elif args[0]== 2:
        api_url=url+"/wellnum/codelist?"+key
        return api_url
    
    #상세 지역정보를 가져옴
    elif args[0]== 3:
        api_url={}
        for i in args[1]:
            i = urllib.parse.quote_plus(i)
            for j in args[2]:
                api_url1=[i,j]
                api_url2=url+"/jewon/codelist?sido="+i+"&wellnum="+j+"&"+key
                api_url[api_url2]=api_url1
        return api_url
    
    #년도 정보를 가져옴    
    elif args[0]== 4:
        api_url=url+"/yyyy/codelist?"+key
        return api_url
    
    #최종 지하수 정보
    elif args[0]== 5:
        #api_url=[]
        api_url={}
        for j,k in args[2].items():
            if k[1]==2:
                k[1]=""
           # api_url.append(url+"/list?&gennum="+j+"&stdt="+args[1]+"&eddt="+args[1]+"&sido="+k[0]+"&wellnum="+k[1]+"&numOfRows=10&"+key+"&pageNo=1")
            #api_url.append(url+"/list?&gennum="+j+"&stdt="+'1996'+"&eddt="+'2015'+"&sido="+k[0]+"&wellnum="+k[1]+"&numOfRows=10&"+key+"&pageNo=1")
            api_url[url+"/list?&gennum="+j+"&stdt="+args[1]+"&eddt="+args[1]+"&sido="+k[0]+"&wellnum="+k[1]+"&numOfRows=1000&"+key+"&pageNo=1"]=urllib.parse.unquote(k[0])
#api_url[url+"/list?&gennum="+j+"&stdt="+'1996'+"&eddt="+'2015'+"&sido="+k[0]+"&wellnum="+k[1]+"&numOfRows=1000&"+key+"&pageNo=1"]=urllib.parse.unquote(k[0])
        return api_url

    
    


