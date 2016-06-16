# Class: toughen::process
#
class toughen::process {

  limits::fragment {
    '*/hard/core':
      value => 0;
  }

  if $::osfamily == 'redhat' {
    if $::operatingsystemmajrelease == 6 {
      sysctl { 'kernel.exec-shield': value => '1' }
    }
  }

  sysctl { 'net.ipv4.icmp_ignore_bogus_error_responses':
    value => '1'
  }

  sysctl { 'kernel.randomize_va_space':
    value => '2'
  }

  sysctl { 'net.ipv4.conf.all.send_redirects':
    value => '0'
  }

  sysctl { 'net.ipv4.conf.default.send_redirects':
    value => '0'
  }

  sysctl { 'net.ipv4.conf.all.accept_source_route':
    value => '0'
  }

  sysctl { 'net.ipv4.conf.all.accept_redirects':
    value => '0'
  }

  sysctl { 'net.ipv4.conf.all.secure_redirects':
    value => '0'
  }

  sysctl { 'net.ipv4.conf.all.log_martians':
    value => '1'
  }

  sysctl { 'fs.suid_dumpable':
    value => '0'
  }

  sysctl { 'net.ipv4.conf.default.accept_redirects':
    value => '0'
  }

  sysctl { 'net.ipv4.conf.default.secure_redirects':
    value => '0'
  }

  sysctl { 'net.ipv4.icmp_echo_ignore_broadcasts':
    value => '1'
  }

  sysctl { 'net.ipv4.conf.all.rp_filter':
    value => '1'
  }

  sysctl { 'net.ipv4.tcp_max_syn_backlog':
    value => '4096'
  }

}
