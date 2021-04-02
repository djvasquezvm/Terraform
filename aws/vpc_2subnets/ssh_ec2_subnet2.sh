ssh -fNCq -i ~/.ssh/id_rsa -L 9999:$(cat ip_ec2_subnet2.txt):22 ec2-user@$(cat ip_ec2_subnet1.txt)
ssh -p 9999 -i ~/.ssh/id_rsa ec2-user@localhost
