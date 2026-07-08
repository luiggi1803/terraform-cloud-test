echo "Este es un mensaje de prueba" > ~/mensaje.txt
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl start httpd