# Returns true if rpcbind is installed
Facter.add(:rpcbind_installed) do
  confine :kernel => 'Linux'

  setcode do
    output = Facter::Util::Resolution.which('rpcbind')
    output ? true : false
  end
end
