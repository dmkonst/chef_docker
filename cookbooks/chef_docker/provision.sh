#!/bin/bash

curl -L https://www.opscode.com/chef/install.sh | sudo bash


echo "setting up berkshelf"
sudo apt-get update
sudo apt-get install gcc make -y

sudo /opt/chef/embedded/bin/gem install berkshelf --no-ri --no-rdoc


echo "getting docker cookbook wth from supermarket"
cd /home/ubuntu/cookbooks/chef_docker
sudo /opt/chef/embedded/bin/berks vendor /home/ubuntu/cookbooks/


echo "Provisioning with chef-zero"
cd /home/ubuntu
sudo chef-client -z -o chef_docker