# Class: toughen::modprobe
# 
# Parameters
# ----------
# 
# * `blacklist_modules`
#  The list of kernel modules to blacklist (/bin/true)
# 
# * `blacklist_confname`
#  The name of the file under /etc/modprobe.d in which
#  to place the blacklist. Note that this parameter will
#  have '.conf' appended.
# 
class toughen::modprobe (
  $blacklist_modules = [
    'usb-storage',
    'cramfs',
    'freevxfs',
    'jffs2',
    'hfs',
    'hfsplus',
    'squashfs',
    'udf',
    'bluetooth',
    'dccp',
    'sctp',
  ],
  $blacklist_confname = 'CIS',
){
  file { "/etc/modprobe.d/${blacklist_confname}.conf":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('toughen/modprobe.conf.erb'),
  }
}
