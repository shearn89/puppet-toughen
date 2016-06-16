class toughen::firewall::post {
  # Jump to logging?
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
