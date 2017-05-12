# Class: toughen::sssd
# 
# Parameters
# ----------
#
class toughen::sssd (
  $memcache_timeout = 86400,
  $offline_cred_expiry = 1,
  $known_hosts_timeout = 86400,
){

  validate_integer($memcache_timeout)
  validate_integer($offline_cred_expiry)
  validate_integer($known_hosts_timeout)

  package { 'sssd':
    ensure => 'installed',
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
