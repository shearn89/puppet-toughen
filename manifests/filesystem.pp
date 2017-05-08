# Class: toughen::filesystem
#
# Parameters
# ----------
# 
# * `tmp_options`
#  The options to be provided to the /tmp mountpoint
# 
# * `tmp_mode`
#  The numerical mode to be set on /tmp
#
# * `ramdisk_options`
#  The options to be provided to the /dev/shm mountpoint
# 
class toughen::filesystem (
  $tmp_device = '/dev/mapper/rhel-tmp',
  $tmp_options = 'nodev,nosuid,noexec',
  $tmp_mode = '1777',
  $var_device = '/dev/mapper/rhel-var',
  $var_log_device = '/dev/mapper/rhel-var_log',
  $var_log_audit_device = '/dev/mapper/rhel-var_log_audit',
  $ramdisk_options = 'nodev,nosuid,noexec',
  $fstype = 'ext4',
){

  validate_re($tmp_options, '^[a-z,]+$')
  validate_re($tmp_mode, '\d+')
  validate_re($ramdisk_options, '^[a-z,]+$')

  file {'/etc/fstab':
    owner => root,
    group => root,
    mode  => '0600',
  }

  mount {'/tmp':
    ensure  => present,
    fstype  => $fstype,
    options => $tmp_options,
    device  => $tmp_device,
  }

  # mount {'/dev/shm':
  #   ensure  => present,
  #   fstype  => $fstype,
  #   options => $ramdisk_options,
  # }

  mount { '/var':
    ensure  => present,
    fstype  => $fstype,
    device  => $var_device,
    options => 'nodev',
  }
  mount { '/var/log':
    ensure  => present,
    fstype  => $fstype,
    device  => $var_log_device,
    options => 'nodev',
  }
  mount { '/var/log/audit':
    ensure  => present,
    fstype  => $fstype,
    device  => $var_log_audit_device,
    options => 'nodev',
  }

  mount { '/home':
    ensure  => present,
    fstype  => $fstype,
    options => 'nodev',
  }

  mount {'/var/tmp':
    ensure  => 'mounted',
    device  => '/tmp',
    fstype  => 'none',
    options => 'bind',
  }

  file {'/tmp':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => $tmp_mode,
  }

}
