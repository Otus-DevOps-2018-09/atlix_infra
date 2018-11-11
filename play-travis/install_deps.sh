#!/bin/bash

set -e

echo "### Installing dependencies for tests ###"
pip -q install --upgrade pip
pip -q install ansible-lint==3.5.1

cd /tmp

wget -q https://releases.hashicorp.com/packer/1.3.2/packer_1.3.2_linux_amd64.zip && unzip packer_1.3.2_linux_amd64.zip -d /usr/sbin
wget -q https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip  && unzip terraform_0.11.10_linux_amd64.zip -d /usr/sbin
wget -q https://github.com/wata727/tflint/releases/download/v0.7.2/tflint_linux_amd64.zip && unzip tflint_linux_amd64.zip -d /usr/sbin

rm -f *.zip

echo "### Done ###"
