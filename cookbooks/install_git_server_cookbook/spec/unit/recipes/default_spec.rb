#
# Cookbook Name:: install_git_server_cookbook
# Spec:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'install_git_server_cookbook::default' do
  context 'On ubuntu with git users and nfs override' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(
        platform: 'ubuntu',
        version: '16.04'
      ) do |node|
        node.override['gituser'] = 'testuser'
        node.override['gitgroup'] = 'testgroup'
        node.override['gitpassword'] = 'password'
        node.override['nfsrepo'] = 'actual'
        node.override['nfs'] = '123.456.7.8'
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'updates package information' do
      expect(chef_run).to update_apt_update('update_package_info')
    end

    it 'mounts the NFS cloud drive' do
      expect(chef_run).to mount_mount('/mnt/scm').with(
        device: '123.456.7.8:/scm',
        fstype: 'nfs',
        options: %w(rw auto nofail noatime nolock tcp)
      )
      expect(chef_run).to enable_mount('/mnt/scm').with(
        device: '123.456.7.8:/scm',
        fstype: 'nfs',
        options: %w(rw auto nofail noatime nolock tcp)
      )
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

    it 'creates a symlink to the NFS' do
      expect(chef_run).to create_link('/home/testuser/repo').with(
        to: 'actual'
      )
    end
  end

  context 'On ubuntu without nfs override' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(
        platform: 'ubuntu',
        version: '16.04'
      ) do |node|
        node.override['gituser'] = 'testuser'
        node.override['gitgroup'] = 'testgroup'
        node.override['gitpassword'] = 'password'
        node.override['nfsrepo'] = 'actual'
      end
      runner.converge(described_recipe)
    end

    it 'does not mount the NFS cloud drive' do
      expect(chef_run).to_not mount_mount('/mnt/scm').with(
        device: '123.456.7.8:/scm',
        fstype: 'nfs',
        options: %w(rw auto nofail noatime nolock tcp)
      )
      expect(chef_run).to_not enable_mount('/mnt/scm').with(
        device: '123.456.7.8:/scm',
        fstype: 'nfs',
        options: %w(rw auto nofail noatime nolock tcp)
      )
    end
  end
end
