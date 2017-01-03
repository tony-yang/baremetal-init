# devinit
Initialize a new dev box with essential tools to start development

This code is developed on Ubuntu and only tested on Ubuntu-based system
It is assumed that the following tools are available when the OS was installed:
- Bash
- Git

Run `./init-chef` to install ChefDK and update the System Ruby to the Chef embedded Ruby
Then go into the cookbooks directory, and run `chef-client --local-mode --override-runlist install_docker_cookbook` to install the Docker engine and compose

```
./init-chef
cd cookbooks
chef-client --local-mode --override-runlist install_docker_cookbook
```

## Dev Guide
For the cookbook development, run `rake`
The following will be tested by default
- `rubocop` to run the Ruby style checker
- `foodcritic` to run the Chef style checker
- `chef exec rspec spec` to run the unit test
