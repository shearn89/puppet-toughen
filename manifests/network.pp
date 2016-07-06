# Class: toughen::network
# 
# Parameters
# ----------
# 
# * `ignore_bogus_messages`
#  Whether to ignore bogus ICMP messages or not.
#
# * `send_redirects`
#  Whether to send ICMP redirects or not.
#
# * `accept_source_route`
#  Whether to accept packets with SSR/LSR set.
# 
# * `accept_redirects`
#  Whether to accept packets with redirects set.
#
# * `secure_redirects`
#  Whether to allow redirects from gateways in our table.
#
# * `log_martians`
#  Whether to log martian packets or not.
#
# * `ignore_broadcasts`
#  Whether to ignore ping requests to broadcast addresses.
class toughen::network (
  $ignore_bogus_messages = '1',
  $send_redirects = '0',
  $accept_source_route = '0',
  $accept_redirects = '0',
  $secure_redirects = '0',
  $log_martians = '1',
  $ignore_broadcasts = '1'
){

  validate_re($ignore_bogus_messages, '[0,1]')
  validate_re($send_redirects, '[0,1]')
  validate_re($accept_source_route, '[0,1]')
  validate_re($accept_redirects, '[0,1]')
  validate_re($secure_redirects, '[0,1]')
  validate_re($log_martians, '[0,1]')
  validate_re($ignore_broadcasts, '[0,1]')

  case $::osfamily {
    'redhat': {}
    'darwin': {
      fail("OS family ${::osfamily} is not supported")
    }
    default: {}
  }

  file { [ '/etc/hosts.allow', '/etc/hosts.deny' ]:
    owner => root,
    group => root,
    mode  => '0644',
  }

  if $::operatingsystemmajrelease == 6 {
    sysctl{ 'kernel.exec-shield': value => '1' }
  }

  sysctl { 'net.ipv4.icmp_ignore_bogus_error_messages':
    value => $ignore_bogus_messages
  }
  sysctl { 'net.ipv4.icmp_ignore_bogus_error_responses':
    value => '1'
  }
  sysctl { 'kernel.randomize_va_space':
    value => '2'
  }
  sysctl { 'net.ipv4.conf.all.send_redirects':
    value => $send_redirects,
  }
  sysctl { 'net.ipv4.conf.default.send_redirects':
    value => $send_redirects,
  }
  sysctl { 'net.ipv4.conf.all.accept_source_route':
    value => $accept_source_route,
  }
  sysctl { 'net.ipv4.conf.all.accept_redirects':
    value => $accept_redirects,
  }
  sysctl { 'net.ipv4.conf.default.accept_redirects':
    value => $accept_redirects,
  }
  sysctl { 'net.ipv4.conf.all.secure_redirects':
    value => $secure_redirects,
  }
  sysctl { 'net.ipv4.conf.default.secure_redirects':
    value => $secure_redirects,
  }
  sysctl { 'net.ipv4.conf.all.log_martians':
    value => $log_martians,
  }
  sysctl { 'fs.suid_dumpable':
    value => '0'
  }
  sysctl { 'net.ipv4.icmp_echo_ignore_broadcasts':
    value => $ignore_broadcasts,
  }
  sysctl { 'net.ipv4.conf.all.rp_filter':
    value => '1'
  }
  sysctl { 'net.ipv4.tcp_max_syn_backlog':
    value => '4096'
  }
}
