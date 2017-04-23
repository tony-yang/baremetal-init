#
# Cookbook:: base_ubuntu_setup_cookbook
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

apt_update 'update_ubuntu_repo' do
  action :update
end

apt_package 'openssh-server' do
  action :upgrade
end

apt_package 'vim' do
  action :upgrade
end

cookbook_file ::File.join(node['homedir'], '.vimrc') do
  source 'vimrc'
  owner node['owner']
  group node['group']
  mode '0664'
end

cookbook_file ::File.join(node['homedir'], '.screenrc') do
  source 'screenrc'
  owner node['owner']
  group node['group']
  mode '0664'
end

service 'cron' do
  action :start
end

execute 'ufw_reset' do
  command 'ufw --force reset'
end

execute 'deny_all_incoming' do
  command 'ufw default deny incoming'
end

execute 'allow_ssh' do
  command 'ufw allow ssh'
end

execute 'allow_mysql' do
  command 'ufw allow 3306/tcp'
end

execute 'allow_redis' do
  command 'ufw allow 6379/tcp'
end

execute 'allow_datacollector' do
  command 'ufw allow 8000/tcp'
end

execute 'enable_ufw' do
  command 'ufw --force enable'
end
