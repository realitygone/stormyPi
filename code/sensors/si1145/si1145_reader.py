import os.path
import time
from datetime import datetime
import SI1145.SI1145 as SI1145

data_filename = "/home/pi/data/SI1145.csv"

sensor = SI1145.SI1145()

while True:
    vis = sensor.readVisible()
    IR = sensor.readIR()
    UV = sensor.readUV()
    current_date = datetime.now()
    UV_index = UV/100.0

    file_exists = os.path.exists(data_filename)
    with open(data_filename, 'a') as f:
        if (file_exists == False):
            f.write("SYSTEM_TIMESTAMP,VIS,IR,UV\n")
        f.write('"{3:%Y}-{3:%m}-{3:%d} {3:%H}:{3:%M}:{3:%S}",{0},{1},{2}\n'.format(vis, IR, UV, current_date))
    print '{3:%Y}-{3:%m}-{3:%d} {3:%H}:{3:%M}:{3:%S} VIS:{0} IR:{1} UV:{2}'.format(vis, IR, UV, current_date)
    # print 'VIS:' + str(vis) + ' IR:' + str(IR) + ' UV:' + str(UV)
    time.sleep(1)
