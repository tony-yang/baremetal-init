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

    it 'starts the cron service' do
      expect(chef_run).to start_service('cron')
    end
  end

  context 'On ubuntu with no nfs mount' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(
        platform: 'ubuntu',
        version: '16.04'
      ) do |node|
        node.override['owner'] = 'testuser'
        node.override['group'] = 'testgroup'
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
