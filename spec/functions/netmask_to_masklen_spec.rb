require 'spec_helper'

describe 'netmask_to_masklen' do
  { 
    '255.255.255.0' => 24,
    '255.255.255.128' => 25,
    '255.255.0.0' => 16,
  }.each do |mask, len|
    it { should run.with_params(mask).and_return(len) }
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

