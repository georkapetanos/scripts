#!/bin/bash
RAW=$(sudo smartctl -a /dev/sda | grep Total_LBAs_Written | awk '{print $10}')
DISC=$(sudo hdparm -I /dev/sda | grep Model | awk '{print " "$3" "$4" "$5" "$6" "$7}')
VAL=$(echo "scale=3; $RAW * 512" | bc)
VAL1=$(echo "scale=3; $VAL / 1099511627776" | bc)
VAL2=$(echo "scale=3; $VAL / 1073741824" | bc)
echo "-----------------------------------"
echo "Device: $DISC"
echo "-----------------------------------"
echo "Data Written to disk:"
echo "	TBs Written: $VAL1"
echo "	GBs Written: $VAL2"
echo "-----------------------------------"
