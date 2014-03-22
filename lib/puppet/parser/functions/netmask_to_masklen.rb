module Puppet::Parser::Functions

  newfunction(:netmask_to_masklen, :type => :rvalue, :doc => <<-'ENDHEREDOC'
    Converts a netmask of the form 255.255.0.0 to the mask length (e.g. 16)

    ENDHEREDOC
    ) do |args|

    unless args.length == 1 then
      raise Puppet::ParseError, ("netmask_to_masklen(): wrong number of arguments (#{args.length}; must be 1)")
    end
    arg = args[0]
    unless arg.respond_to?('to_s') then
        raise Puppet::ParseError, ("#{arg.inspect} is not a string. It looks to be a #{arg.class}")
    end

    arg = arg.to_s
    begin
      IPAddr.new(arg).to_i.to_s(2).count('1')
    rescue ArgumentError => e
      raise Puppet::ParseError, (e)
    end
  end

end

