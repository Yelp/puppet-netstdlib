module Puppet::Parser::Functions

  newfunction(:ip_in_cidr, :type => :rvalue, :doc => <<-'ENDHEREDOC'
    Checks if an ip address is contained within a CIDR address of the form 192.168.0.1/24

    ENDHEREDOC
    ) do |args|
    require 'ipaddr'
    unless args.length == 2 then
      raise Puppet::ParseError, ("ip_in_cidr(): wrong number of arguments (#{args.length}; must be 2: ip and cidr)")
    end
    ip = args[0]
    unless ip.respond_to?('to_s') then
      raise Puppet::ParseError, ("#{ip.inspect} is not a string. It looks to be a #{ip.class}")
    end
    ip = ip.to_s
    cidr = args[1]
    unless cidr.respond_to?('to_s') then
      raise Puppet::ParseError, ("#{cidr.inspect} is not a string. It looks to be a #{cidr.class}")
    end
    cidr = cidr.to_s
    begin
      IPAddr.new(cidr).include? IPAddr.new(ip)
    rescue ArgumentError => e
      raise Puppet::ParseError, (e)
    end
  end

end

