#
# Cookbook Name:: openvpn_host_configuration_cookbook
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'openvpn_host_configuration_cookbook::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'updates package information' do
      expect(chef_run).to update_apt_update('update_package_info')
    end
  end
end
