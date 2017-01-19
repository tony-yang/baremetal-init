# install_git_server_cookbook

This cookbook installs and configures a Git server on a new box as the central Git repository for code sharing.

## Requirement
This cookbook requires that we generate our own RSA key.

This cookbook requires that the server has a NFS mount to provide better repo redundancy. The remote repo will be stored on a NFS so that we have multiple copies of the source in case a dev machine fails.

## Development

First run `bundle install` to install all the required RubyGems. Then run `rake` to execute the spec tests.
