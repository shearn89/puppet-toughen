# Class: toughen::auditing
# 
class toughen::auditing (
){

  # Find setuid binaries and check if they're being monitored by auditd
  # ///modules/cis/linuxcontrols/scripts/f0023.sh

  service { 'auditd':
    ensure => 'running',
    enable => true,
  }

  case $::operatingsystem {
    'RedHat': {
      case $::operatingsystemmajrelease {
        '6': {
          augeas { 'grub audit settings':
            incl    => '/etc/grub.conf',
            lens    => 'grub.lns',
            changes => [
              'setm title[*]/kernel audit 1',
            ],
          }
        }
        default: {
          fail("Version ${::operatingsystemmajrelease} of RedHat is not supported")
        }
      }

      # TODO: File['audit.conf']
      # TODO: File['audit.rules']
    }
    default: {
      fail("OS ${::operatingsystem} is not supported")
    }
  }
}
