# Class: toughen::sssd
# 
# Parameters
# ----------
#
class toughen::sssd (
  $touch_config = true,
  $memcache_timeout = 86400,
  $offline_cred_expiry = 1,
  $known_hosts_timeout = 86400,
){

  validate_integer($memcache_timeout)
  validate_integer($offline_cred_expiry)
  validate_integer($known_hosts_timeout)
  validate_bool($touch_config)

  package { 'sssd':
    ensure => 'installed',
  }

  if $touch_config {
    file { '/etc/sssd/sssd.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      require => Package['sssd'],
      before  => Augeas['sssd-security'],
    }
  }

  augeas { 'sssd-security':
    context => '/files/etc/sssd/sssd.conf/nss',
    changes => [ "set memcache_timeout ${memcache_timeout}",
      "set offline_credentials_expiration ${offline_cred_expiry}",
      "set ssh_known_hosts_timeout ${known_hosts_timeout}" ],
    require => Package['sssd'],
  }

  service { 'sssd':
    ensure    => 'running',
    enable    => true,
    subscribe => Augeas['sssd-security'],
  }

}
