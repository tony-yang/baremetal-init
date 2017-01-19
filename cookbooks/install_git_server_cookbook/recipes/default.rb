#
# Cookbook Name:: install_git_server_cookbook
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
apt_update 'update_package_info' do
  action :update
end

apt_package 'git-core' do
  action :upgrade
end

group node['gitgroup']

user node['gituser'] do
  gid node['gitgroup']
  home node['githome']
  manage_home TRUE
  shell '/bin/bash'
  password node['gitpassword']
end
