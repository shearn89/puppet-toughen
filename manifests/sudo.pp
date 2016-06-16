class toughen::sudo (
  $posture = 'default'
){

  package { 'sudo':
    ensure => installed,
  }

  file { '/etc/sudoers':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('toughen/sudoers.erb'),
    require => Package['sudo'],
  }

}
