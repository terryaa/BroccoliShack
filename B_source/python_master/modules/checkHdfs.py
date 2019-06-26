import subprocess
def check_hdfs(text):
    result=subprocess.check_output('hdfs dfs -ls /flume/'+text+'/',shell=True)
    return str(result)

