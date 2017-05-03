define toughen::audit_priv_command {
  auditd::rule { "-a always,exit -F path=${title} -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged": }
}
