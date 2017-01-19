#
# Cookbook Name:: install_git_server_cookbook
# Spec:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'install_git_server_cookbook::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(
        platform: 'ubuntu',
        version: '16.04'
      ) do |node|
        node.override['gituser'] = 'testuser'
        node.override['gitgroup'] = 'testgroup'
        node.override['gitpassword'] = 'password'
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'updates package information' do
      expect(chef_run).to update_apt_update('update_package_info')
    end

    it 'installs the git-core package' do
      expect(chef_run).to upgrade_apt_package('git-core')
    end

    it 'creates a new git group' do
      expect(chef_run).to create_group('testgroup')
    end

    it 'creates new git user' do
      expect(chef_run).to create_user('testuser').with(
        gid: 'testgroup',
        home: '/home/testuser',
        manage_home: TRUE,
        shell: '/bin/bash',
        password: 'password'
      )
    end
  end
end
