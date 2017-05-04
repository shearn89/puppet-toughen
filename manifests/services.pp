# Class: toughen::services
#
class toughen::services (
  $x_disabled = true,
  $avahi_disabled = true,
  $cups_disabled = true,
  $dhcp_disabled = true,
  $ldap_disabled = true,
  $nfs_disabled = true,
  $rpc_disabled = true,
  $dns_disabled = true,
  $ftp_disabled = true,
  $http_disabled = true,
  $mail_disabled = true,
  $samba_disabled = true,
  $snmp_disabled = true,
  $mta_local = true,
  $nis_disabled = true,
  $rsh_disabled = true,
  $tftp_disabled = true,
  $rsync_disabled = true,
  $talk_disabled = true,
){

  if $dhcp_disabled {
    $dhcp_pkg_status = 'absent'
  }
  if $cups_disabled {
    $cups_pkg_status = 'absent'
  }

  case $::osfamily {
    'redhat': {

      if $x_disabled {
        package { 'xorg-x11*':
          ensure => 'absent',
        }
      } 

      if $avahi_disabled {
        service { 'avahi-daemon':
          ensure => 'stopped',
          enable => false,
        }
      }

      if $cups_disabled {
        service { 'cups':
          ensure => 'stopped',
          enable => false,
        }
      }
      
      if $dhcp_disabled {
        service { 'dhcpd':
          ensure => 'stopped',
          enable => false,
	}

	package { 'dhcp':
	  ensure => 'absent',
	}
      }

      if $ldap_disabled {
        service { 'slapd':
          ensure => 'stopped',
          enable => false,
	}
	
	package { 'openldap-servers':
	  ensure => 'absent',
	}
      }

      if $nfs_disabled {
        service { 'nfs':
          ensure => 'stopped',
          enable => false,
	}
	package { 'nfs-ganesha*':
	  ensure => 'absent',
	}
      }

      if $rpc_disabled {
        service { 'rpcbind':
          ensure => 'stopped',
          enable => false,
	}
	package { 'rpcbind':
	  ensure => 'absent',
	}
      }

      if $dns_disabled {
	package { [
	  'bind',
	  'dnsjava',
	  'dnsmasq',
	  'iodine',
	  'iodine-server',
	  'ipa-server-dns',
	  'kea',
	  'knot',
	  'nsd',
	  'pdns',
	  'perl-Net-DNS-Nameserver',
	  'yadifa' ]:
	  ensure => 'absent',
	}
      }

      if $ftp_disabled {
	package { [
	  'globus-gridftp-server',
	  'jglobus-gridftp',
	  'krb5-appl-servers',
	  'nordugrid-arc-gridftpd',
	  'perl-ftpd',
	  'perl-Net-FTPServer',
	  'proftpd',
	  'pure-ftpd',
	  'vsftpd' ]:
	  ensure => 'absent',
	}
      }

      if $http_disabled [
	package { [
	  'darkhttpd',
          'erlang-inets',
          'ghc-happstack-server',
          'ghc-warp',
	  'httpd',
	  'jetty-http',
          'jetty-websocket-server',
          'lighttpd',
	  'lighttpd',
	  'nghttp2',
          'nginx',
          'nikto',
          'nodejs-faye-websocket',
          'nodejs-ws',
	  'opensips-httpd',
	  'perl-HTTP-Daemon',
	  'perl-HTTP-Daemon-SSL',
	  'perl-HTTP-Server-Simple',
	  'perl-HTTP-Soup',
	  'php-react-http',
          'python34-tornado',
          'python-tornado',
          'python-twisted-web',
	  'qhttpengine',
	  'root-net-http',
          'rubygem-rack',
          'rubygem-thin',
	  'slowhttptest',
	  'squid',
	  'tinyproxy',
	  'trafficserver',
	  'wbox',
          'xbean',
          'xsp',
          'yawn-server',
          'yaws' ]:
	  ensure => 'absent',
	}
      }

      if $mail_disabled {
        package { [
          'cyrus-imapd',
          'dovecot',
          'imapsync',
          'perdition',
          'php-horde-imp',
          'uw-imap' ]: 
	  ensure => 'absent',
	}
      } 

      if $samba_disabled {
        package { [
	]: 
	  ensure => 'absent',
	}
      } 
      if $snmp_disabled {
        package { [
	]: 
	  ensure => 'absent',
	}
      } 
      if $mta_local {
        # sendmail
        # postfix
        # ssmtp
      } 
      if $nis_disabled {
        package { [
	]: 
	  ensure => 'absent',
	}
      } 
      if $rsh_disabled {
        package { [
	]: 
	  ensure => 'absent',
	}
      } 
      if $tftp_disabled {
        package { [
	]: 
	  ensure => 'absent',
	}
      } 
      if $rsync_disabled {
        package { [
	]: 
	  ensure => 'absent',
	}
      } 
    }
    default: {
      fail("${::osfamily} not supported")
    }
  }
}
