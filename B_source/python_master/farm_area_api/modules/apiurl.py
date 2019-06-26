def farm_area():
    url="http://apis.data.go.kr/1390804/Nihhs_Fruit_Area3/"
    key="serviceKey=jAkk5tTEPGKz1Zs6w%2FbGGpkPBCc%2BrrJcw2QI9LfcrYD77m2cQJWDgzZP14xOPIOpZQWJm2P2nC2ZsaacfYxcLw%3D%3D"
    operation="ctlArea"
    numofrows="numOfRows=10"
    fs_gb="fs_gb=%EB%B0%B0"
    pageno="pageNo="
    
    api_url=url+operation+"?"+key+"&"+numofrows+"&"+fs_gb+"&"+pageno
    return api_url