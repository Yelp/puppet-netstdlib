require 'spec_helper'

describe 'ips_in_netblocks' do
  netblocks = ['192.168.0.0/24']
  ips = ['192.168.0.1']

  it { should run.with_params(ips, netblocks).and_return(true) }

  it 'should work' do
    expect { subject.call([ips, netblocks]) }.not_to raise_error()
  end

  it 'should fail with no args' do
    expect { subject.call([]) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with :undef' do
    expect { subject.call([:undef, netblocks]) }.to raise_error(Puppet::ParseError)
    expect { subject.call([ips, :undef]) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with many args' do
    expect { subject.call(['foo', 'bar', 'quux']) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail if given insane data type' do
    expect { subject.call([ {}, netblocks ]) }.to raise_error(Puppet::ParseError)
  end
end

