# Class: toughen
# ===========================
#
# Full description of class toughen here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'toughen':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class toughen (
  $posture = 'default'
){
  class { 'toughen::sudo': posture => $posture }
  contain toughen::sudo

  class { 'toughen::updates': posture => $posture }
  contain toughen::updates

  class { 'toughen::aide': posture => $posture }
  contain toughen::aide

  class { 'toughen::selinux': posture => $posture }
  contain toughen::selinux

  class { 'toughen::boot': posture => $posture }
  contain toughen::boot

  class { 'toughen::process': posture => $posture }
  contain toughen::process

  class { 'toughen::legacy_services': posture => $posture }
  contain toughen::legacy_services

  class { 'toughen::services': posture => $posture }
  contain toughen::services

  class { 'toughen::network': posture => $posture }
  contain toughen::network

  class { 'toughen::rsyslog': posture => $posture }
  contain toughen::rsyslog

  class { 'toughen::auditing': posture => $posture }
  contain toughen::auditing

  class { 'toughen::cron': posture => $posture }
  contain toughen::cron

  class { 'toughen::ssh': posture => $posture }
  contain toughen::ssh

  class { 'toughen::pam': posture => $posture }
  contain toughen::pam

  class { 'toughen::shadow': posture => $posture }
  contain toughen::shadow

  class { 'toughen::banners': posture => $posture }
  contain toughen::banners

  class { 'toughen::perms_owners': posture => $posture }
  contain toughen::perms_owners

  class { 'toughen::user_env': posture => $posture }
  contain toughen::user_env

  # Exceptions go here
  unless $posture == 'some_exception' {
    class { 'toughen::filesystem': posture => $posture }
    contain toughen::filesystem

    Firewall {
      before => Class['toughen::firewall::post'],
      require => Class['toughen::firewall::pre'],
    }
    contain toughen::firewall
  }

  # Posture-specific tweaks
  case $posture {
    'no_firewall': {
      class { '::firewall': ensure => 'stopped' }
    }
    'default': {}
    default: {
      fail("Security posture ${posture} not recognised!")
    }
  }
}
