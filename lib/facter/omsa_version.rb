# omsa_version.rb

if Facter.value(:manufacturer) == 'Dell Inc.'
  Facter.add("omsa_version") do
        confine :kernel => 'Linux'
        setcode do
            Facter::Util::Resolution.exec("/opt/dell/srvadmin/bin/omreport about | awk '/^Version/{print $3}'")
        end
    end
end
