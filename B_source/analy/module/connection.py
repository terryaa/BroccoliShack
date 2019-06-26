import cx_Oracle as co
def insert_oracle(data,table_name):
    try:
        # 웹서버의 oracleDB와 연결 후 커서를 열음.
        conn=co.connect('fp/1234@192.168.0.46:1521/xe')
        cursor=conn.cursor()

        # 테이블의 모든 데이터를 지움.
        cursor.execute('delete from '+table_name)
        
        # 테이블에 데이터를 하나씩 넣음.
        sql='insert into '+table_name+' values(:manpower,:ym,:city)'
        for d in data:
            cursor.execute(sql,manpower=d[0],ym=d[1],city=d[2])
            conn.commit()    
    # 연결과 커서를 닫음.
    finally:
        cursor.close()
        conn.close()

