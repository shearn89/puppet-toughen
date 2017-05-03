# Class: toughen::legacy_services
#
# Parameters
# ----------
# 
# * `telnet_ensure`
#  Whether to install or remove telnet
# 
# * `xinetd_ensure`
#  Whether to install or remove xinetd
#
class toughen::legacy_services (
  $telnet_ensure = 'absent',
  $xinetd_ensure = 'absent'
){

  if !($telnet_ensure in [ 'installed', 'absent' ]) {
    fail('Telnet package ensure should be "installed" or "absent"')
  }

  if !($xinetd_ensure in [ 'installed', 'absent' ]) {
    fail('Xinetd package ensure should be "installed" or "absent"')
  }

  package { 'telnet':
    ensure => $telnet_ensure
  }

  package { 'xinetd':
    ensure => $xinetd_ensure
  }

  package { [
      'telnet-server',
      'rsh-server',
      'rsh',
      'ypbind',
      'ypserv',
      'tftp',
      'tftp-server',
      'talk',
      'talk-server',
      'chargen-dgram',
      'chargen-stream',
      'daytime-dgram',
      'daytime-stream',
      'echo-dgram',
      'echo-stream',
      'tcpmux-server'
    ]:
      ensure => 'absent'
  }
}
