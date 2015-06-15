require 'ipaddr'

module Puppet::Parser::Functions
  #Returns true if, for each IP in the first argument, a netblock containing it
  #is within those specified in the second netblock.
  newfunction(:ips_in_netblocks, :type => :rvalue) do |args|

    if args.size != 2
       raise Puppet::ParseError, ("Wrong number of arguments: expecting 2")
    end

    check_ips = args[0]
    netblocks = args[1]
    valid_ips = []

    if !check_ips.kind_of?(Array) or !netblocks.kind_of?(Array)
      raise Puppet::ParseError, ("Wrong type of arguments: expecting arrays")
    end

    if check_ips.empty? or netblocks.empty?
      raise Puppet::ParseError, ("Invalid arguments: zero-length arrays are illegal")
    end

    check_ips.each do |ipaddress|
      netblocks.each do |netblock|
        if IPAddr.new(netblock).include? IPAddr.new(ipaddress)
          valid_ips.push(ipaddress)
        end
      end
    end
    if check_ips.size == valid_ips.size
      true
    else
      false
    end
  end
end
