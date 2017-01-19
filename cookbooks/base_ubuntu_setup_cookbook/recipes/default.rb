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

mount node['nfsmount'] do
  device "#{node['nfs']}:/scm"
  fstype 'nfs'
  options 'rw,auto,nofail,noatime,nolock,tcp'
  action [:mount, :enable]
  only_if { node['nfs'].casecmp('none') != 0 }
end
