default['gituser'] = 'git'
default['gitgroup'] = 'git'
default['gitpassword'] = ''
default['githome'] = ::File.join('/', 'home', node['gituser'])
default['gitrepo'] = ::File.join(node['githome'], 'repo')
default['nfsrepo'] = ::File.join('/', 'mnt', 'scm', 'repo')
# Enter the NFS IP address here to mount the NFS point
default['nfs'] = 'None'
default['nfsmount'] = ::File.join('/', 'mnt', 'scm')
