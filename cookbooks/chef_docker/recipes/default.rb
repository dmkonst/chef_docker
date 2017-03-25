#
# Cookbook:: chef_docker
# Recipe:: default
#
# Copyright:: 2017, DK, All Rights Reserved.
docker_service 'default' do
  action [:create, :start]
end

docker_image 'dmkonst/fun_with_jenkins' do
  action :pull
end

docker_container 'test_jenkins_image' do
  repo 'dmkonst/fun_with_jenkins'
  port '8080:8080'
  action :run
end
