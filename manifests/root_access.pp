class toughen::root_access (
  $allowed_tty = [],
){
  file { '/etc/securetty':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('toughen/securetty.erb'),
  }
}
