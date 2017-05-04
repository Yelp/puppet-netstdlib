require 'spec_helper'

describe 'cidr_to_range' do
  cidr = '192.168.1.0/29'

  it 'should return the range ips excluding the network and broadcast addresses' do
    ips = [
      '192.168.1.1',
      '192.168.1.2',
      '192.168.1.3',
      '192.168.1.4',
      '192.168.1.5',
      '192.168.1.6',
    ]
    should run.with_params(cidr).and_return(ips)
  end

  it 'should work' do
    expect { subject.call([cidr]) }.not_to raise_error()
  end

  it 'should fail with no args' do
    expect { subject.call([]) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with :undef' do
    expect { subject.call([:undef]) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with many args' do
    expect { subject.call(['foo', 'bar']) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail if given insane data type' do
    expect { subject.call([ [] ]) }.to raise_error(Puppet::ParseError)
  end
end
