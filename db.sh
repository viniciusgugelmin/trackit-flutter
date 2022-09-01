#!/bin/sh

PACKAGE_NAME="com.vritualg.trackit_flutter"
DB_DIR="/data/user/0/com.vritualg.trackit_flutter/app_flutter"
DB_FILE="trackit"

echo "Entering the directory..."
cd ~/Android/Sdk/platform-tools

echo "Pulling ${DB_FILE}.db to SD card..."
./adb shell run-as ${PACKAGE_NAME} "cp ${DB_DIR}/${DB_FILE}.db /sdcard/ && exit"

echo "Pulling ${DB_FILE}.db to ~/Downloads..."
./adb pull /sdcard/${DB_FILE}.db ~/Downloads/

echo "Entering the database..."
sqlite3 -column -header ~/Downloads/${DB_FILE}.db
