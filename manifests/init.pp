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

  # 1.1
  class { 'toughen::filesystem': }
  contain toughen::filesystem

  class { 'toughen::modprobe': }
  contain toughen::modprobe

  # 1.2
  class { 'toughen::updates': }
  contain toughen::updates

  # 1.3
  class { 'toughen::aide': }
  contain toughen::aide

  # 1.4
  class { 'toughen::boot': }
  contain toughen::boot

  # 1.5
  class { 'toughen::process': }
  contain toughen::process

  # 1.6
  class { 'toughen::mandatory_access': }
  contain toughen::mandatory_access

  # 1.7
  class { 'toughen::banners': }
  contain toughen::banners

  # 2.1
  class { 'toughen::legacy_services': }
  contain toughen::legacy_services

  # 2.2
  class { 'toughen::services': }
  contain toughen::services

  class { 'toughen::ntp': }
  contain toughen::ntp

  # 3
  class { 'toughen::network': }
  contain toughen::network

  # 3.6
  Firewall {
    before => Class['toughen::firewall::post'],
    require => Class['toughen::firewall::pre'],
  }
  class { 'toughen::firewall': }
  contain toughen::firewall

  # 4.1
  class { 'toughen::auditing': }
  contain toughen::auditing

  # 4.2
  class { 'toughen::rsyslog': }
  contain toughen::rsyslog

  # 5.1
  class { 'toughen::cron': }
  contain toughen::cron

  # 5.2
  class { 'toughen::ssh': }
  contain toughen::ssh

  # 5.3
  class { 'toughen::pam': }
  contain toughen::pam

  # 5.4?
  class { 'toughen::perms_owners': }
  contain toughen::perms_owners

  # 5.4?
  class { 'toughen::user_env': }
  contain toughen::user_env

  # 6.1
  class { 'toughen::shadow': }
  contain toughen::shadow

}
