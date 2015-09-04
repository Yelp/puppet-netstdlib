require 'uri'

module Puppet::Parser::Functions
  newfunction(:parse_http_uri, :type => :rvalue) do |args|
    raise(Puppet::ParseError,
          'parse_http_uri: wrong number of args') if args.size != 1

    begin
      uri = URI(args.first)
      raise "Only supports http or https" unless uri.scheme.downcase =~ /^http/
    rescue => e
      raise Puppet::ParseError, "bad arg in parse_http_uri - '#{args.inspect}': #{e}"
    end

    {
      'scheme' => uri.scheme.downcase,
      'host'   => uri.host.downcase,
      'path'   => uri.path.empty? ? '/' : uri.path,
    }
  end
end
