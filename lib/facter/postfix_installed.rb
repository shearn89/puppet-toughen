# Returns true if postfix is installed
Facter.add(:postfix_installed) do
  confine :kernel => "Linux"

  setcode do
    result = File.file?('/etc/postfix/main.cf') ? 'true' : 'false'
    result
  end
end
