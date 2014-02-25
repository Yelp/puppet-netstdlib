require 'spec_helper'

describe 'fqdn_mac' do

  # TODO(fhats): Write more tests that pin the FQDN and expect a deterministic
  # MAC address. Can't quite do this yet because of the version of rspec-puppet
  # we're on and https://github.com/rodjek/rspec-puppet/issues/105

  it 'should work a single octet' do
    expect { subject.call(['52']) }.not_to raise_error()
  end
  it 'should work without a seed' do
    expect { subject.call(['52:54:00']) }.not_to raise_error()
  end

  it 'should work with a seed' do
    expect { subject.call(['52:54:00', "web-vm"]) }.not_to raise_error()
  end

  it 'should fail with an invalid mac' do
    expect { subject.call(['mac:address']) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with a whole mac' do
    expect { subject.call(['aa:bb:cc:dd:ee:ff']) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with a partial octet' do
    expect { subject.call(['a']) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with no args' do
    expect { subject.call([]) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with :undef' do
    expect { subject.call([:undef]) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with many args' do
    expect { subject.call(['foo', 'bar', 'baz']) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail if given insane data type' do
    expect { subject.call([ [] ]) }.to raise_error(Puppet::ParseError)
  end
end

