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
    if args[1].is_a? String
      cidr_ary = [ args[1] ]
    elsif args[1].is_a? Array
      cidr_ary = args[1]
    else
      raise Puppet::ParseError, ("#{args[1].inspect} is not a string. It looks to be a #{args[1].class}")
    end
    cidr_ary.each { |cidr|
      cidr = cidr.to_s
      unless cidr.respond_to?('to_s') then
        raise Puppet::ParseError, ("#{cidr.inspect} is not a string. It looks to be a #{cidr.class}")
      end
      begin
        if IPAddr.new(cidr).include? IPAddr.new(ip)
          return true
        end
      rescue ArgumentError => e
         raise Puppet::ParseError, (e)
      end
    }
    return false
  end
end

