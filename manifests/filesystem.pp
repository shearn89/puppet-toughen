# Class: toughen::filesystem
#
# Parameters
# ----------
# 
# * `tmp_device`
#  The /dev path for the fstab /tmp entry
# 
# * `tmp_options`
#  The options to be provided to the /tmp mountpoint
# 
# * `tmp_mode`
#  The numerical mode to be set on /tmp
#
# * `var_device`
#  The /dev path for the fstab /var entry
#
# * `var_log_device`
#  The /dev path for the fstab /var/log entry
#
# * `var_log_audit_device`
#  The /dev path for the fstab /var/log/audit entry
#
# * `ramdisk_present`
#  Whether there's a ramdisk present at all
# 
# * `ramdisk_options`
#  The options to be provided to the /dev/shm mountpoint
# 
# * `fstype`
#  The filesystem in use on e.g. /var, /tmp, etc.
# 
# * `blacklist_modules`
#  The list of kernel modules to blacklist (/bin/true)
# 
# * `blacklist_confname`
#  The name of the file under /etc/modprobe.d in which
#  to place the blacklist. Note that this parameter will
#  have '.conf' appended.
# 
# * `usb_disabled`
#  Whether to add 'nousb' to the kernel params.
# 
# * `restrict_dmesg`
#  Whether to restrict access to dmesg.
# 
class toughen::filesystem (
  $tmp_device = '/dev/mapper/rhel-tmp',
  $tmp_options = 'nodev,nosuid,noexec',
  $tmp_mode = '1777',
  $var_device = '/dev/mapper/rhel-var',
  $var_log_device = '/dev/mapper/rhel-var_log',
  $var_log_audit_device = '/dev/mapper/rhel-var_log_audit',
  $ramdisk_present = false,
  $ramdisk_options = 'nodev,nosuid,noexec',
  $fstype = 'ext4',
  $blacklist_modules = [
    'usb-storage',
    'cramfs',
    'freevxfs',
    'jffs2',
    'hfs',
    'hfsplus',
    'squashfs',
    'udf'],
  $blacklist_confname = 'CIS',
  $usb_disabled = true,
  $restrict_dmesg = true,
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
    options => 'rw,nodev,noexec,nosuid,bind',
  }

  if $ramdisk_present {
    mount { '/dev/shm':
      ensure  => present,
      options => $ramdisk_options,
    }
  }

  file {'/tmp':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => $tmp_mode,
  }

  file { "/etc/modprobe.d/${blacklist_confname}.conf":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('toughen/modprobe.conf.erb'),
  }

  if $usb_disabled {
    kernel_parameter { 'nousb':
      ensure => present,
    }
  }
  if $restrict_dmesg {
    sysctl { 'kernel.dmesg_restrict':
      value => 1
    }
  }
}
