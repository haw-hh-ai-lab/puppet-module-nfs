class nfs::client::debian::install {

  package { 'rpcbind':
    ensure => present,
  }

  Package['rpcbind'] -> Service['rpcbind']


  package { ['nfs-common', 'nfs4-acl-tools']:
    ensure => present,
  }

}
