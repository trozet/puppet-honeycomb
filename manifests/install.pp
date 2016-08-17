# == Class honeycomb::install
#
# Manages the installation of OpenDaylight Honeycomb Agent.
#
# There are two install methods: RPM-based and tarball-based. The resulting
# system state should be functionally equivalent, but we have to do more
# work here for the tarball method (would normally be handled by the RPM).
#
class honeycomb::install {

  if ( $::osfamily != 'RedHat' ) {
    fail("Unsupported OS family: ${::osfamily}")
  }

  # Install the Honeycomb RPM
  package { 'honeycomb':
    ensure   => present,
    source   => 'https://github.com/marosmars/files/raw/master/honeycomb-1.0.0-99.noarch.rpm',
    provider => rpm,
  }

}
