
Facter.add(:privileged_commands) do
  confine :kernel => "Linux"

  setcode do
    binaries = Facter::Util::Resolution.exec('find / -xdev -type f -perm -4000 -o -type f -perm -2000 2>/dev/null')
    binaries && binaries.split()
  end
end
