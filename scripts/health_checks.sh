#!/bin/bash

################################################################################
# Script Name : health_check.sh
# Description : Performs basic Linux health checks
# Checks:
#   1. Disk Usage
#   2. Memory Usage
#   3. Docker Service Status
#   4. Logs output to timestamped log file
#   5. Returns non-zero exit code if disk usage exceeds 80%
################################################################################

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_FILE="health_check_${TIMESTAMP}.log"

echo "===================================================" | tee -a "$LOG_FILE"
echo "Linux Health Check Report" | tee -a "$LOG_FILE"
echo "Generated On : $(date)" | tee -a "$LOG_FILE"
echo "===================================================" | tee -a "$LOG_FILE"

echo "" | tee -a "$LOG_FILE"
echo "Disk Usage" | tee -a "$LOG_FILE"
echo "-----------" | tee -a "$LOG_FILE"

df -h | tee -a "$LOG_FILE"

DISK_USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

echo "" | tee -a "$LOG_FILE"
echo "Memory Usage" | tee -a "$LOG_FILE"
echo "------------" | tee -a "$LOG_FILE"

free -h | tee -a "$LOG_FILE"

echo "" | tee -a "$LOG_FILE"
echo "Docker Service Status" | tee -a "$LOG_FILE"
echo "---------------------" | tee -a "$LOG_FILE"

if systemctl is-active --quiet docker
then
    echo "Docker Service : RUNNING" | tee -a "$LOG_FILE"
else
    echo "Docker Service : NOT RUNNING" | tee -a "$LOG_FILE"
fi

echo "" | tee -a "$LOG_FILE"
echo "Disk Utilization : ${DISK_USAGE}%" | tee -a "$LOG_FILE"

if [ "$DISK_USAGE" -gt 80 ]
then
    echo "WARNING: Disk utilization exceeds 80%." | tee -a "$LOG_FILE"
    exit 1
fi

echo "" | tee -a "$LOG_FILE"
echo "System Health Check Completed Successfully." | tee -a "$LOG_FILE"

exit 0
