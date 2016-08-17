# == Class honeycomb::config
#
# This class handles honeycomb config changes.
# It's called from the honeycomb class.
#
class honeycomb::config {

  # Configuration of Honeycomb
  file { 'honeycomb.json':
    ensure  => file,
    path    => '/opt/honeycomb/config/honeycomb.json',
    # Set user:group owners
    owner   => 'honeycomb',
    group   => 'honeycomb',
    # Use a template to populate the content
    content => template('honeycomb/honeycomb.json.erb'),
  }

}
