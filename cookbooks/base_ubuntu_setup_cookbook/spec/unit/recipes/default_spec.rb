#
# Cookbook:: base_ubuntu_setup_cookbook
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'base_ubuntu_setup_cookbook::default' do
  context 'On ubuntu with override owner, group, and nfs' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(
        platform: 'ubuntu',
        version: '16.04'
      ) do |node|
        node.override['owner'] = 'testuser'
        node.override['group'] = 'testgroup'
        node.override['nfs'] = '123.456.7.8'
        node.override['nfsmount']['log'] = '/test/logmount'
        node.override['nfsmount']['db'] = '/test/dbmount'
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'updates the ubuntu repo' do
      expect(chef_run).to update_apt_update('update_ubuntu_repo')
    end

    it 'installs sshd server' do
      expect(chef_run).to upgrade_apt_package('openssh-server')
    end

    it 'installs vim' do
      expect(chef_run).to upgrade_apt_package('vim')
    end

    it 'installs the nfs-common package' do
      expect(chef_run).to upgrade_apt_package('nfs-common')
    end

    it 'creates the vim profile' do
      expect(chef_run).to create_cookbook_file('/home/testuser/.vimrc').with(
        source: 'vimrc',
        owner: 'testuser',
        group: 'testgroup',
        mode: '0664'
      )
    end

    it 'creates the screen profile' do
      expect(chef_run).to create_cookbook_file('/home/testuser/.screenrc').with(
        source: 'screenrc',
        owner: 'testuser',
        group: 'testgroup',
        mode: '0664'
      )
    end

    it 'creates log mount directory' do
      expect(chef_run).to create_directory('/test/logmount').with(
        user: 'testuser',
        group: 'testgroup',
        mode: '0755'
      )
    end

    it 'mounts the NFS log directory' do
      expect(chef_run).to mount_mount('/test/logmount').with(
        device: '123.456.7.8:/log',
        fstype: 'nfs',
        options: %w(rw auto nofail noatime nolock tcp)
      )
      expect(chef_run).to enable_mount('/test/logmount').with(
        device: '123.456.7.8:/log',
        fstype: 'nfs',
        options: %w(rw auto nofail noatime nolock tcp)
      )
    end

    it 'creates db mount directory' do
      expect(chef_run).to create_directory('/test/dbmount').with(
        user: 'testuser',
        group: 'testgroup',
        mode: '0755'
      )
    end

    it 'mounts the NFS db directory' do
      expect(chef_run).to mount_mount('/test/dbmount').with(
        device: '123.456.7.8:/db',
        fstype: 'nfs',
        options: %w(rw auto nofail noatime nolock tcp)
      )
      expect(chef_run).to enable_mount('/test/dbmount').with(
        device: '123.456.7.8:/db',
        fstype: 'nfs',
        options: %w(rw auto nofail noatime nolock tcp)
      )
    end

    it 'starts the cron service' do
      expect(chef_run).to start_service('cron')
    end

    it 'resets the ufw firewall and rules' do
      expect(chef_run).to run_execute('ufw_reset')
        .with(command: 'ufw --force reset')
    end

    it 'deny all incoming connection' do
      expect(chef_run).to run_execute('deny_all_incoming')
        .with(command: 'ufw default deny incoming')
    end

    it 'enables SSH ports' do
      expect(chef_run).to run_execute('allow_ssh')
        .with(command: 'ufw allow ssh')
    end

    it 'enables mysql ports' do
      expect(chef_run).to run_execute('allow_mysql')
        .with(command: 'ufw allow 3306/tcp')
    end

    it 'enables redis ports' do
      expect(chef_run).to run_execute('allow_redis')
        .with(command: 'ufw allow 6379/tcp')
    end

    it 'enables datacollector ports' do
      expect(chef_run).to run_execute('allow_datacollector')
        .with(command: 'ufw allow 8000/tcp')
    end

    it 'enables the firewall' do
      expect(chef_run).to run_execute('enable_ufw')
        .with(command: 'ufw --force enable')
    end
  end

  context 'On ubuntu without nfs override' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(
        platform: 'ubuntu',
        version: '16.04'
      ) do |node|
        node.override['owner'] = 'testuser'
        node.override['group'] = 'testgroup'
        node.override['nfsmount']['log'] = '/test/logmount'
        node.override['nfsmount']['db'] = '/test/dbmount'
      end
      runner.converge(described_recipe)
    end

    it 'does not mount the NFS log directory' do
      expect(chef_run).to_not mount_mount('/test/logmount').with(
        device: '123.456.7.8:/log',
        fstype: 'nfs',
        options: %w(rw auto nofail noatime nolock tcp)
      )
      expect(chef_run).to_not enable_mount('/test/logmount').with(
        device: '123.456.7.8:/log',
        fstype: 'nfs',
        options: %w(rw auto nofail noatime nolock tcp)
      )
    end

    it 'does not mount the NFS db directory' do
      expect(chef_run).to_not mount_mount('/test/dbmount').with(
        device: '123.456.7.8:/db',
        fstype: 'nfs',
        options: %w(rw auto nofail noatime nolock tcp)
      )
      expect(chef_run).to_not enable_mount('/test/dbmount').with(
        device: '123.456.7.8:/db',
        fstype: 'nfs',
        options: %w(rw auto nofail noatime nolock tcp)
      )
    end
  end
end
