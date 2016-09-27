/***********************************************************************
 * mcp3008SpiTest.cpp. Sample program that tests the mcp3008Spi class.
 * an mcp3008Spi class object (a2d) is created. the a2d object is instantiated
 * using the overloaded constructor. which opens the spidev0.0 device with
 * SPI_MODE_0 (MODE 0) (defined in linux/spi/spidev.h), speed = 1MHz &
 * bitsPerWord=8.
 *
 * call the spiWriteRead function on the a2d object 20 times. Each time make sure
 * that conversion is configured for single ended conversion on CH0
 * i.e. transmit ->  byte1 = 0b00000001 (start bit)
 *                   byte2 = 0b1000000  (SGL/DIF = 1, D2=D1=D0=0)
 *                   byte3 = 0b00000000  (Don't care)
 *      receive  ->  byte1 = junk
 *                   byte2 = junk + b8 + b9
 *                   byte3 = b7 - b0
 *
 * after conversion must merge data[1] and data[2] to get final result
 *
 *
 *
 * *********************************************************************/
#include "mcp3008Spi.h"
#include <iostream>
#include <fstream>
#include <ctime>
#include <iomanip>
#include <sys/stat.h>
#include <sys/time.h>

using namespace std;

// http://stackoverflow.com/a/16358264/201021
string getCurrentTime() {
        time_t rawtime;
        struct tm * timeinfo;
        char buffer[80];

        time(&rawtime);
        timeinfo = localtime(&rawtime);

        strftime(buffer,80,"%F %T",timeinfo);
        std::string str(buffer);
        return str;
}

timeval getCurrentTimestamp() {
	struct timeval tv;

	gettimeofday(&tv, NULL);
	return tv;
}

double convertWindSpeed(int adcValue) {
	const double low_value = 124.12;
	const double high_value = 620;
	const double max_value = 70;
	return (((double)adcValue - low_value) / high_value) * max_value;
}

bool fileExists(char* &name) {
	string filename(name);
	struct stat buffer;
	if (stat(filename.c_str(), &buffer) == 0) {
		return true;
	}
	else {
		return false;
	}
}

void writeToFile(int adcValue) {
	char* datafileName = "/home/pi/data/anemometer.csv";
	ofstream datafileStream;

	if (!fileExists(datafileName)) {
		datafileStream.open(datafileName, ios::out);
		datafileStream << "SYSTEM_TIMESTAMP,SYSTEM_EPOCH_TIME,SYSTEM_MILLISECONDS,WIND_SPEED,RAW_VALUE" << endl;
	}
	else {
		datafileStream.open(datafileName, ios::out | ios::app);
	}

	double windSpeed = convertWindSpeed(adcValue);
	timeval currentTimestamp = getCurrentTimestamp();

	datafileStream << "\"" << getCurrentTime() << "\"," << currentTimestamp.tv_sec << "," << currentTimestamp.tv_usec << "," << windSpeed << "," << adcValue << endl;
	datafileStream.close();

	cout << getCurrentTime() << " - Wind speed: " << setprecision(2) << fixed << windSpeed << "m/s (" << adcValue << ")" << endl;
}

int main(void)
{
    mcp3008Spi a2d("/dev/spidev0.0", SPI_MODE_0, 1000000, 8);
    int a2dVal = 0;
    int a2dChannel = 7;
    unsigned char data[3];

    while(1 > 0)
    {
        data[0] = 1;  //  first byte transmitted -> start bit
        data[1] = 0b10000000 |( ((a2dChannel & 7) << 4)); // second byte transmitted -> (SGL/DIF = 1, D2=D1=D0=0)
        data[2] = 0; // third byte transmitted....don't care

        a2d.spiWriteRead(data, sizeof(data));

        a2dVal = 0;
        a2dVal = (data[1]<< 8) & 0b1100000000; //merge data[1] & data[2] to get result
        a2dVal |=  (data[2] & 0xff);

	writeToFile(a2dVal);

	usleep(100000);
    }
    return 0;
}
