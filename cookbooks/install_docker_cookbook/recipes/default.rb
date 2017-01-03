#
# Cookbook Name:: install_docker_cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

apt_update 'update_package_info' do
  action :update
end

apt_package 'ca_certificates' do
  package_name ['apt-transport-https', 'ca-certificates']
end

execute 'add_gpg' do
  command 'apt-key adv \
               --keyserver hkp://ha.pool.sks-keyservers.net:80 \
               --recv-keys 58118E89F3A912897C070ADBF76221572C52609D'
end

execute 'add_docker_repo' do
  command 'echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" \
               | sudo tee /etc/apt/sources.list.d/docker.list'
end

apt_update 'update_docker_package' do
  action :update
end

apt_package 'install_linux_image' do
  package_name ['linux-image-extra-4.4.0-36-generic', 'linux-image-extra-virtual']
end

apt_package 'docker-engine'

service 'docker' do
  action :start
end
