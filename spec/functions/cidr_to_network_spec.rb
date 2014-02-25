require 'spec_helper'

describe 'cidr_to_network' do
  cidr = '192.168.1.12/24'

  it { should run.with_params(cidr).and_return('192.168.1.0') }

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

