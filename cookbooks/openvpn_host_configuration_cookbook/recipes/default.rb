#
# Cookbook Name:: openvpn_host_configuration_cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

if node['platform_version'] <= '16.04'
  apt_update 'update_ubuntu_repo' do
    action :update
  end

  apt_package 'dnsutils' do
    action :upgrade
  end
end

cookbook_file '/etc/sysctl.conf' do
  source "sysctl.conf.#{node['platform_version']}"
  owner 'root'
  group 'root'
  mode '0644'
end

execute 'update sysctl' do
  command 'sysctl -p'
end

cookbook_file '/etc/default/ufw' do
  source 'ufw'
  owner 'root'
  group 'root'
  mode '0644'
end

execute 'allow_openvpn' do
  command 'ufw allow 1194/tcp'
end

execute 'update the ufw rule' do
  command 'ufw reload'
end
