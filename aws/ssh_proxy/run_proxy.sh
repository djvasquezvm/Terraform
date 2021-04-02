ip_ec2=$(cat ip_ec2.txt)
ssh -D 9999 -fNCq -i ~/.ssh/id_rsa ec2-user@$ip_ec2
