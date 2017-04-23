# Baremetal Init
Initialize a new Bare metal box with essential tools to start development or production use

This code is developed for Ubuntu Server and only tested on Ubuntu-based system.
It was assumed that the following tools are available when the OS was installed:
- Bash
- Git

Run `./init-chef` to install ChefDK and update the System Ruby to the Chef embedded Ruby
Then go into the cookbooks directory, and run `chef-client --local-mode --override-runlist [select cookbook to run]` to install the Docker engine and compose

Example:
```
./init-chef
cd cookbooks
sudo chef-client --local-mode --override-runlist base_ubuntu_setup_cookbook
sudo chef-client --local-mode --override-runlist install_docker_cookbook
```

After the initial setup, there are essential Dockerfiles to kick start development

Example:
```
cd Dockerfiles/ubuntu-dev
sudo docker build -t ubuntu-dev .
sudo docker run -it ubuntu-dev
```

## Dev Guide
For the cookbook development, run `bundle install` to install the essential RubyGems library. Then run `rake`
The following will be tested by default
- `rubocop` to run the Ruby style checker
- `foodcritic` to run the Chef style checker
- `chef exec rspec spec` to run the unit test
