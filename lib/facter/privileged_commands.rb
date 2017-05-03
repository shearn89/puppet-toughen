# Returns a comma-seperated list of all binaries with setuid
Facter.add(:privileged_commands) do
  confine :kernel => "Linux"

  setcode do
    binaries = Facter::Util::Resolution.exec('find / -xdev -type f -perm -4000 -o -type f -perm -2000 2>/dev/null')
    binaries && binaries.split().join(',')
  end
end
