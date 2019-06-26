import subprocess
def get_hdfs_list(path):
    args = "hdfs dfs -ls "+path+" | awk '{print $8}'"
    proc = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    s_output, s_err = proc.communicate()
    all_dart_dirs = s_output.split()
    return all_dart_dirs
