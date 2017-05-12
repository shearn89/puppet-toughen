# Class: toughen::aide
#
# This class installs and schedules the AIDE software
# 
# Parameters
# ----------
# 
# * `package_ensure`
# Whether to install the AIDE package or not, defaults to install.
#
# * `check_hour`
# The hour on which to schedule the cron task, defaults to 5.
# 
# * `check_minute`
# The minute on which to schedule the cron task, defaults to 0.
# 
# * `initialize`
# Whether to run the slow 'init' step at install time or not.
# 
class toughen::aide (
  $package_ensure = 'installed',
  $check_hour = 5,
  $check_minute = 0,
  $initialize = true,
){

  if !($package_ensure in [ 'installed', 'absent' ]) {
    fail('package_ensure parameter must be "installed" or "absent"')
  }

  validate_integer($check_hour)
  validate_integer($check_minute)
  validate_bool($initialize)

  package { 'aide':
    ensure => $package_ensure,
  }

  if $package_ensure == 'installed' {
    cron { 'aide-check':
      command => '/usr/sbin/aide --check',
      user    => root,
      hour    => $check_hour,
      minute  => $check_minute,
      require => Package['aide'],
    }
  }

  if $initialize {
    exec { 'aide-init':
      command => '/sbin/aide --init && cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz',
      creates => '/var/lib/aide/aide.db.new.gz',
      timeout => 0,
      require => Package['aide'],
    }
  }

}
