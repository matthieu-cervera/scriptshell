import psutil

print("")
print("Memory%" + str(psutil.virtual_memory()[3]))
print("CPU%" + str(psutil.cpu_percent(interval=1)))
