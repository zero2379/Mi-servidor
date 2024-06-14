#!/bin/bash
BASE_DIR="/workspaces"
folders=("$BASE_DIR"/*/)

if [ ${#folders[@]} -eq 1 ]; then
    folder_name=$(basename "${folders[0]}")
fi

NEW_FTP_DIR="$BASE_DIR/$folder_name/"
sudo apt-get update -y
sudo apt-get install -y vsftpd
if id "ftp" &>/dev/null; then
    echo "User ftp already exists"
else
    sudo adduser --disabled-password --gecos "" ftp
fi

sudo bash -c 'cat > /etc/vsftpd.conf' << EOF
listen=YES
write_enable=YES
listen_ipv6=NO
local_enable=NO
anonymous_enable=YES
anon_root=$NEW_FTP_DIR
anon_upload_enable=YES
anon_mkdir_write_enable=YES
allow_writeable_chroot=YES
chown_uploads=YES
chown_username=ftp
EOF


sudo chmod a-w $NEW_FTP_DIR
sudo chown ftp:ftp $NEW_FTP_DIR
sudo service vsftpd restart
echo "Servidor ftp configurado."
