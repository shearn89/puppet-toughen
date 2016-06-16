# Class: toughen::banners
#
class toughen::banners {
  case $::osfamily {
    'redhat': {
      file {
        [ '/etc/issue.net', '/etc/issue', '/etc/motd' ]:
          source => 'puppet:///modules/toughen/motd',
          owner  => 'root',
          group  => 'root',
          mode   => '0644',
      }
    }
    default: {
      fail("OS Family ${::osfamily} not supported!")
    }
  }
}
