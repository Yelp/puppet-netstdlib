
# Resolve a name into one or more IP addresses
#
# E.g. gethostbyname2array('sensu.local.yelpcorp.com') in devc returns a list containing:
#  10.56.5.8
#  10.56.6.8

require 'resolv'

module Puppet::Parser::Functions
  newfunction(:gethostbyname2array, :type => :rvalue) do |a|
    if (a.size != 1) then
      raise(Puppet::ParseError, "gethostbyname2array(): Wrong number of arguments "+
        "given #{a.size} for 1.")
    end

    lookup_name = a[0].to_s

    data = nil
    begin
      data = Resolv::DNS.new.getresources(lookup_name, Resolv::DNS::Resource::IN::A).map { |r| r.address.to_s }.sort
    rescue Exception => e
      raise(Puppet::ParseError, "Exception finding records for #{lookup_name}: #{e}")
    end
    if data.size == 0
      raise(Puppet::ParseError, "Could not find any DNS records for #{lookup_name}")
    end
    data
  end
end

