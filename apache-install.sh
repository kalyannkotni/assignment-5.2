#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo service httpd start  
sudo systemctl enable httpd
echo "succesfully completed assignment-5.2 VM" > /var/www/html/index.html