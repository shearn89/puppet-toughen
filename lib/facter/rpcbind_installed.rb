# Returns true if rpcbind is installed
Facter.add(:rpcbind_installed) do
  confine :osfamily => "RedHat"

  setcode do
    output = Facter::Util::Resolution.exec('rpm -qa | grep rpcbind')
    output ? true : false
  end
end
