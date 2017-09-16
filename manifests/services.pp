# Class: toughen::services
#
class toughen::services (
  $x_enabled = false,
  $avahi_enabled = false,
  $cups_enabled = false,
  $dhcp_enabled = false,
  $ldap_enabled = false,
  $nfs_enabled = false,
  $rpc_enabled = false,
  $dns_enabled = false,
  $ftp_enabled = false,
  $http_enabled = false,
  $mail_enabled = false,
  $samba_enabled = false,
  $proxy_enabled = false,
  $snmp_enabled = false,
  $mta_local = false,
  $rsync_enabled = false,
){

  case $::osfamily {
    'redhat': {
      unless $x_enabled {
        package { 'xorg-x11*':
          ensure => 'absent',
        }
      }

      unless $avahi_enabled {
        service { 'avahi-daemon':
          ensure => 'stopped',
          enable => false,
        }
      }

      unless $cups_enabled {
        service { 'cups':
          ensure => 'stopped',
          enable => false,
        }
      }

      unless $dhcp_enabled {
        service { 'dhcpd':
          ensure => 'stopped',
          enable => false,
        }

        package { 'dhcp':
          ensure => 'absent',
        }
      }

      unless $ldap_enabled {
        service { 'slapd':
          ensure => 'stopped',
          enable => false,
        }

        package { 'openldap-servers':
          ensure => 'absent',
        }
      }

      unless $nfs_enabled {
        service { 'nfs':
          ensure => 'stopped',
          enable => false,
        }
        package { 'nfs-ganesha*':
          ensure => 'absent',
        }
      }

      unless $rpc_enabled {
        # Note there's a bug that means puppet doesn't understand 'indirect' services:
        # https://tickets.puppetlabs.com/browse/PUP-6759
        ## From fact defined by module
        if str2bool($::rpcbind_installed) {
          service { 'rpcbind.service':
            ensure   => 'stopped',
            enable   => true,
            provider => 'systemd',
          }

          service { 'rpcbind.socket':
            ensure   => 'stopped',
            enable   => false,
            provider => 'systemd',
          }
        }
      }

      unless $dns_enabled {
        package { [
          'bind',
          'dnsjava',
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

        service { 'dnsmasq':
          ensure => 'stopped',
          enable => false,
        }
      }

      unless $ftp_enabled {
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

      unless $http_enabled {
        package { [
          'darkhttpd',
          'erlang-inets',
          'ghc-happstack-server',
          'ghc-warp',
          'httpd',
          'jetty-http',
          'jetty-websocket-server',
          'lighttpd',
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
          'razor-torquebox',
          'root-net-http',
          'rubygem-rack',
          'rubygem-thin',
          'slowhttptest',
          'tomcat',
          'wbox',
          'xbean',
          'xsp',
          'yawn-server',
          'yaws' ]:
          ensure => 'absent',
        }
      }

      unless $mail_enabled {
        package { [
          'cyrus-imapd',
          'dovecot',
          'imapsync',
          'php-horde-imp',
          'uw-imap' ]:
          ensure => 'absent',
        }
      }

      unless $samba_enabled {
        package { [
          'cifs-utils',
          'kdenetwork-fileshare-samba',
          'samba-client',
          'samba-common',
          'samba-dc',
          'samba' ]:
          ensure => 'absent',
        }
      }

      unless $proxy_enabled {
        package { [
          '3proxy',
          'connect-proxy',
          'gssproxy',
          'guacd',
          'haproxy',
          'hitch',
          'jetty-proxy',
          'jglobus-myproxy',
          'jglobus-ssl-proxies',
          'jglobus-ssl-proxies-tomcat',
          'mod_proxy_html',
          'mod_proxy_uwsgi',
          'nghttp2',
          'nginx',
          'nodejs-proxy',
          'nodejs-tunnel-agent',
          'perdition',
          'Pound',
          'privoxy',
          'RabbIT',
          'ratproxy',
          'resiprocate-repro',
          'ser2net',
          'squid',
          'sshuttle',
          'tinyproxy',
          'trafficserver',
          'up-imapproxy' ]:
          ensure => 'absent',
        }
      }

      unless $snmp_enabled {
        package { [
          'net-snmp',
        ]:
          ensure => 'absent',
        }
      }

      unless $mta_local {
        # Fact defined by this module
        if str2bool($::postfix_installed) {
          file_line { 'postfix_local_only':
            path  => '/etc/postfix/main.cf',
            line  => 'inet_interfaces = localhost',
            match => '^inet_interface',
          }
          service { 'postfix':
            ensure    => 'running',
            enable    => true,
            subscribe => File_line['postfix_local_only'],
          }
        }

        # Fact defined by this module
        if str2bool($::sendmail_installed) {
          file_line { 'sendmail_local_only':
            path  => '/etc/mail/sendmail.mc',
            line  => "DAEMON_OPTIONS(`Port=smtp,Addr=127.0.0.1, Name=MTA')dnl",
            match => '^DAEMON_OPTIONS',
          }
          exec { 'compile_sendmail_config':
            command     => '/usr/bin/m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf',
            refreshonly => true,
            subscribe   => File_line['sendmail_local_only'],
          }
          service { 'sendmail':
            ensure    => 'running',
            enable    => true,
            subscribe => Exec['compile_sendmail_config'],
          }
        }
      }

      unless $rsync_enabled {
        service { 'rsyncd':
          ensure => 'stopped',
          enable => false,
        }
      }
    }
    default: {
      fail("${::osfamily} not supported")
    }
  }
}
