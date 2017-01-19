default['gituser'] = 'git'
default['gitgroup'] = 'git'
default['gitpassword'] = ''
default['githome'] = ::File.join('/', 'home', node['gituser'])
default['gitrepo'] = ::File.join(node['githome'], 'repo')
default['nfsrepo'] = ::File.join('/', 'mnt', 'scm', 'repo')
