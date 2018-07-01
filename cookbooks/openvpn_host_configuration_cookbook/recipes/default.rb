#
# Cookbook Name:: openvpn_host_configuration_cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

apt_update 'update_package_info' do
  action :update
end
