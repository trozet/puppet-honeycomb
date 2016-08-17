# == Class: honeycomb
#
# OpenDaylight Honeycomb Agent
#
# === Parameters
# [*rest_port *]
#   Port for Honeycomb REST interface to listen on.
#
# [*websocket_rest_port *]
#   Port for Honeycomb REST interface to listen on for websocket connections.
#
# [*user *]
#   Username to configure in honeycomb.
#
# [*password *]
#   Password to configure in honeycomb.
#
class honeycomb (
  $rest_port = $::honeycomb::params::rest_port,
  $websocket_rest_port = $::honeycomb::params::websocket_rest_port,
  $user = $::honeycomb::params::user,
  $password = $::honeycomb::params::password,
) inherits ::honeycomb::params {

  # Validate OS family
  case $::osfamily {
    'RedHat': {}
    'Debian': {
        warning('Debian has limited support, is less stable, less tested.')
    }
    default: {
        fail("Unsupported OS family: ${::osfamily}")
    }
  }

  # Validate OS
  case $::operatingsystem {
    centos, redhat: {
      if $::operatingsystemmajrelease != '7' {
        # RHEL/CentOS versions < 7 not supported as they lack systemd
        fail("Unsupported OS: ${::operatingsystem} ${::operatingsystemmajrelease}")
      }
    }
    fedora: {
      # Fedora distros < 22 are EOL as of 2015-12-01
      # https://fedoraproject.org/wiki/End_of_life
      if $::operatingsystemmajrelease < '22' {
        fail("Unsupported OS: ${::operatingsystem} ${::operatingsystemmajrelease}")
      }
    }
    ubuntu: {
      if $::operatingsystemmajrelease != '14.04' {
        # Only tested on 14.04
        fail("Unsupported OS: ${::operatingsystem} ${::operatingsystemmajrelease}")
      }
    }
    default: {
      fail("Unsupported OS: ${::operatingsystem}")
    }
  }

  class { '::honeycomb::install': } ->
  class { '::honeycomb::config': } ~>
  class { '::honeycomb::service': } ->
  Class['::honeycomb']
}
