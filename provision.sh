#!/usr/bin/env bash
# Bail if any command we execute returns a non-zero exit code
set -e

apt update
apt upgrade -y
apt install -y zip unzip apt-transport-https ca-certificates curl software-properties-common

# Start Install Go

curl -OLs https://go.dev/dl/go1.19.6.linux-amd64.tar.gz
echo "e3410c676ced327aec928303fef11385702a5562fd19d9a1750d5a2979763c3d go1.19.6.linux-amd64.tar.gz" | sha256sum --check --status
sudo tar -C /usr/local -xvf go1.19.6.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> /home/devoverlord/.profile
source /home/devoverlord/.profile
go version
rm go1.19.6.linux-amd64.tar.gz

# Go Installed


wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform


curl -OLs "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
unzip -q awscli-exe-linux-x86_64.zip
sudo ./aws/install
aws --version
rm -rf aws awscli-exe-linux-x86_64.zip

ssh-keygen -b 4096 -t rsa -f /home/devoverlord/.ssh/id_rsa -q -N ""
cat /home/devoverlord/.ssh/id_rsa.pub
eval $(ssh-agent -s)
ssh-add /home/devoverlord/.ssh/id_rsa
