#!/bin/bash

sudo apt update -y

echo "installing java"
sudo apt-get install openjdk-8-jdk -y
sleep 10
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update -y

echo "installing jenkins"

sudo apt install jenkins -y

sleep 120

systemctl status jenkins



sudo ufw allow 8080

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

INSTANCENAME=`curl "http://metadata.google.internal/computeMetadata/v1/instance/name" -H "Metadata-Flavor: Google"`
PASSFILE=jenkins-initial-admin-pass-${INSTANCENAME}
sudo cp /var/lib/jenkins/secrets/initialAdminPassword /var/lib/jenkins/secrets/${PASSFILE}

sudo gsutil cp /var/lib/jenkins/secrets/${PASSFILE} gs://uob-tv-infra/secrets