# Returns true if rpcbind is installed
Facter.add(:rpcbind_installed) do
  confine :osfamily => "RedHat"

  setcode do
    output = Facter::Util::Resolution.exec('rpm -qa | grep rpcbind')
    output.empty? ? false : true
  end
end

Facter.add(:rpcbind_installed) do
  confine :osfamily => "Debian"

  setcode do
    output = Facter::Util::Resolution.exec('apt list rpcbind | grep rpcbind')
    output.empty? ? false : true
  end
end
