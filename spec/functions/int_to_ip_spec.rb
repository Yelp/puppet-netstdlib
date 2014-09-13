require 'spec_helper'

describe 'int_to_ip' do
  int = 3232235788

  it { should run.with_params(int).and_return('192.168.1.12') }

  it 'should work' do
    expect { subject.call([int]) }.not_to raise_error()
  end

  it 'should fail with no args' do
    expect { subject.call([]) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with foobar' do
    expect { subject.call(['foobar']) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail with many args' do
    expect { subject.call(['foo', 'bar']) }.to raise_error(Puppet::ParseError)
  end
  it 'should fail if given insane data type' do
    expect { subject.call([ [] ]) }.to raise_error(Puppet::ParseError)
  end
end

