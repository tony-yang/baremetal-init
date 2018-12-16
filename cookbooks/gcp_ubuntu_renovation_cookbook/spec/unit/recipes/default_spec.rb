#
# Cookbook:: gcp_ubuntu_renovation_cookbook
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'gcp_ubuntu_renovation_cookbook::default' do
  context 'On ubuntu with override owner and group' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(
        platform: 'ubuntu',
        version: '18.04'
      ) do |node|
        node.override['owner'] = 'testuser'
        node.override['group'] = 'testgroup'
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'updates the ubuntu repo' do
      expect(chef_run).to update_apt_update('update_ubuntu_repo')
    end

    it 'installs vim' do
      expect(chef_run).to upgrade_apt_package('vim')
    end

    it 'installs the make package' do
      expect(chef_run).to upgrade_apt_package('make')
    end

    it 'installs the ufw package' do
      expect(chef_run).to upgrade_apt_package('ufw')
    end

    it 'installs the curl package' do
      expect(chef_run).to upgrade_apt_package('curl')
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

    it 'enables http ports' do
      expect(chef_run).to run_execute('allow_http')
        .with(command: 'ufw allow 80/tcp')
    end

    it 'enables the firewall' do
      expect(chef_run).to run_execute('enable_ufw')
        .with(command: 'ufw --force enable')
    end
  end
end
