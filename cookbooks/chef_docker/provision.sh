#!/bin/bash

curl -L https://www.opscode.com/chef/install.sh | sudo bash

cd /home/ubuntu/cookbooks/chef_docker
sudo berks vendor /home/ubuntu/cookbooks/

cd /home/ubuntu
echo "Provisioning with chef-zero"
sudo chef-client -z -o chef_docker