# Class: toughen::mandatory_access
#
# This class installs and configures SELinux on RHEL-based systems,
# AppArmor on Debian-based systems.
# 
# Parameters
# ----------
# 
# * `mode`
#  The mode that SELinux should be in, defaults to Enforcing
#
# * `policy`
#  The policy that SELinux should use, defaults to Targeted.
# 
class toughen::mandatory_access (
  $mode   = 'enforcing',
  $policy = 'targeted',
  $setroubleshoot_ensure = 'absent',
  $mcstrans_ensure = 'absent'
){

  # TODO: parameter validation

  case $::osfamily {
    'redhat': {
      # section 1.4.1 - grub.conf

      # section 1.4.2 - set state
      augeas { 'selinux-mode':
        context => '/files/etc/selinux/config',
        changes => "set SELINUX ${mode}"
      }

      # section 1.4.3 - set policy
      augeas { 'selinux-policy':
        context => '/files/etc/selinux/config',
        changes => "set SELINUXTYPE ${policy}"
      }

      # section 1.4.4 - remove setroubleshoot
      package { 'setroubleshoot':
        ensure => $setroubleshoot_ensure,
      }

      # section 1.4.5 - remove mcstrans
      package { 'mcstrans':
        ensure => $mcstrans_ensure,
      }

      # section 1.4.6 - check for unconfied daemons
      # TODO
    }
    default: {
      fail("OS family ${::osfamily} not supported.")
    }
  }
}
