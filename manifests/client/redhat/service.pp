#
# Shamefully stolen from https://github.com/frimik/puppet-nfs
# refactored a bit
#
class nfs::client::redhat::service {
  Service {
    require => Class['nfs::client::redhat::configure']
  }

  $os_major = $nfs::client::redhat::params::osmajor

  service { 'nfslock':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => $os_major ? {
      6       => Service['rpcbind'],
      5       => [
        Package['portmap'],
        Package['nfs-utils']],
      default => fail("Redhat major version ${os_major} not supported"),
    },
  }

  service { 'netfs':
    enable  => true,
    require => $os_major ? {
      6       => Service['nfslock'],
      5       => [
        Service['portmap'],
        Service['nfslock']],
      default => fail("Redhat major version ${os_major} not supported"),
    },
  }

  case $os_major {
    6       : {
      service { 'rpcbind':
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => [
          Package['rpcbind'], Package['nfs-utils']],
      }
    }
    5       : {
      service { 'portmap':
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => [
          Package['portmap'], Package['nfs-utils']],
      }
    }
    default : {
      fail("Redhat major version ${os_major} not supported")
    }
  }
}
