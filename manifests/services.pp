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
  $proxy_disabled = true,
  $snmp_disabled = true,
  $mta_local = true,
  $rsync_disabled = true,
){

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
        # Note there's a bug that means puppet doesn't understand 'indirect' services:
        # https://tickets.puppetlabs.com/browse/PUP-6759
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

      if $dns_disabled {
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

      if $http_disabled {
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
          'cifs-utils',
          'kdenetwork-fileshare-samba',
          'samba-client',
          'samba-common',
          'samba-dc',
          'samba' ]:
          ensure => 'absent',
        }
      }

      if $proxy_disabled {
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

      if $snmp_disabled {
        package { [
          'net-snmp',
        ]:
          ensure => 'absent',
        }
      }

      if $mta_local {
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

      if $rsync_disabled {
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
