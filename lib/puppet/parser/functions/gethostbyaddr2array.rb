
# Resolve an IP address into one or more names.
#
# E.g. gethostbyaddr2array('10.56.5.8') returns:
#  ['rackmaster-r5-devc.dev.yelpcorp.com']
# And gethostbyaddr2array(['10.56.5.8', '10.56.6.8']) returns:
#  ['rackmaster-r5-devc.dev.yelpcorp.com', 'rackmaster-r6-devc.dev.yelpcorp.com' ]

require 'resolv'

module Puppet::Parser::Functions
  newfunction(:gethostbyaddr2array, :type => :rvalue) do |a|
    if (a.size != 1) then
      raise(Puppet::ParseError, "gethostbyaddr2array(): Wrong number of arguments "+
        "given #{a.size} for 1.")
    end

    lookup_ips = Array(a[0]) # Force into array

    data = nil
    begin
      data = lookup_ips.map { |ip| Resolv.getname(ip) }.sort
    rescue Exception => e
      raise(Puppet::ParseError, "Exception finding records for #{lookup_ips.join(', ')}: #{e}")
    end
    if data.size == 0
      raise(Puppet::ParseError, "Could not find any DNS records for #{lookup_ips.join(', ')}")
    end
    data
  end
end

