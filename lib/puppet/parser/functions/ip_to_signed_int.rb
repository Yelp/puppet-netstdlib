module Puppet::Parser::Functions

  newfunction(:ip_to_signed_int, :type => :rvalue, :doc => <<-'ENDHEREDOC'
    Converts a dotted address of the form 192.168.0.1 into its signed 32 bit integer representation

    ENDHEREDOC
    ) do |args|

    unless args.length == 1 then
      raise Puppet::ParseError, ("ip_to_signed_int(): wrong number of arguments (#{args.length}; must be 1)")
    end
    arg = args[0]
    unless arg.respond_to?('to_s') then
      raise Puppet::ParseError, ("#{arg.inspect} is not a string. It looks to be a #{arg.class}")
    end

    arg = arg.to_s
    begin
      int_val = IPAddr.new(arg).to_i
      [int_val].pack('L').unpack('l')[0] # Pack as unsigned int, unpack as signed int
    rescue ArgumentError => e
      raise Puppet::ParseError, (e)
    end
  end

end

