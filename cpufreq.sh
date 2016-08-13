#!/bin/bash
# Supposing a 4-thread Intel CPU
A=$(sudo cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq)
B=$(sudo cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq)
C=$(sudo cat /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq)
D=$(sudo cat /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq)
AG=$(echo "scale=3; $A / 1000000" | bc)
BG=$(echo "scale=3; $B / 1000000" | bc)
CG=$(echo "scale=3; $C / 1000000" | bc)
DG=$(echo "scale=3; $D / 1000000" | bc)
AV=$(echo "scale=3; ($AG + $BG + $CG + $DG) / 4" | bc)
echo "Current CPU frequency:"
echo "-------------------------"
echo "CPU0: $AG GHz"
echo "CPU1: $BG GHz"
echo "CPU2: $CG GHz"
echo "CPU3: $DG GHz"
echo "Average: $AV GHz"
