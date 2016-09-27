import os.path
import time
from datetime import datetime
from Adafruit_BME280 import *

data_filename = "/home/pi/data/BME280.csv"

sensor = BME280(mode=BME280_OSAMPLE_8)

# print 'Timestamp = {0:0.3f}'.format(sensor.t_fine)
# print 'Temp      = {0:0.3f} deg C'.format(degrees)
# print 'Pressure  = {0:0.2f} hPa'.format(hectopascals)
# print 'Humidity  = {0:0.2f} %'.format(humidity)

file_exists = os.path.exists(data_filename)

while True:
    degrees = sensor.read_temperature()
    pascals = sensor.read_pressure()
    hectopascals = pascals / 100
    humidity = sensor.read_humidity()
    current_date = datetime.now()

    print '{4:%Y}-{4:%m}-{4:%d} {4:%H}:{4:%M}:{4:%S} - T:{1:0.3f} P:{2:0.2f} H:{3:0.2f}'.format(sensor.t_fine, degrees, pascals, humidity, current_date)

    with open(data_filename, 'a') as f:
        if (file_exists == False):
            f.write('SYSTEM_TIMESTAMP,SENSOR_TIMESTAMP,SENSOR_TEMP,SENSOR_PRESSURE,SENSOR_HUMIDITY\n')
            file_exists = True
        f.write('"{4:%Y}-{4:%m}-{4:%d} {4:%H}:{4:%M}:{4:%S}",{0:0.3f},{1:0.3f},{2:0.2f},{3:0.2f}\n'.format(sensor.t_fine, degrees, pascals, humidity, current_date))
    
    time.sleep(1)
