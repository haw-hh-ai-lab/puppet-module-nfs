# # currently no client support is provided for darwin
#
class nfs::client::darwin (
  $nfs_v4 = false,
  $nfs_v4_idmap_domain = undef
) {
  fail('NFS client is not supported on Darwin')
}
