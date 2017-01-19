default['owner'] = 'yst'
default['group'] = 'yst'
default['homedir'] = ::File.join('/', 'home', node['owner'])
# Enter the NFS IP address here to mount the NFS point
default['nfs'] = 'None'
default['nfsmount'] = '/mnt/scm'
