import psutil

logger.info("")
logger.info("Memory%" % psutil.virtual_memory()[3])
logger.info("CPU%" % psutil.cpu_percent(interval=1))
