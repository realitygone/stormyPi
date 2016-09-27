import os.path
import time
from datetime import datetime
from tsl2561 import TSL2561

data_filename = '/home/pi/data/TSL2156.csv'

tsl = TSL2561()

while True:
    current_date = datetime.now()

    file_exists = os.path.exists(data_filename)
    with open(data_filename, 'a') as f:

        try:
            lux = tsl.lux()
        except:
            lux = -1
        
        if (file_exists == False):
            f.write('SYSTEM_TIMESTAMP,LUX\n')
        f.write('"{0:%Y}-{0:%m}-{0:%d} {0:%H}:{0:%M}:{0:%S}",{1}\n'.format(current_date, lux))
        
    print '{0:%Y}-{0:%m}-{0:%d} {0:%H}:{0:%M}:{0:%S} LUX:{1}'.format(current_date, lux)
    time.sleep(1)
