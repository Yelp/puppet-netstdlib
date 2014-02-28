# Generate MAC addresses based on the results of fqdn_rand. Useful for
# generating repeatable MAC addresses for e.g. VMs.
#
# Example:
#   fqdn_mac("52:54:00", "guest-1")
#   > "52:54:00:12:09:f3"

module Puppet::Parser::Functions
  newfunction(:fqdn_mac, :type => :rvalue) do |a|
    if (a.size > 2 or a.size < 1) then
      raise(Puppet::ParseError, "fqnd_mac(): Wrong number of arguments "+
        "given #{a.size} for 1 or 2.")
    end

    Puppet::Parser::Functions.autoloader.loadall

    mac_prefix = a[0]
    seed_prefix = a.size > 1 ? a[1] : ""

    unless (mac_prefix =~ /^[0-9a-f]{2}(:[0-9a-f]{2}){0,4}$/i) then
      raise(Puppet::ParseError, "fqdn_mac(): Argument 1 must be a MAC prefix")
    end

    prefix_size = mac_prefix.split(":").size

    seed_counter = 1
    generated_mac = mac_prefix
    until generated_mac.split(":").size == 6 do
      seed = "#{seed_prefix} #{seed_counter}"
      octet_int = function_fqdn_rand( [ 255, seed ] )
      octet_hex = "%02x" % octet_int
      generated_mac = "#{generated_mac}:#{octet_hex}"
      seed_counter += 1
    end

    generated_mac
  end
end
