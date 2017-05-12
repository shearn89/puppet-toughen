# Class: toughen::network
# 
# Parameters
# ----------
# 
# * `ignore_bogus_responses`
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
# 
# * `use_syncookies`
#  Whether to use TCP SYN cookies for flood detection.
#
# * `ip_forwawrd`
#  Whether to enable IP forwarding or not
#
class toughen::network (
  $ignore_bogus_responses = '1',
  $send_redirects = '0',
  $accept_source_route = '0',
  $accept_redirects = '0',
  $secure_redirects = '0',
  $log_martians = '1',
  $ignore_broadcasts = '1',
  $use_syncookies = '1',
  $ip_forward = '0',
  $disable_ipv6 = '1',
){

  validate_re($ignore_bogus_responses, '[0,1]')
  validate_re($send_redirects, '[0,1]')
  validate_re($accept_source_route, '[0,1]')
  validate_re($accept_redirects, '[0,1]')
  validate_re($secure_redirects, '[0,1]')
  validate_re($log_martians, '[0,1]')
  validate_re($ignore_broadcasts, '[0,1]')
  validate_re($use_syncookies, '[0,1]')
  validate_re($ip_forward, '[0,1]')
  validate_re($disable_ipv6, '[0,1]')

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

  sysctl { 'net.ipv4.icmp_ignore_bogus_error_responses':
    value => $ignore_bogus_responses
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
  sysctl { ['net.ipv4.conf.all.log_martians', 'net.ipv4.conf.default.log_martians']:
    value => $log_martians,
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
  sysctl { 'net.ipv4.tcp_syncookies':
    value => $use_syncookies,
  }
  sysctl { 'net.ipv4.ip_forward':
    value => $ip_forward,
  }
  sysctl { ['net.ipv6.conf.all.disable_ipv6', 'net.ipv6.conf.default.disable_ipv6']:
    value => $disable_ipv6,
  }
}
