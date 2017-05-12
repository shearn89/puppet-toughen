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
# * `clean_on_update`
# Whether to clean up outdated packages when updates installed.
# 
# * `local_gpgcheck`
# Whether to check local package signature before installing
# 
# * `repo_gpgcheck`
# Whether to verify repo metadata signatures
# 
class toughen::updates (
  $use_gpg = true,
  $clean_on_update = true,
  $local_gpgcheck = true,
  $repo_gpgcheck = true,
){
  validate_bool($use_gpg)
  validate_bool($clean_on_update)
  validate_bool($local_gpgcheck)
  validate_bool($repo_gpgcheck)

  case $::osfamily {
    'redhat': {
      if $use_gpg {
        augeas { 'enable yum gpgcheck':
          context => '/files/etc/yum.conf/main',
          changes => [
            'set gpgcheck 1',
          ],
        }
      }

      if $clean_on_update {
        augeas { 'clean pkgs on update':
          context => '/files/etc/yum.conf/main',
          changes => [
            'set clean_requirements_on_remove 1',
          ],
        }
      }

      if $local_gpgcheck {
        augeas { 'check gpg for local pkgs':
          context => '/files/etc/yum.conf/main',
          changes => [
            'set localpkg_gpgcheck 1',
          ],
        }
      }

      if $repo_gpgcheck {
        augeas { 'check gpg for repo metadata':
          context => '/files/etc/yum.conf/main',
          changes => [
            'set repo_gpgcheck 1',
          ],
        }
      }

      # TODO
      # section 1.2.1 - connection to RHN repos
      # section 1.2.4 - disable RHNSD
      # section 1.2.5 - use yum for updates

      # Skip as gives false positives due to other controls
      # section 1.2.6 - verify package integrity
    }
    default: {
      fail("OS family ${::osfamily} not supported.")
    }
  }
}
