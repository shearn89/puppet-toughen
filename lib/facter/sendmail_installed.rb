# Returns true if sendmail is installed
Facter.add(:sendmail_installed) do
  confine :kernel => "Linux"

  setcode do
    File.file?('/etc/mail/sendmail.mc')
  end
end
