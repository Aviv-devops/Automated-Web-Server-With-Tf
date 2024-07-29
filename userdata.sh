#!/bin/bash
# Install Nginx
yum update -y
yum install -y nginx
systemctl start nginx
systemctl enable nginx
