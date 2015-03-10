# Generate EUI64 used by IPv6 auto address from a MAC address
#
# Example:
#   mac_to_eui64("52:54:00:12:09:f3")
#   > "5054:00ff:fe12:09f3"

module Puppet::Parser::Functions
  newfunction(:mac_to_eui64, :type => :rvalue) do |a|
    if (a.size != 1) then
      raise(Puppet::ParseError, "mac_to_eui64(): Wrong number of arguments "+
        "given #{a.size} for 1.")
    end

    Puppet::Parser::Functions.autoloader.loadall

    macString = a[0]

    unless (macString =~ /^[0-9a-f]{2}(:[0-9a-f]{2}){5}$/i) then
      raise(Puppet::ParseError, "mac_to_eui64(): Argument must be a MAC address")
    end

    mac = macString.split(":")

    eui64 = (mac[0].to_i(16)^2).to_s(16)+mac[1]+":"+mac[2]+"ff:fe"+mac[3]+":"+mac[4]+mac[5]

    eui64
  end
end