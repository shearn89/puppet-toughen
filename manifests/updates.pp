# Class: toughen::updates
# 
# This class configures software updates and signing
#
# Parameters
# ----------
#
# * `use_gpg`
# Whether to enable GPG signing for packages, defaults to true
# 
class toughen::updates (
  $use_gpg = true
){
  case $::operatingsystem {
    'CentOS': {
      if $use_gpg {
        augeas { 'enable yum gpgcheck':
          context => '/files/etc/yum.conf',
          changes => [
            'set gpgcheck 1',
          ],
        }
      }

      # section 1.2.1 - connection to RHN repos
      # section 1.2.4 - disable RHNSD
      # section 1.2.5 - use yum for updates

      # Skip as gives false positives due to other controls
      # section 1.2.6 - verify package integrity
    }
    default: {
      fail("OS ${::operatingsystem} not supported.")
    }
  }
}
