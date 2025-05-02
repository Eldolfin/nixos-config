#!python3
import psutil

res = f"{psutil.cpu_percent(interval=1)}%"
print(res)
print(res)
