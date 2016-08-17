# == Class honeycomb::service
#
# Starts the Honeycomb Service.
#
class honeycomb::service {
  service { 'honeycomb':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
