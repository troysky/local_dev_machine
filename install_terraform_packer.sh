#!/usr/bin/env bash
# Script prerequisite > install jq > https://stedolan.github.io

cd ~

terraform_url=$(curl https://releases.hashicorp.com/index.json | jq '{terraform}' | egrep "linux.*amd64" | egrep -v "beta" | sort --version-sort -r | head -1 | awk -F[\"] '{print $4}')
packer_url=$(curl https://releases.hashicorp.com/index.json | jq '{packer}' | egrep "linux.*amd64" | egrep -v "beta" | sort --version-sort -r | head -1 | awk -F[\"] '{print $4}')

# Create a move into directory.
cd
mkdir packer
mkdir terraform && cd $_

# Download Terraform. URI: https://www.terraform.io/downloads.html
echo "Downloading $terraform_url."
curl -o terraform.zip $terraform_url
# Unzip and install
unzip terraform.zip

# Change directory to Packer
cd ~/packer

# Download Packer. URI: https://www.packer.io/downloads.html
echo "Downloading $packer_url."
curl -o packer.zip $packer_url
# Unzip and install
unzip packer.zip

# For Linux
echo '
# Terraform & Packer Paths.
export PATH=~/terraform/:~/packer/:$PATH
' >>~/.bashrc

source ~/.bashrc
