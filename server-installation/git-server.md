# Git Server Installation Guide

Login to the NFS server, and give permission to the new machine where the SCM repo will be mounted

Follow the README of this repo: https://github.com/tony-yang/baremetal-init

Execute the `install_git_server` cookbook. Remember to update the credential.

For each git user:

- Create a RSA key-pair on the local machine: `ssh-keygen`
- Connect to the git server from the local box, copy the public key to the authorized_keys file under `/home/git/.ssh`
- If `/home/git/.ssh` does not exist
```
mkdir /home/git/.ssh
chmod 700 /home/git/.ssh
cd .ssh
touch authorized_keys
chmod 600 authorized_keys

# Copy at least one public key into the authorized_keys first

chown -R git:git /home/git/.ssh  ## Make sure we do the above first, or we will be locked out!
```

## Create a new repo
Login to the Git server using the Git credential
```
cd repo
mkdir <REPO_NAME>.git
cd <REPO_NAME>.git/
git init --bare
```

## Clone a remote repo from the Git Server
```
git clone git@<SERVER_IP>:/home/git/repo/<REPO_NAME>.git
```
