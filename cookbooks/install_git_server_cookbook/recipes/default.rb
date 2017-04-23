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

mount node['nfsmount'] do
  device "#{node['nfs']}:/scm"
  fstype 'nfs'
  options 'rw,auto,nofail,noatime,nolock,tcp'
  action [:mount, :enable]
  only_if { node['nfs'].casecmp('none') != 0 }
end

group node['gitgroup']

user node['gituser'] do
  gid node['gitgroup']
  home node['githome']
  manage_home TRUE
  shell '/bin/bash'
  password node['gitpassword']
end

link node['gitrepo'] do
  to node['nfsrepo']
end
