module Puppet::Parser::Functions

  newfunction(:cidr_to_broadcast, :type => :rvalue, :doc => <<-'ENDHEREDOC'
    Converts an CIDR address of the form 192.168.0.1/24 into its broadcast address

    ENDHEREDOC
    ) do |args|

    unless args.length == 1 then
      raise Puppet::ParseError, ("cidr_to_broadcast(): wrong number of arguments (#{args.length}; must be 1)")
    end
    arg = args[0]
    unless arg.respond_to?('to_s') then
        raise Puppet::ParseError, ("#{arg.inspect} is not a string. It looks to be a #{arg.class}")
    end

    arg = arg.to_s
    begin
      IPAddr.new(arg).to_range.last.to_s
    rescue ArgumentError => e
      raise Puppet::ParseError, (e)
    end
  end

end

