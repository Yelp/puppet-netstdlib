module IPAddrSubnetExtension
  def subnet_mask
    return _to_string(@mask_addr)
  end
end

module Puppet::Parser::Functions

  newfunction(:cidr_to_netmask, :type => :rvalue, :doc => <<-'ENDHEREDOC'
    Converts an CIDR address of the form 192.168.0.1/24 into its netmask.

    ENDHEREDOC
    ) do |args|

    unless args.length == 1 then
      raise Puppet::ParseError, ("cidr_to_netmask(): wrong number of arguments (#{args.length}; must be 1)")
    end
    arg = args[0]
    unless arg.respond_to?('to_s') then
        raise Puppet::ParseError, ("#{arg.inspect} is not a string. It looks to be a #{arg.class}")
    end

    arg = arg.to_s
    begin
        IPAddr.new(arg).extend(IPAddrSubnetExtension).subnet_mask.to_s
    rescue ArgumentError => e
      raise Puppet::ParseError, (e)
    end
  end

end

