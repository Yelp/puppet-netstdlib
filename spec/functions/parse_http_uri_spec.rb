require 'spec_helper'

describe 'parse_http_uri' do

  it 'should fail with no args' do
    expect { subject.call([]) }.to \
      raise_error Puppet::ParseError, /number of args/
  end

  it 'should fail with many args' do
    expect { subject.call([:undef, :undef1]) }.to \
      raise_error Puppet::ParseError, /number of args/
  end

  it 'should fail with non-http uri' do
    expect { subject.call(['smtp://foo.bar']) }.to \
      raise_error Puppet::ParseError, /http or https/
  end

  it 'should fail with undef' do
    expect { subject.call([:undef]) }.to \
      raise_error Puppet::ParseError, /bad argument/
  end

  it 'should fail with insane data type' do
    expect { subject.call([ [] ]) }.to \
      raise_error Puppet::ParseError, /bad argument/
  end

  it 'should work for http uri' do
    should run.with_params('HTTP://example.com').and_return({
      'scheme' => 'http',
      'host'   => 'example.com',
      'path'   => '/',
    })
  end

  it 'should work for http with trailing / and no path' do
    should run.with_params('http://example.com/').and_return({
      'scheme' => 'http',
      'host'   => 'example.com',
      'path'   => '/',
    })
  end

  it 'should work for https uri' do
    should run.with_params('https://example.COM/foo/BAR').and_return({
      'scheme' => 'https',
      'host'   => 'example.com',
      'path'   => '/foo/BAR',
    })
  end

end
