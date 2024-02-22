#!/bin/bash
mkdir -p /var/log/logging-service
chmod 755 /var/log/logging-service
touch /var/log/logging-service/service.log
chmod 644 /var/log/logging-service/service.log
echo "$(date) - Logging Service Initialization Complete." >> /var/log/logging-service/service.log
