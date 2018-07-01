test: build-container test-base-ubuntu-setup-cookbook test-install-docker-cookbook test-install-git-server-cookbook

build-container:
	docker build -t baremetal-init .

test-base-ubuntu-setup-cookbook:
	docker run --rm baremetal-init bash -c "cd cookbooks/base_ubuntu_setup_cookbook && bundle install && rake"

test-install-docker-cookbook:
	docker run --rm baremetal-init bash -c "cd cookbooks/install_docker_cookbook && bundle install && rake"

test-install-git-server-cookbook:
	docker run --rm baremetal-init bash -c "cd cookbooks/install_git_server_cookbook && bundle install && rake"
