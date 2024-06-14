#!/bin/bash

NEW_FTP_DIR="/workspaces/*/"
sudo apt-get update -y
sudo apt-get install -y vsftpd
if id "ftp" &>/dev/null; then
    echo "User ftp already exists"
else
    sudo adduser --disabled-password --gecos "" ftp
fi

sudo bash -c 'cat > /etc/vsftpd.conf' << EOF
listen=YES
anonymous_enable=YES
local_enable=NO
anon_root=$NEW_FTP_DIR
write_enable=YES
listen_ipv6=NO
EOF

sudo mkdir -p $NEW_FTP_DIR
sudo chown ftp:ftp $NEW_FTP_DIR
sudo service vsftpd restart
echo "Servidor ftp configurado."
