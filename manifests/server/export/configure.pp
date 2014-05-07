#
# add configuration fragment to /etc/exports for individual export
#
define nfs::server::export::configure (
  $ensure = 'present',
  $clients
) {

  if $ensure != 'absent' {
    $line = "${name} ${clients}\n"

    concat::fragment{
      "${name}":
        target  => '/etc/exports',
        content => "${line}"
    }
  }
}
