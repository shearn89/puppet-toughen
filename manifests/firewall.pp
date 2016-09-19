class toughen::firewall (
  $posture = 'default'
){
  resources { 'firewall':
    purge => true,
  }
  ## TODO: purge chains
  # resources { 'firewallchain':
  #   purge => true,
  # }

  Firewall {
    before => Class['toughen::firewall::post'],
    require => Class['toughen::firewall::pre'],
  }
  class { ['toughen::firewall::pre', 'toughen::firewall::post']: }
  class { '::firewall': }

}
