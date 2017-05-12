# Class: Toughen::SSH
# 
# Parameters
# ----------
# 
# * shitloads
# 
class toughen::ssh (
  $port = 22,
  $address_family = 'inet',
  $listen_address = '0.0.0.0',
  $protocol = 2,
  $log_level = 'info',
  $x11_forwarding = 'no',
  $max_auth_tries = 4,
  $ignore_rhosts = 'yes',
  $hostbased_authentication = 'no',
  $permit_root_login = 'no',
  $permit_empty_passwords = 'no',
  $permit_user_env = 'no',
  $ciphers = [ 'aes128-ctr', 'aes192-ctr', 'aes256-ctr' ],
  $macs = [ 'hmac-sha2-512', 'hmac-sha2-256' ],
  $client_alive_interval = 300,
  $client_alive_count_max = 0,
  $login_grace_time = 60,
  $allow_users = [],
  $allow_groups = [],
  $deny_users = [],
  $deny_groups = [],
  $banner = '/etc/issue',
  $password_authentication = 'yes',
  $kerberos_authentication = 'no',
  $gssapi_authentication = 'no',
  $gssapi_cleanup_credentials = 'no',
  $use_pam = 'yes',
  $allow_agent_forwarding = 'no',
  $print_motd = 'yes',
  $print_lastlog = 'yes',
  $use_privilege_seperation = 'yes',
  $compression = 'no',
  $use_dns = 'yes',
  $permit_tunnel = 'no'
){
  case $::osfamily {
    'redhat': {
      $package_name = 'openssh-server'
    }
    default: {
      fail("OS Family ${::osfamily} is not supported (yet)")
    }
  }

  package { $package_name:
    ensure => installed,
  }

  if $port != 22 {
    selinux::port { 'ssh_port':
      ensure   =>'present',
      seltype  => 'ssh_port_t',
      protocol => 'tcp',
      port     => $port,
    }
  }

  file { '/etc/ssh/sshd_config':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => template('toughen/sshd_config.erb'),
    require => Package[$package_name],
  }

  service { 'sshd':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/ssh/sshd_config']
  }

  exec { 'chown-host-keys':
    path    => '/bin:/usr/bin:/sbin',
    command => 'chmod 600 /etc/ssh/ssh_host_*_key',
    onlyif  => "[[ $(stat -c %A /etc/ssh/ssh_host_rsa_key | tr -dc 'a-z') != 'rw' ]]",
  }
}
