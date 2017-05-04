module Puppet::Parser::Functions

  newfunction(:cidr_to_range, :type => :rvalue, :doc => <<-'ENDHEREDOC'
    Converts an CIDR address of the form 192.168.0.1/24 into a range of IP address excluding the network and broadcast
    addresses.

    ENDHEREDOC
    ) do |args|

    unless args.length == 1 then
      raise Puppet::ParseError, ("cidr_to_range(): wrong number of arguments (#{args.length}; must be 1)")
    end
    arg = args[0]
    unless arg.respond_to?('to_s') then
      raise Puppet::ParseError, ("#{arg.inspect} is not a string. It looks to be a #{arg.class}")
    end

    cidr = nil
    begin
      cidr = IPAddr.new(arg.to_s)
    rescue ArgumentError => e
      raise Puppet::ParseError, (e)
    end

    ips = cidr.to_range.each.map { |ip| ip.to_s }
    ips.shift
    ips.pop
    ips
  end
end
