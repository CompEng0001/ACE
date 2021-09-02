#! /bin/bash

# Created By: Seb Blair
# Date Created: 2021/01/31
# Version: 1.0

## Notes
#  basename stores the current path of the some/path/to/file

tail -n1 IoTHub/*/data_log.csv | awk -F',' '{print basename $1 " " $8}'



