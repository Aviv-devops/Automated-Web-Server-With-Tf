#!/bin/bash
# Log file
exec > /var/log/userdata.log 2>&1

# Update and install Nginx
yum update -y
yum install -y nginx

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# Add the ec2-user to the nginx group
usermod -a -G nginx ec2-user

# Extract the path of the Nginx HTML directory
nginx_html_path=$(nginx -V 2>&1 | grep --color -o -e '--prefix=[^[:space:]]\+' | sed 's/--prefix=//' | sed 's/$/\/html/')

# # Set the correct permissions for the web content directory
chown -R ec2-user:nginx "$nginx_html_path/html"
chmod 2775 "$nginx_html_path/html"
chmod 0664 "$nginx_html_path/html"

# Copy your custom HTML file to the appropriate location
if [ -f /tmp/index.html ]; then
    cp /tmp/index.html "$nginx_html_path/index.html"
else
    echo "index.html not found in /tmp" >> /var/log/userdata.log
    exit 1
fi

# Ensure proper permissions for the new index.html
chmod 644 /usr/share/nginx/html/index.html
chown nginx:nginx /usr/share/nginx/html/index.html

# Log the permissions and ownership of the file
ls -l "$nginx_html_path/index.html" >> /var/log/userdata.log

# Log Nginx status
systemctl status nginx >> /var/log/userdata.log