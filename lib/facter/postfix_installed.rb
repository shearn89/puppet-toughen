# Returns true if postfix is installed
Facter.add(:postfix_installed) do
  confine :kernel => "Linux"

  setcode do
    File.file?('/etc/postfix/main.cf')
  end
end
