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
class toughen {

  class { 'toughen::sudo': }
  contain toughen::sudo

  class { 'toughen::updates': }
  contain toughen::updates

  class { 'toughen::aide': }
  contain toughen::aide

  class { 'toughen::selinux': }
  contain toughen::selinux

  class { 'toughen::boot': }
  contain toughen::boot

  class { 'toughen::process': }
  contain toughen::process

  class { 'toughen::legacy_services': }
  contain toughen::legacy_services

  class { 'toughen::services': }
  contain toughen::services

  class { 'toughen::network': }
  contain toughen::network

  class { 'toughen::rsyslog': }
  contain toughen::rsyslog

  class { 'toughen::auditing': }
  contain toughen::auditing

  class { 'toughen::cron': }
  contain toughen::cron

  class { 'toughen::ssh': }
  contain toughen::ssh

  class { 'toughen::pam': }
  contain toughen::pam

  class { 'toughen::shadow': }
  contain toughen::shadow

  class { 'toughen::banners': }
  contain toughen::banners

  class { 'toughen::perms_owners': }
  contain toughen::perms_owners

  class { 'toughen::user_env': }
  contain toughen::user_env

  class { 'toughen::filesystem': }
  contain toughen::filesystem

  Firewall {
    before => Class['toughen::firewall::post'],
    require => Class['toughen::firewall::pre'],
  }
  class { 'toughen::firewall': }
  contain toughen::firewall

}
