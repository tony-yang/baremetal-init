#
# Cookbook Name:: install_docker_cookbook
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'install_docker_cookbook::default' do
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

    it 'installs certificates package' do
      expect(chef_run).to upgrade_apt_package('ca_certificates')
        .with(package_name: ['apt-transport-https', 'ca-certificates'])
    end

    it 'adds a GPG key' do
      expect(chef_run).to run_execute('add_gpg')
        .with(command: 'apt-key adv \
               --keyserver hkp://ha.pool.sks-keyservers.net:80 \
               --recv-keys 58118E89F3A912897C070ADBF76221572C52609D')
    end

    it 'adds docker repo' do
      expect(chef_run).to run_execute('add_docker_repo')
        .with(command: 'echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" \
               | sudo tee /etc/apt/sources.list.d/docker.list')
    end

    it 'updates docker package information' do
      expect(chef_run).to update_apt_update('update_docker_package')
    end

    it 'installs linux image' do
      expect(chef_run).to install_apt_package('install_linux_image')
        .with(package_name: ['linux-image-extra-4.4.0-36-generic', 'linux-image-extra-virtual'])
    end

    it 'installs the docker engine' do
      expect(chef_run).to upgrade_apt_package('docker-engine')
    end

    it 'starts the docker service' do
      expect(chef_run).to start_service('docker')
    end

    it 'installs the docker compose' do
      expect(chef_run).to create_remote_file('/usr/local/bin/docker-compose')
        .with(mode: '0755')
    end
  end
end
