# Class: toughen::services
#
class toughen::services {

  case $::osfamily {
    'redhat': {
      package {
        ['xorg-x11-libs', 'avahi-daemon', 'dhcp']:
          ensure => absent,
      }
      # file { '/etc/postfix/main.cf': }
    }
    default: {
      fail("${::osfamily} not supported")
    }
  }
  # TODO: ntp
}
