# Class: toughen::boot
# 
# Parameters
# ----------
# 
# * `umask`
#  The custom umask option. Defaults to 027.
# 
class toughen::boot (
  $umask = '027'
){

  validate_re($umask, '\d+')

  case $::osfamily {
    'redhat': {
      # Grub file permissions
      case $::operatingsystemmajrelease {
        '6': {
          file {'/etc/grub.conf':
            owner => root,
            group => root,
            mode  => '0600',
          }
        }
        '7': {
          file {'/boot/grub2/grub.cfg':
            owner => root,
            group => root,
            mode  => '0600',
          }
        }
        default: {
          fail("OS majversion ${::operatingsystemmajrelease} not supported.")
        }
      }

      # sysconfig settings
      augeas { 'sysconfig-prompt':
        context => '/files/etc/sysconfig/init',
        changes => 'set PROMPT no',
      }
      
      augeas { 'sysconfig-singleuser':
        context => '/files/etc/sysconfig/init',
        changes => 'set single /sbin/sulogin',
      }

      augeas { 'sysconfig-umask':
        context => '/files/etc/sysconfig/init',
        changes => "set UMASK ${umask}",
      }
    }
    default: {
      fail("OS Family ${::osfamily} not supported.")
    }
  }
}
