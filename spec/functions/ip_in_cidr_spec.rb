require 'spec_helper'

describe 'ip_in_cidr' do
  cidr = '192.168.1.12/24'

  [
    '192.168.1.0',
    '192.168.1.12',
    '192.168.1.255',
    '192.168.1.66'
  ].each do |ip|
    it { should run.with_params(ip, cidr).and_return true }
  end

  [
    '192.168.0.255',
    '255.255.255.0'
  ].each do |ip|
    it { should run.with_params(ip, cidr).and_return false }
  end

  it 'should work' do
    expect { subject.call(['17.0.0.1', cidr]) }.not_to raise_error()
  end

  it 'should fail with no args' do
    expect { subject.call([]) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with one args' do
    expect { subject.call(['foo']) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with many args' do
    expect { subject.call(['foo', 'bar', 'baz']) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail if given insane data type' do
    expect { subject.call([ [] ]) }.to raise_error(Puppet::ParseError)
  end
end

