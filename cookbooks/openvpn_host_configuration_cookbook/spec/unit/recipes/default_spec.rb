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

    it 'updates the sysctl conf' do
      expect(chef_run).to create_cookbook_file('/etc/sysctl.conf').with(
        source: 'sysctl.conf.16.04',
        owner: 'root',
        group: 'root',
        mode: '0644'
      )
    end

    it 'updates the sysctl' do
      expect(chef_run).to run_execute('update sysctl')
        .with(command: 'sysctl -p')
    end

    it 'enables the openvpn port' do
      expect(chef_run).to run_execute('allow_openvpn')
        .with(command: 'ufw allow 1194/tcp')
    end

    it 'updates the ufw rule' do
      expect(chef_run).to run_execute('update the ufw rule')
        .with(command: 'ufw reload')
    end
  end

  context 'For Ubuntu 18.04 LTS platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '18.04')
      runner.converge(described_recipe)
    end

    it 'updates the sysctl conf' do
      expect(chef_run).to create_cookbook_file('/etc/sysctl.conf').with(
        source: 'sysctl.conf.18.04'
      )
    end
  end
end
