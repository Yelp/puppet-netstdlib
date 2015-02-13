module Puppet::Parser::Functions

  newfunction(:ip_to_int, :type => :rvalue, :doc => <<-'ENDHEREDOC'
    Converts a dotted address of the form 192.168.0.1 into its unsigned 32 bit integer representation

    ENDHEREDOC
    ) do |args|

    unless args.length == 1 then
      raise Puppet::ParseError, ("ip_to_int(): wrong number of arguments (#{args.length}; must be 1)")
    end
    arg = args[0]
    unless arg.respond_to?('to_s') then
      raise Puppet::ParseError, ("#{arg.inspect} is not a string. It looks to be a #{arg.class}")
    end

    arg = arg.to_s
    begin
      IPAddr.new(arg).to_i
    rescue ArgumentError => e
      raise Puppet::ParseError, (e)
    end
  end

end

