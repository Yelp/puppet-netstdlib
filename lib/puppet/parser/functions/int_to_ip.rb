require "ipaddr"
module Puppet::Parser::Functions

  newfunction(:int_to_ip, :type => :rvalue, :doc => <<-'ENDHEREDOC'
    Converts a dotted address of the form 192.168.0.1 into its 32 bit integer representation

    ENDHEREDOC
    ) do |args|

    unless args.length == 1 then
      raise Puppet::ParseError, ("int_to_ip(): wrong number of arguments (#{args.length}; must be 1)")
    end
    arg = args[0]
    unless arg.respond_to?('to_i') then
        raise Puppet::ParseError, ("#{arg.inspect} is not a integer. It looks to be a #{arg.class}")
    end

    arg = arg.to_i
    begin
      IPAddr.new(arg, Socket::AF_INET).to_s
    rescue ArgumentError => e
      raise Puppet::ParseError(e)
    end 
  end

end

