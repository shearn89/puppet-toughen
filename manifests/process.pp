# Class: toughen::process
#
class toughen::process {

  limits::fragment {
    '*/hard/core':
      value => '0';
  }

  if $::osfamily == 'redhat' {
    if $::operatingsystemmajrelease == 6 {
      sysctl { 'kernel.exec-shield': value => '1' }
    }
  }

  sysctl { 'kernel.randomize_va_space':
    value => '2'
  }

  sysctl { 'fs.suid_dumpable':
    value => '0'
  }
}
