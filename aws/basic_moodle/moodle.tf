resource "aws_instance" "moodle_quick" {
  ami           = "ami-0cebb45b34604efb8"
  instance_type = "t2.micro"
  key_name	= aws_key_pair.daniel.key_name
  security_groups = [aws_security_group.sg.name]

 connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

tags = {
    Name = "Moodle server"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname moodle",
      "sudo yum install wget unzip httpd mariadb-server install git -y",
      "sudo amazon-linux-extras install php7.4 memcached1.5 -y",
      "sudo yum install php-gd php-pear php-mbstring php-xmlrpc php-soap php-intl php-zip php-zts php-xml php-opcache -y",
      "sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm",
      "sudo wget https://download.moodle.org/download.php/direct/stable38/moodle-3.8.4.tgz",
      "sudo tar -xzf moodle-3.8.4.tgz",
      "sudo rm -f moodle-3.8.4.tgz",
      "sudo mv moodle/* /var/www/html",
      "sudo rm -f moodle",
      "sudo chown -R apache:apache /var/www/html/",
      "sudo systemctl enable --now httpd",
      "sudo systemctl enable --now mariadb",
      "sudo mysql -e 'create database moodledb;'",
      "sudo mysql -e 'DROP DATABASE test'",
      "sudo mysql -e 'FLUSH PRIVILEGES'",
      "sudo mkdir /var/www/moodledata",
      "sudo chown apache:apache /var/www/moodledata",
      "sudo rm -f /etc/my.cnf ",
      "sudo echo '[mysqld]' >> my.cnf",
      "sudo echo 'innodb_file_format = Barracuda' >> my.cnf",
      "sudo echo 'innodb_file_per_table = 1' >> my.cnf",
      "sudo echo 'innodb_large_prefix' >> my.cnf",
      "sudo echo 'character-set-server = utf8mb4' >> my.cnf",
      "sudo echo 'collation-server = utf8mb4_unicode_ci' >> my.cnf",
      "sudo echo 'datadir=/var/lib/mysql' >> my.cnf",
      "sudo echo 'socket=/var/lib/mysql/mysql.sock' >> my.cnf",
      "sudo echo 'symbolic-links=0' >> my.cnf",
      "sudo echo ' ' >> my.cnf",
      "sudo echo '[mysqld_safe]' >> my.cnf",
      "sudo echo 'log-error=/var/log/mariadb/mariadb.log' >> my.cnf",
      "sudo echo 'pid-file=/var/run/mariadb/mariadb.pid' >> my.cnf",
      "sudo echo ' ' >> my.cnf",
      "sudo echo '!includedir /etc/my.cnf.d' >> my.cnf",
      "sudo cp my.cnf /etc",
      "sudo systemctl restart mariadb"

    ]
  }

}

