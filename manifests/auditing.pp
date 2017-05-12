# Class: toughen::auditing
# 
class toughen::auditing (
  $max_log_file_size = 10,
  $max_log_file_action = 'keep_logs',
  $space_left_action = 'email',
  $action_mail_account = 'root',
  $admin_space_left_action = 'halt',
  $flush = 'data'
){

  # TODO: Find setuid binaries and check if they're being monitored by auditd
  # ///modules/cis/linuxcontrols/scripts/f0023.sh

  case $::operatingsystem {
    /^(CentOS|RedHat)$/: {
      case $::operatingsystemmajrelease {
        /^(6|7)$/: {
          kernel_parameter { 'audit':
            ensure => present,
            value  => 1,
          }
        }
        default: {
          fail("Version ${::operatingsystemmajrelease} of RedHat/CentOS is not supported")
        }
      }

      class { 'auditd':
        max_log_file            => $max_log_file_size,
        max_log_file_action     => $max_log_file_action,
        space_left_action       => $space_left_action,
        action_mail_acct        => $action_mail_account,
        admin_space_left_action => $admin_space_left_action,
        flush                   => $flush,
      }
      include '::auditd::audisp::syslog'

      $rules = [
        '-a always,exit -F arch=b64 -S adjtimex -S settimeofday -S stime -k time-change',
        '-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change',
        '-a always,exit -F arch=b64 -S clock_settime -k time-change',
        '-a always,exit -F arch=b32 -S clock_settime -k time-change',
        '-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale',
        '-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale',
        '-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod',
        '-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod',
        '-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod',
        '-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod',
        '-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod',
        '-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod',
        '-a always,exit -F arch=b64 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access',
        '-a always,exit -F arch=b32 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access',
        '-a always,exit -F arch=b64 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access',
        '-a always,exit -F arch=b32 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access',
        '-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts',
        '-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts',
        '-a always,exit -F arch=b64 -S rmdir -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete',
        '-a always,exit -F arch=b32 -S rmdir -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete',
        '-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k export',
        '-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k export',
        '-a always,exit -F arch=b64 -S init_module -S delete_module -k modules',
        '-a always,exit -F arch=b32 -S init_module -S delete_module -k modules',
        '-w /etc/localtime -p wa -k time-change',
        '-w /etc/group -p wa -k identity',
        '-w /etc/passwd -p wa -k identity',
        '-w /etc/gshadow -p wa -k identity',
        '-w /etc/shadow -p wa -k identity',
        '-w /etc/security/opasswd -p wa -k identity',
        '-w /etc/issue -p wa -k system-locale',
        '-w /etc/issue.net -p wa -k system-locale',
        '-w /etc/hosts -p wa -k system-locale',
        '-w /etc/sysconfig/network -p wa -k system-locale',
        '-w /etc/selinux/ -p wa -k MAC-policy',
        '-w /var/log/tallylog -p wa -k logins',
        '-w /var/run/faillock/ -p wa -k logins',
        '-w /var/log/lastlog -p wa -k logins',
        '-w /var/run/utmp -p wa -k session',
        '-w /var/log/wtmp -p wa -k session',
        '-w /var/log/btmp -p wa -k session',
        '-w /etc/sudoers -p wa -k scope',
        '-w /etc/sudoers.d -p wa -k scope',
        '-w /var/log/sudo.log -p wa -k actions',
        '-w /usr/sbin/insmod -p x -k modules',
        '-w /usr/sbin/rmmod -p x -k modules',
        '-w /usr/sbin/modprobe -p x -k modules',
      ]
      auditd::rule { $rules: }

      auditd::rule { 'immutable':
        content => '-e 2',
        order   => '999',
      }

      # Use the custom fact defined by this module
      $binary_array = split($::privileged_commands, ',')
      toughen::defines::audit_priv_command { $binary_array: }
    }
    default: {
      fail("OS ${::operatingsystem} is not supported")
    }
  }
}
