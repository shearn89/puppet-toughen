class toughen::firewall::pre {
  Firewall {
    require => undef,
  }
  firewall { '000 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
  }
  -> firewall { '001 accept all on loopback':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }
  -> firewall { '002 reject local not on loopback':
    iniface     => '! lo',
    proto       => 'all',
    destination => '127.0.0.1/8',
    action      => 'reject',
  }
  -> firewall { '003 accept rel/est':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }
  -> firewall { '004 accept SSH':
    proto  => 'tcp',
    dport  => 22,
    action => 'accept',
  }
  -> firewall { '005 accept DHCP':
    proto  => 'udp',
    dport  => 68,
    action => 'accept',
  }
  -> firewall { '006 accept NTP':
    proto  => 'udp',
    dport  => 123,
    action => 'accept',
  }

  firewallchain { 'INPUT:filter:IPv4':
    ensure => present,
    policy => drop,
    before => undef,
  }
  firewallchain { 'OUTPUT:filter:IPv4':
    ensure => present,
    policy => accept,
    before => undef,
  }
  firewallchain { 'FORWARD:filter:IPv4':
    ensure => present,
    policy => drop,
    before => undef,
  }

  firewallchain { 'INPUT:filter:IPv6':
    ensure => present,
    policy => drop,
    before => undef,
  }
  firewallchain { 'OUTPUT:filter:IPv6':
    ensure => present,
    policy => accept,
    before => undef,
  }
  firewallchain { 'FORWARD:filter:IPv6':
    ensure => present,
    policy => drop,
    before => undef,
  }

}
