test: build-container test-base-ubuntu-setup-cookbook test-gcp-ubuntu-renovation-cookbook test-install-docker-cookbook test-install-git-server-cookbook test-openvpn-host-configuration-cookbook

build-container:
	docker build -t baremetal-init .

test-base-ubuntu-setup-cookbook:
	docker run --rm baremetal-init bash -c "cd cookbooks/base_ubuntu_setup_cookbook && bundle install && rake"

test-gcp-ubuntu-renovation-cookbook:
	docker run --rm baremetal-init bash -c "cd cookbooks/gcp_ubuntu_renovation_cookbook && bundle install && rake"

test-install-docker-cookbook:
	docker run --rm baremetal-init bash -c "cd cookbooks/install_docker_cookbook && bundle install && rake"

test-install-git-server-cookbook:
	docker run --rm baremetal-init bash -c "cd cookbooks/install_git_server_cookbook && bundle install && rake"

test-openvpn-host-configuration-cookbook:
	docker run --rm baremetal-init bash -c "cd cookbooks/openvpn_host_configuration_cookbook && bundle install && rake"
