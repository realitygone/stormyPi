#!/bin/bash
REMOTE_DIR=/home/pi/eluria
DATA_DIR=/home/pi/data/*

if mountpoint -q $REMOTE_DIR; then
	echo "Remote filesystem is mounted."
else
	echo "Mounting remote filesystem now."
	sudo mount /home/pi/eluria
fi

CURRENT_TIMESTAMP=`date +%Y%m%d%H%M%S`

for f in $DATA_DIR
do
	CURRENT_FILE=$f.$CURRENT_TIMESTAMP.csv
	mv $f $CURRENT_FILE
	mv $CURRENT_FILE $REMOTE_DIR
done
