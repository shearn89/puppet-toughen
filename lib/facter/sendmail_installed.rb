# Returns true if sendmail is installed
Facter.add(:sendmail_installed) do
  confine :kernel => "Linux"

  setcode do
    result = File.file?('/etc/mail/sendmail.mc') ? 'true' : 'false'
    result
  end
end
