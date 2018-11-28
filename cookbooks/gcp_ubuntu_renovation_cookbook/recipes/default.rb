#
# Cookbook:: gcp_ubuntu_renovation_cookbook
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_update 'update_ubuntu_repo' do
  action :update
end

%w(vim make ufw).each do |pkg|
  apt_package pkg do
    action :upgrade
  end
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

execute 'allow_http' do
  command 'ufw allow 80/tcp'
end

execute 'enable_ufw' do
  command 'ufw --force enable'
end
