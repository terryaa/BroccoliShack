
def get_12_list(n):
    list=[0]*7+[2.3,20.1,33,4.3,0]
    s=sum(list)
    return [n*x/s for x in list]