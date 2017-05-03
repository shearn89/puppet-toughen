# Class: toughen:;sudo
# 
# This class installs and configures Sudo
# 
# Parameters
# ----------
#
# * `package_ensure`
# Whether to install Sudo or not, defaults to install.
# 
# * `safety_id`
# The `user` or `%group` to configure with "ALL=(root) ALL" as a fallback.
# 
class toughen::sudo (
  $package_ensure = 'installed',
  $safety_id = '%domain\ admins'
){

  if !($package_ensure in [ 'installed', 'absent' ]) {
    fail('package_ensure parameter must be "installed" or "absent"')
  }

  validate_string($safety_id)

  package { 'sudo':
    ensure => $package_ensure
  }

  if $package_ensure == 'installed' {
    file { '/etc/sudoers':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      content => template('toughen/sudoers.erb'),
      require => Package['sudo'],
    }
  }

}
