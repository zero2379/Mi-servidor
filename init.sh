#!/bin/bash
sudo service vsftpd start
ssh -o StrictHostKeyChecking=no -R 0:localhost:21 serveo.net > ftp_ip.txt &
