class toughen::perms_owners (
){

  File {
    ensure => file,
    owner => 'root',
    group => 'root',
  }

  file { [ '/etc/passwd', '/etc/group' ]:
    mode => '0644',
  }

  file { [ '/etc/passwd-', '/etc/shadow-', '/etc/group-', '/etc/gshadow-' ]:
    mode => '0600',
  }

  file { [ '/etc/shadow', '/etc/gshadow' ]:
    mode => '0000',
  }

  # TODO: world writable files
  # df --local -P | awk if (NR!=1) print $6 | xargs -I '{}' find '{}' -xdev -type f -perm -0002

  # TODO: unowned files
  # df --local -P | awk if (NR!=1) print $6 | xargs -I '{}' find '{}' -xdev -nousero

  # TODO: ungrouped files
  # df --local -P | awk if (NR!=1) print $6 | xargs -I '{}' find '{}' -xdev -nogroup

  # TODO: 6.1.13, 6.1.14
}
