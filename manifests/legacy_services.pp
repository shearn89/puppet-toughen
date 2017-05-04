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
      'inetd',
      'cvs-inetd',
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
      'discard-dgram',
      'discard-stream',
      'echo-dgram',
      'echo-stream',
      'tcpmux-server',
      'time-dgram',
      'time-stream'
    ]:
      ensure => 'absent'
  }

  # e.g. for Check_MK:
  if $xinetd_ensure == 'installed' {

    service { 'xinetd':
      ensure => running,
      enable => true,
    }

    # Make sure the legacy services are still disabled
    $legacy_files = [
      '/etc/xinetd.d/rsh-server',
      '/etc/xinetd.d/rsh',
      '/etc/xinetd.d/ypbind',
      '/etc/xinetd.d/ypserv',
      '/etc/xinetd.d/tftp',
      '/etc/xinetd.d/tftp-server',
      '/etc/xinetd.d/talk',
      '/etc/xinetd.d/talk-server',
      '/etc/xinetd.d/chargen-dgram',
      '/etc/xinetd.d/chargen-stream',
      '/etc/xinetd.d/daytime-dgram',
      '/etc/xinetd.d/daytime-stream',
      '/etc/xinetd.d/discard-dgram',
      '/etc/xinetd.d/discard-stream',
      '/etc/xinetd.d/echo-dgram',
      '/etc/xinetd.d/echo-stream',
      '/etc/xinetd.d/tcpmux-server',
      '/etc/xinetd.d/time-dgram'
    ]
    file { $legacy_files:
      ensure => absent,
    }
  }
}
