#
# create configuration file /etc/exports.
#
class nfs::server::configure {
  concat { '/etc/exports':
    require => Class["nfs::server::${nfs::server::osfamily}"]
  }

  concat::fragment { 'nfs_exports_header':
    target  => '/etc/exports',
    content => "# Warning: File generated by the nfs::server puppet module\n",
    order   => 01;
  }

  if $nfs::server::nfs_v4 == true {
    include nfs::server::nfs_v4::configure
  }
}
