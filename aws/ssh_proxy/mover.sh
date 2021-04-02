scp -i ~/.ssh/id_rsa archivos.tar.gz ec2-user@$(cat ip_ec2.txt):/home/ec2-user
