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
class toughen::aide (
  $package_ensure = 'installed',
  $check_hour = 5,
  $check_minute = 0
){

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

}
