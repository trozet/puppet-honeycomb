# == Class honeycomb::params
#
# This class manages the default params for the honeycomb class.
#
class honeycomb::params {
  $rest_port = '8181'
  $websocket_rest_port = '7779'
  $user = 'admin'
  $password = 'admin'
}
